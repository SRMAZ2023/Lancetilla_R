import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { ManteniminetoXAnimalViewModel } from 'src/app/demo/Models/ManteniminetoXAnimalViewModel';
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
import { error } from 'console';
import { DatePipe } from '@angular/common';

import { LocalStorageService } from '../../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';


interface expandedRows {
    [key: string]: boolean;
}

@Component({
    templateUrl: './MantenimientoPorAnimal.html',
    providers: [MessageService, ManteniminetoXAnimalService, DatePipe]
})
export class MantenimientoPorAnimalComponent implements OnInit {

    //Dialogs
    MantenimientoPorAnimaltDialog: boolean = false;

    
  EsAdmin: any;
  Permiso: any;

    deleteMantenimientoPorAnimalDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    MantenimientoPorAnimal: ManteniminetoXAnimalViewModel[] = [];
    mantenimientoXanimal: ManteniminetoXAnimalViewModel = {};

    //Paginacion de el datatable
    selectedMantenimientoPorAnimal: ManteniminetoXAnimalViewModel[] = [];
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

    expandedRows: ManteniminetoXAnimalViewModel[] = [];
    expandedRow: any = null;

    Animal: any;

    Roles: ManteniminetoXAnimalViewModel[] = [];
    Pantallass: ManteniminetoXAnimalViewModel[] = [];

    Rol: ManteniminetoXAnimalViewModel = {};



    constructor( private _router: Router ,
      private localStorage: LocalStorageService,private ManteniminetoXAnimalService: ManteniminetoXAnimalService, private datePipe: DatePipe, private messageService: MessageService) {
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('MantenimientoPorAnimal')}

    ngOnInit() {

      if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

        if (this.EsAdmin == false) {

            if (this.Permiso == false) {
                this._router.navigate(['login']);
            }              
        }

    }else{

        this._router.navigate(['login']);
    }

        // Obtén la fecha del API
        this.ManteniminetoXAnimalService.getManteniminetoXAnimal().subscribe(
            Response => {
                 this.datos = Response;
        
                // Filtrar los elementos duplicados por anim_Id
                const uniqueAnimals = this.datos.filter((valorActual: { anim_Id: any; }, indiceActual: any, arreglo: { anim_Id: any; }[]) => {
                    return arreglo.findIndex((elemento: { anim_Id: any; }) => elemento.anim_Id === valorActual.anim_Id) === indiceActual;
                });
        
                this.Roles = uniqueAnimals;
        
                 console.log( this.Roles)
                this.formattedDate = this.datePipe.transform(this.datos.maan_Fecha, 'yyyy-MM-dd')?.toString();
        
             },
            error => {
                console.log(error);
            }
        );
        

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'maan_Id', header: 'maan_Id' },
            { field: 'anim_Nombre', header: 'anim_Nombre' },
            { field: 'maan_Fecha', header: 'maan_Fecha' },
            { field: 'tima_Descripcion', header: 'tima_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.MantenimientoPorAnimaltDialog = false;
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
        this.mantenimientoXanimal = {};
        this.submitted = false;
        this.MantenimientoPorAnimaltDialog = true;
    }
    //Metodo que activa el dialog

    //Toma el id del item
    deleteMantenimientoPorAnimal(MantenimientoPorAnimal: ManteniminetoXAnimalViewModel) {
        this.deleteMantenimientoPorAnimalDialog = true;
        this.mantenimientoXanimal = { ...MantenimientoPorAnimal };
    }
    //Toma el id del item
    emmmm:ManteniminetoXAnimalViewModel = {}
    mante:ManteniminetoXAnimalViewModel = {};
    
    
    Pantallas(Roles: ManteniminetoXAnimalViewModel) {
        this.Rol = { ...Roles };
      
        var params = {
          "anim_Id": this.Rol.anim_Id
        };
      
        console.log(params);
        this.ManteniminetoXAnimalService.GetAnimalesXMantenimineto(params).subscribe(
          Response => {
            this.datos = Response;
            console.log(this.datos);
      
            // Verificar si la fila seleccionada ya está expandida
            const index = this.expandedRows.findIndex(row => row.anim_Id === this.Rol.anim_Id);
            if (index > -1) {
              // La fila está expandida, la contraemos para ocultarla
              this.expandedRows.splice(index, 1);
              this.expandedRow = null;
            } else {
              // Cerrar todas las filas expandidas
              this.expandedRows = [];
      
              // Expandir la fila seleccionada
              const selectedRow = this.Roles.find(row => row.anim_Id === this.Rol.anim_Id);
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
        this.deleteMantenimientoPorAnimalDialog = false;
        var maan_Id = this.mantenimientoXanimal.maan_Id;
        var params = {
            "maan_Id": this.mantenimientoXanimal.maan_Id,
            "plan_UserCreacion": 1,
            "plan_UserModificacion": 1
        }
        console.log(params)
        this.ManteniminetoXAnimalService.DeleteManteniminetoXAnimal(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.MantenimientoPorAnimal = this.MantenimientoPorAnimal.filter(val => val.maan_Id !== this.mantenimientoXanimal.maan_Id);


                } else {
                    this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
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
