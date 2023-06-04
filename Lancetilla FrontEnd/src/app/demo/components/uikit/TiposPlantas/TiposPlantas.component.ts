import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { TiposDeMantenimientoService } from 'src/app/demo/service/TipoDeMantenimiento.service';
import { TipoDeMatenimientoViewModel } from 'src/app/demo/Models/TipoDeManteniminetoViewModel';
import { Console, error } from 'console';
import { TiposPlantasService } from 'src/app/demo/service/TiposPlantas.service';
import { TiposPlantasViewModel } from 'src/app/demo/Models/TiposPlantasViewModel';
import { ReinosViewModel } from 'src/app/demo/Models/ReinosViewModel';
import { ReinosService } from 'src/app/demo/service/Reinos.service';
import { DatePipe } from '@angular/common';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
    templateUrl: './TiposPlantas.component.html',
    providers: [MessageService, TiposPlantasService, ReinosService, DatePipe]
})
export class TiposPlantasComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;
    //Dialogs
    TiposPlantasDialog: boolean = false;
    NuevoDIalog: boolean = false;

    deleteTiposPlantasDialog: boolean = false;
    //Dialogs

    datos: any = {};

    first: number = 0;
    rows: number = 10;

    cols: any[] = []; // Aquí debes definir las columnas de tu tabla

    onPageChange(event: any) {
        this.first = event.first;
        this.rows = event.rows;
    }
    onRowsPerPageChange() {
        this.first = 0;
    }



    public Editar: boolean = false;
    TiPlantas: TiposPlantasViewModel[] = [];
    TiPlanta: TiposPlantasViewModel = {};
    reino: ReinosViewModel[] = [];


    //Paginacion de el datatable
    selectedTiposPlantas: TiposPlantasViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;



    statuses: any[] = [];


    constructor(
        private _router: Router ,
        private localStorage: LocalStorageService,private TiposPlantasService: TiposPlantasService,
        private ReinosServices: ReinosService,
        private messageService: MessageService,) {
            
   this.EsAdmin = this.localStorage.getItem('EsAdmin')
   this.Permiso = this.localStorage.getItem('TiposDePlantas')
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
   

    expandedRows: TiposPlantasViewModel[] = [];
    expandedRow: any = null;

    Animales(tiposPlantas: TiposPlantasViewModel) {
        this.TiPlanta = { ...tiposPlantas };
        var params = {
          "tipl_Id": this.TiPlanta.tipl_Id
        };
      
        console.log(params);
        this.TiposPlantasService.GetPlantasPorTipo(params).subscribe(
          Response => {
            this.datos = Response;
            console.log(this.datos);
      
            // Verificar si la fila seleccionada ya está expandida
            const index = this.expandedRows.findIndex(row => row.tipl_Id === this.TiPlanta.tipl_Id);
            if (index > -1) {
              // La fila está expandida, la contraemos para ocultarla
              this.expandedRows.splice(index, 1);
              this.expandedRow = null;
            } 
            else {
              // Cerrar todas las filas expandidas
              this.expandedRows = [];
      
              // Expandir la fila seleccionada
              const selectedRow = this.TiPlantas.find(row => row.tipl_Id === this.TiPlanta.tipl_Id);
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
      
      formattedDate: string | undefined;


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

        this.TiposPlantasService.getTiposPlantas().subscribe(
            Response => {
                 this.datos = Response;
        
                // Filtrar los elementos duplicados por anim_Id
                const uniqueAnimals = this.datos.filter((valorActual: { plan_Id: any; }, indiceActual: any, arreglo: { plan_Id: any; }[]) => {
                    return arreglo.findIndex((elemento: { plan_Id: any; }) => elemento.plan_Id === valorActual.plan_Id) === indiceActual;
                });
        
                this.TiPlantas = uniqueAnimals;
        
        
             },
            error => {
                console.log(error);
            }
        );

        //Trae los datos de la api
        this.loadData();
        //Trae los datos de la api

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'tipl_Id', header: 'tipl_Id' },
            { field: 'tipl_NombreComun', header: 'tipl_NombreComun' },
            { field: 'tipl_NombreCientifico', header: 'tipl_NombreCientifico' },
            { field: 'rein_Descripcion', header: 'rein_Descripcion' },

        ];
        this.ReinosServices.getReinos().subscribe(
            Response => {
                this.reino = Response.map((item: { rein_Descripcion: any; rein_Id: any; }) => ({ label: item.rein_Descripcion, value: item.rein_Id }));

            },
            Error => { }
        )



    }

    //trae los datos
    private loadData() {
        this.TiposPlantasService.getTiposPlantas().subscribe(
            Response => {
                console.log(Response);
                this.TiPlantas = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //trae los datos

    //Metodo que desactiva el dialog
    hideDialog() {
        this.NuevoDIalog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
     

    openNew() {
        console.log('dio click')
        this.TiPlanta = {};
         this.submitted = false;
        this.NuevoDIalog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editTiposPlantas(TiPla: TiposPlantasViewModel) {
        this.Editar = true;
        this.TiPlanta = { ...TiPla };
        this.NuevoDIalog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteTiposPlantas(TiPla: TiposPlantasViewModel) {
        this.deleteTiposPlantasDialog = true;
        this.TiPlanta = { ...TiPla };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteTiposPlantasDialog = false;
        var params = {
            "tima_Id": this.TiPlanta.tipl_Id,
            "tima_Descripcion": "",
            "tima_UserCreacion": 1,
            "tima_UserModificacion": 1
        }
        console.log(params)
        this.TiposPlantasService.DeleteTiposPlantas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.TiPlantas = this.TiPlantas.filter(val => val.tipl_Id !== this.TiPlanta.tipl_Id);
                    this.loadData();

                } else {
                    this.messageService.add({ severity: 'warn', summary: 'Error:', detail: this.datos.message, life: 3000 });
                }
            },
            error => {
                console.log("manzana")
            }
        );

    }
    //Confirma el eliminar

    isInputEmptyOrWhitespace(value: string | undefined): boolean {
        if (value === undefined) {
            return true; // Tratar 'undefined' como un valor vacío
        }

        return value.trim() === '';
    }


    //Enviamos y editamos datos
    saveTiposPlantas() {
        this.submitted = true;

        var params = {
            "tipl_Id": this.TiPlanta.tipl_Id,
            "tipl_NombreComun": this.TiPlanta.tipl_NombreComun ? this.TiPlanta.tipl_NombreComun.trim() : '',
            "rein_Id": this.TiPlanta.rein_Id ? this.TiPlanta.rein_Id : 0,
            "tipl_NombreCientifico": this.TiPlanta.tipl_NombreCientifico ? this.TiPlanta.tipl_NombreCientifico.trim() : '',
            "tipl_UserCreacion": 1,
            "tipl_UserModificacion": 1
        }


        console.log(params)

        if (params.tipl_NombreComun === "" || params.tipl_NombreCientifico === "" || params.rein_Id === 0) {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        else {
            //Validacion de params
            if (params.tipl_NombreComun !== undefined &&
                params.tipl_NombreComun.trim() !== '' &&
                params.tipl_NombreCientifico !== undefined &&
                params.tipl_NombreCientifico.trim() !== '' &&
                params.rein_Id !== undefined &&
                params.rein_Id !== 0 &&
                params.tipl_UserCreacion !== undefined &&
                params.tipl_UserModificacion !== undefined) {

                //Si insertara o editara
                if (!this.Editar) {

                    this.TiposPlantasService.postTiposPlantas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.TiPlanta = {};
                                this.TiposPlantasDialog = false;
                                this.loadData();


                            } else {
                                this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )

                } else {
                    this.TiposPlantasService.EditTiposPlantas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            console.log(this.datos.messageService)
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.TiPlanta = {};
                                this.NuevoDIalog = false;
                                this.loadData();


                            } else {
                                this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )

                }


            }
        }
        //Enviamos y editamos datos
    }




    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
