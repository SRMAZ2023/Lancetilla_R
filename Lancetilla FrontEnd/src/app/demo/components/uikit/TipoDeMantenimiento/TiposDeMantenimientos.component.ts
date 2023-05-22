import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { TiposDeMantenimientoService } from 'src/app/demo/service/TipoDeMantenimiento.service';
import { TipoDeMatenimientoViewModel } from 'src/app/demo/Models/TipoDeManteniminetoViewModel';
import { Console, error } from 'console';

@Component({
    templateUrl: './TiposDeMantenimientos.component.html',
    providers: [MessageService, TiposDeMantenimientoService]
})
export class TiposDeMantenimientosComponent implements OnInit {

    //Dialogs
    TiposDeMantenimientostDialog: boolean = false;

    deleteTiposDeMantenimientosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos:any = {};


    public Editar: boolean = false;
    TiposDeMantenimientos: TipoDeMatenimientoViewModel[] = [];
    TiposDeMantenimiento: TipoDeMatenimientoViewModel = {};

    //Paginacion de el datatable
    selectedTiposDeMantenimientos: TipoDeMatenimientoViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];


    constructor(private TiposDeMantenimientosService: TiposDeMantenimientoService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.TiposDeMantenimientosService.getTiposDeMantenimientos().subscribe(
            Response => {
                console.log(Response);
                this.TiposDeMantenimientos = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'tima_Id', header: 'tima_Id' },
            { field: 'tima_Descripcion', header: 'tima_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.TiposDeMantenimientostDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.TiposDeMantenimiento = {};
        this.submitted = false;
        this.TiposDeMantenimientostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editTiposDeMantenimientos(TiposDeMantenimientos: TipoDeMatenimientoViewModel) {
        this.Editar = true;
        this.TiposDeMantenimiento = { ...TiposDeMantenimientos };
        this.TiposDeMantenimientostDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteTiposDeMantenimientos(TiposDeMantenimientos: TipoDeMatenimientoViewModel) {
        this.deleteTiposDeMantenimientosDialog = true;
        this.TiposDeMantenimiento = { ...TiposDeMantenimientos };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteTiposDeMantenimientosDialog = false;
        this.TiposDeMantenimientos = this.TiposDeMantenimientos.filter(val => val.tima_Id !== this.TiposDeMantenimiento.tima_Id);
        var params = {
            "tima_Id": this.TiposDeMantenimiento.tima_Id,
            "tima_Descripcion": "",
            "tima_UserCreacion": 1,
            "tima_UserModificacion": 1
        }
        console.log(params)
        this.TiposDeMantenimientosService.DeleteTiposDeMantenimientos(params).subscribe(
            Response => {
                if (Response) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva TiposDeMantenimiento', life: 3000 });
                    console.log("esta dentrando")
                    this.TiposDeMantenimiento = {};

                } else {
                    this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
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
    saveTiposDeMantenimientos() {
        this.submitted = true;

        var params = {
            "tima_Id": this.TiposDeMantenimiento.tima_Id,
            "tima_Descripcion": this.TiposDeMantenimiento.tima_Descripcion!.trim(),
            "tima_UserCreacion": 1,
            "tima_UserModificacion": 1
        }


        console.log(params)

        //Validacion de params
        if (params.tima_Descripcion !== undefined &&
            params.tima_Descripcion.trim() !== '' &&
            params.tima_UserCreacion !== undefined &&
            params.tima_UserModificacion !== undefined) {
            
            //Si insertara o editara
            if (!this.Editar) {

                this.TiposDeMantenimientosService.postTiposDeMantenimientos(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if(this.datos.code == 409){
                            
                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        }else  if (this.datos.code  == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.TiposDeMantenimiento = {};
                            this.TiposDeMantenimientostDialog = false;
                            
                        } else  {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.TiposDeMantenimientosService.EditTiposDeMantenimientos(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if(this.datos.code == 409){
                            
                            this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                        }else  if (this.datos.code  == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.TiposDeMantenimiento = {};
                            this.TiposDeMantenimientostDialog = false;
                            
                        } else  {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
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



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
