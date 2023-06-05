import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
// import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
// import { AreaBotanicaService } from 'src/app/demo/service/ManteniminetoXAnimal.service';

// import { AreaBotanicaService } from 'src/app/demo/service/CuidadoPlantas.service';
//import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { error } from 'console';
import { DatePipe } from '@angular/common';
import { LocalStorageService } from '../../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

//Areas
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';

import { CuidadoPlantasService } from 'src/app/demo/service/CuidadoPlantas.service';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
interface expandedRows {
    [key: string]: boolean;
}

@Component({
    templateUrl: './CuidadoPlantas.html',
    providers: [MessageService, AreaBotanicaService, CuidadoPlantasService,DatePipe]
})
export class CuidadoPlantasComponent implements OnInit {

  EsAdmin: any;
  Permiso: any;

    //Dialogs
    CuidadoPlantastDialog: boolean = false;

    deleteCuidadoPlantasDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    CuidadoPlantas: AreaBotanicaViewModel[] = [];
    CuidadoPlanta: AreaBotanicaViewModel = {};

    //Paginacion de el datatable
    selectedCuidadoPlantas: AreaBotanicaViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
     submitted: boolean = false;
    isExpanded: boolean = false;
    first: number = 0;
    rows: number = 10;

    onPageChange(event: any) {
        this.first = event.first;
        this.rows = event.rows;
    }

    onRowsPerPageChange() {
        this.first = 0; 
      }

    cols: any[] = [];

    statuses: any[] = [];
    formattedDate: string | undefined;
    formattedDate3!: Date;

    expandedRows: AreaBotanicaViewModel[] = [];
    expandedRow: any = null;

    Animal: any;

    Roles: AreaBotanicaViewModel[] = [];
    Pantallass: AreaBotanicaViewModel[] = [];

    Rol: AreaBotanicaViewModel = {};



    constructor( private _router: Router ,
      private localStorage: LocalStorageService,private AreaBotanicaService: AreaBotanicaService,private cuidadosPLANTAS: CuidadoPlantasService, private datePipe: DatePipe, private messageService: MessageService) {
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('CuidadoDePlantas')}

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

        // Obtén la fecha del API
        
        
           this. getArea();
        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'arbo_Id', header: 'arbo_Id' },
            { field: 'arbo_Descripcion', header: 'arbo_Descripcion' },
 
        ];
        //Modelo de los datos de la tabla

    }

    getArea(){
      this.AreaBotanicaService.getAreaBotanica().subscribe(
        Response => {
             this.datos = Response;
    
            // Filtrar los elementos duplicados por arbo_Id
            const uniqueAnimals = this.datos.filter((valorActual: { arbo_Id: any; }, indiceActual: any, arreglo: { arbo_Id: any; }[]) => {
                return arreglo.findIndex((elemento: { arbo_Id: any; }) => elemento.arbo_Id === valorActual.arbo_Id) === indiceActual;
            });
    
            this.Roles = uniqueAnimals;
    
             console.log( this.Roles)
            this.formattedDate = this.datePipe.transform(this.datos.cupl_Fecha, 'yyyy-MM-dd')?.toString();
    
         },
        error => {
            console.log(error);
        }
    );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.CuidadoPlantastDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

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

    //Metodo que activa el dialog
    openNew() {
        this.CuidadoPlanta = {};
        this.submitted = false;
        this.CuidadoPlantastDialog = true;
    }
    //Metodo que activa el dialog

    //Toma el id del item
    deleteCuidadoPlantas(CuidadoPlantas: AreaBotanicaViewModel) {
        this.deleteCuidadoPlantasDialog = true;
        this.CuidadoPlanta = { ...CuidadoPlantas };
    }
    //Toma el id del item
    emmmm:AreaBotanicaViewModel = {}
    mante:AreaBotanicaViewModel = {};
    
    
    Pantallas(Roles: AreaBotanicaViewModel) {
        this.Rol = { ...Roles };
      
        var params = {
          "arbo_Id": this.Rol.arbo_Id
        };
      
        console.log(params);
        this.cuidadosPLANTAS.postBuscarPlantas2(params).subscribe(
          Response => {
            this.datos = Response;
            console.log(this.datos);
      
            // Verificar si la fila seleccionada ya está expandida
            const index = this.expandedRows.findIndex(row => row.arbo_Id === this.Rol.arbo_Id);
            if (index > -1) {
              // La fila está expandida, la contraemos para ocultarla
              this.expandedRows.splice(index, 1);
              this.expandedRow = null;
            } else {
              // Cerrar todas las filas expandidas
              this.expandedRows = [];
      
              // Expandir la fila seleccionada
              const selectedRow = this.Roles.find(row => row.arbo_Id === this.Rol.arbo_Id);
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
      

    //Confirma el eliminar
    confirmDelete() {
        this.deleteCuidadoPlantasDialog = false;
         var params = {
            "arbo_Id": this.CuidadoPlanta.arbo_Id,
          }
        console.log(params)
        this.cuidadosPLANTAS.DeleteCuidadoPlantas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {
                  this.deleteCuidadoPlantasDialog = false;

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.CuidadoPlantas = this.CuidadoPlantas.filter(val => val.arbo_Id !== this.CuidadoPlanta.arbo_Id);
                    this.deleteCuidadoPlantasDialog = false;
                    this. getArea();

 
                } else {
                    this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
                    this.deleteCuidadoPlantasDialog = false;

                  }
            },
            error => {
                console.log("manzana")
            }
        );

    }
    //Confirma el eliminar

    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
