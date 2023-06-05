import { Component, OnInit } from '@angular/core';
import { pagoViewModel } from 'src/app/demo/Models/PagoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MetodosPagoService } from 'src/app/demo/service/Pago.service';
import { error } from 'console';
import { VisitantesService } from 'src/app/demo/service/Visitantes.servicel';
import { VisitantesViewModel } from 'src/app/demo/Models/VisitantesViewModel';
import { ViewChild } from '@angular/core';
import * as moment from 'moment';


import { ContextMenu } from 'primeng/contextmenu';

import { MegaMenuItem, MenuItem } from 'primeng/api';

import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';

//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
    templateUrl: './visitantes.component.html',
    providers: [MessageService, VisitantesService]
})
export class visitantesComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;

    //Dialogs
    visitanteDialog: boolean = false;

    //datos
    datos:any = {};

    DetallesFactura:any = {};

    public Editar: boolean = false;
    visitantes: VisitantesViewModel[] = [];
    visitante: VisitantesViewModel = {};

    //validar espacio
    espacio: boolean = false;

    tieredItems: MenuItem[] = [];

    //Paginacion de el datatable
    selectedVisitante: VisitantesViewModel[] = [];
    expandedRows: VisitantesViewModel[] = [];

    
    expandedRow: any = null;
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    first: number = 0;
    rows: number = 10;

    Rol: FacturasViewModel = {};

    

    cols: any[] = []; // Aquí debes definir las columnas de tu tabla

    onPageChange(event: any) {
        this.first = event.first;
        this.rows = event.rows;
    }

    onRowsPerPageChange() {
        this.first = 0; 
      }
  

      hideDialog() {
        this.visitanteDialog = false;    
    }

    statuses: any[] = [];


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private VisitanteService: VisitantesService, private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Visitantes')}

    ngOnInit() {

        if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

            if (this.EsAdmin == false) {

                if (this.Permiso == false) {
                  this._router.navigate(['/app']);
                }              
            }
    
        }else{

            this._router.navigate(['login']);
        }

        this.VisitanteService.getVisitantes().subscribe(
            Response => {
            
                this.visitantes = Response
               
            },
            error => (
                console.log(error)
            )
        );

        this.cols = [
            { field: 'visi_Id',          header: 'visi_Id' },
            { field: 'visi_Nombre', header: 'visi_Nombre' },
            { field: 'visi_RTN', header: 'visi_RTN' },
            { field: 'visi_Sexos',          header: 'visi_Sexos' },

        ];

    }

     


    toggleRow(row: any) {
        if (this.isRowExpanded(row)) {
          this.expandedRow = null;
        } else {
          this.expandedRow = row;
        }
      }
      
      isRowExpanded(row: any): boolean {
        return this.expandedRow === row;
      }


    Pantallas(Roles: VisitantesViewModel) {
        this.Rol = { ...Roles };
      
      
        
        var params = {
          "visi_Id": this.Rol.visi_Id
        };
      
      
        this.VisitanteService.FacturasPorVisitante(params).subscribe(
          Response => {
            this.datos = Response;
            this.datos.forEach((dato : any) => {
              const fechaCreacion = moment(dato.fact_Fecha).format('DD/MM/YYYY HH:mm:ss');
              dato.fact_Fecha = fechaCreacion;
            });

            // Verificar si la fila seleccionada ya está expandida
            const index = this.expandedRows.findIndex(row => row.visi_Id === this.Rol.visi_Id);
            if (index > -1) {
              // La fila está expandida, la contraemos para ocultarla
              this.expandedRows.splice(index, 1);
              this.expandedRow = null;
            } else {
              // Cerrar todas las filas expandidas
              this.expandedRows = [];
      
              // Expandir la fila seleccionada
              const selectedRow = this.visitantes.find(row => row.visi_Id === this.Rol.visi_Id);
              if (selectedRow) {
                this.expandedRows.push(selectedRow);
                this.expandedRow = selectedRow;
              }
            }
       
           
          },

          

          
          error => {
            console.log("manzana");
          }
        );
      }
   
      Detalles(datos2: FacturasViewModel){
        
        this.DetallesFactura = datos2
     
        console.log(  this.DetallesFactura)
        console.log(this.DetallesFactura.ticket_JardinBotanico)
      console.log(this.DetallesFactura.ticket_Zoologico)
    
       

        this.visitanteDialog = true

      }

      Factura(datos3: FacturasViewModel){
       
  
  
        
        console.log(this.expandedRows[0].visi_Id)

          console.log(datos3.fact_Id)

          
          this.localStorage.setItem('VisitanteID', this.expandedRows[0].visi_Id);

          this.localStorage.setItem('FacturaID', datos3.fact_Id);

          
          
          setTimeout(() => {
           
            this._router.navigate(['/app/uikit/Reporte Factura']);
       
          }, 1000);
  
    }
  
      



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
