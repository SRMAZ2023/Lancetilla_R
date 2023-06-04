import { Component, OnInit } from '@angular/core';
import { pagoViewModel } from 'src/app/demo/Models/PagoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MetodosPagoService } from 'src/app/demo/service/Pago.service';
import { error } from 'console';
//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
    templateUrl: './MetodoPago.component.html',
    providers: [MessageService, MetodosPagoService]
})
export class MetodoPagoComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;
    //Dialogs
    MetodoPagotDialog: boolean = false;

    deleteMetodoPagoDialog: boolean = false;

    deleteMetodoPagosDialog: boolean = false;
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
  
    //Dialogs

    //datos
    datos: any = {};

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

 

    statuses: any[] = [];


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private MetodosPagoService: MetodosPagoService, private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('MétodosDePago')}

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
            this.loadData();
        this.cols = [
            { field: 'meto_Id', header: 'meto_Id' },
            { field: 'meto_Descripcion', header: 'meto_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }
    private loadData() {
        this.MetodosPagoService.getMetodosDePago().subscribe(
            Response => {
                console.log(Response);
                this.MetodoPago = Response
            },
            error => (
                console.log(error)
            )
        );
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
        var params = {
            "meto_Id": this.Pago.meto_Id,
            "meto_Descripcion": "",
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }

        this.MetodosPagoService.DeleteMetodosDePago(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Pago = {};
                    this.MetodoPagotDialog = false;
                    this.MetodoPago = this.MetodoPago.filter(val => val.meto_Id !== this.Pago.meto_Id);
                    this.loadData();


                } else {
                    this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
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
            "meto_Descripcion": this.Pago.meto_Descripcion ? this.Pago.meto_Descripcion.trim() : '',
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }


        if (this.Pago.meto_Descripcion?.trim() == '') {
            console.log(this.Pago.meto_Descripcion?.toString().length);
            this.espacio = true;
        }

        if (params.meto_Descripcion === "") {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else {
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
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Pago = {};
                                this.MetodoPagotDialog = false;
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
                    this.MetodosPagoService.EditMetodosDePago(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Pago = {};
                                this.MetodoPagotDialog = false;
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
