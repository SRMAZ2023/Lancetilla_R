import { Component, OnInit } from '@angular/core';
import { pagoViewModel } from 'src/app/demo/Models/PagoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MetodosPagoService } from 'src/app/demo/service/Pago.service';
import { error } from 'console';
//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';

@Component({
    templateUrl: './MetodoPago.component.html',
    providers: [MessageService, MetodosPagoService]
})
export class MetodoPagoComponent implements OnInit {

    //Dialogs
    MetodoPagotDialog: boolean = false;

    deleteMetodoPagoDialog: boolean = false;

    deleteMetodoPagosDialog: boolean = false;
    //Dialogs

    //datos
    datos:any = {};

    public Editar: boolean = false;
    MetodoPago: pagoViewModel[] = [];
    Pago: pagoViewModel = {};

    //validar espacio
    espacio: boolean = false;

    //Paginacion de el datatable
    selectedMetodoPago: pagoViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];


    constructor(private MetodosPagoService: MetodosPagoService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.MetodosPagoService.getMetodosDePago().subscribe(
            Response => {
                console.log(Response);
                this.MetodoPago = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'meto_Id', header: 'meto_Id' },
            { field: 'meto_Descripcion', header: 'meto_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.MetodoPagotDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Pago = {};
        this.submitted = false;
        this.MetodoPagotDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editMetodoPago(MetodoPago: pagoViewModel) {
        this.Editar = true;
        this.Pago = { ...MetodoPago };
        this.MetodoPagotDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteMetodoPago(MetodoPago: pagoViewModel) {
        this.deleteMetodoPagoDialog = true;
        this.Pago = { ...MetodoPago };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteMetodoPagoDialog = false;
        this.MetodoPago = this.MetodoPago.filter(val => val.meto_Id !== this.Pago.meto_Id);
        var params = {
            "meto_Id": this.Pago.meto_Id,
            "meto_Descripcion": this.Pago.meto_Descripcion!.trim(),
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }



        console.log(params)
        this.MetodosPagoService.DeleteMetodosDePago(params).subscribe(
            Response => {
                if (Response) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Pago', life: 3000 });
                    console.log("esta dentrando")
                    this.Pago = {};

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
    saveMetodoPago() {
        this.submitted = true;

        var params = {
            "meto_Id": this.Pago.meto_Id,
            "meto_Descripcion": this.Pago.meto_Descripcion!.trim(),
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }


        if (this.Pago.meto_Descripcion?.trim() == '') {
            console.log(this.Pago.meto_Descripcion?.toString().length);
            this.espacio = true;
        }

        //Validacion de params
        if (params.meto_Descripcion !== undefined &&
            params.meto_Descripcion.trim() !== '' &&
            params.meto_UserCreacion !== undefined &&
            params.meto_UserModificacion !== undefined) {

            //Si insertara o editara
            if (!this.Editar) {

                this.MetodosPagoService.postMetodosDePago(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if(this.datos = 409){
                            this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                        }else  if (this.datos = 200) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Pago', life: 3000 });
                            console.log("esta dentrando")
                            this.Pago = {};
                            this.MetodoPagotDialog = false;

                        } else  {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.MetodosPagoService.EditMetodosDePago(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Pago', life: 3000 });
                            console.log("esta dentrando")
                            this.Pago = {};
                            this.MetodoPagotDialog = false;


                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
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
