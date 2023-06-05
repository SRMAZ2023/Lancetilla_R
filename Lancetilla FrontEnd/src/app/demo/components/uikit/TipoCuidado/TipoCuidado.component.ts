import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { TiposCuidadosService } from 'src/app/demo/service/TiposCuidadios.Service';
import { TiposCuidadosViewModel } from 'src/app/demo/Models/TiposCuidadosViewModel';
import { error } from 'console';

import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

 
@Component({
    templateUrl: './TipoCuidado.component.html',
    providers: [MessageService, TiposCuidadosService]
})
export class TipoCuidadosComponent implements OnInit {

    
  EsAdmin: any;
  Permiso: any;

    //Dialogs
    TipoCuidadostDialog: boolean = false;

    deleteTipoCuidadosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
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
    TipoCuidados: TiposCuidadosViewModel[] = [];
    TipoCuidado: TiposCuidadosViewModel = {};

    //Paginacion de el datatable
    selectedTipoCuidados: TiposCuidadosViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;


    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private TiposCuidadosService: TiposCuidadosService, private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('TiposDeCuidados')}

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

        //Trae los datos de la api
        this.loadData();
        //Trae los datos de la api

     
        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'ticu_Id', header: 'ticu_Id' },
            { field: 'ticu_Descripcion', header: 'ticu_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //trae los datos
    private loadData() {
        this.TiposCuidadosService.getTiposCuidados().subscribe(
            Response => {
                this.TipoCuidados = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //trae los datos

    //Metodo que desactiva el dialog
    hideDialog() {
        this.TipoCuidadostDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.TipoCuidado = {};
        this.submitted = false;
        this.TipoCuidadostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editTipoCuidados(TipoCuidados: TiposCuidadosViewModel) {
        this.Editar = true;
        this.TipoCuidado = { ...TipoCuidados };
        this.TipoCuidadostDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteTipoCuidados(TipoCuidados: TiposCuidadosViewModel) {
        this.deleteTipoCuidadosDialog = true;
        this.TipoCuidado = { ...TipoCuidados };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteTipoCuidadosDialog = false;
        var params = {
            "ticu_Id": this.TipoCuidado.ticu_Id,
 
        }

        this.TiposCuidadosService.DeleteTiposCuidados(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {
                    this.TipoCuidados = this.TipoCuidados.filter(val => val.ticu_Id !== this.TipoCuidado.ticu_Id);
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.TipoCuidado = {};
                    this.TipoCuidadostDialog = false;

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

    isInputEmptyOrWhitespace(value: string | undefined): boolean {
        if (value === undefined) {
            return true; // Tratar 'undefined' como un valor vacío
        }

        return value.trim() === '';
    }


    //Enviamos y editamos datos
    saveTipoCuidados() {
        this.submitted = true;

        var params = {
            "ticu_Id": this.TipoCuidado.ticu_Id,
            "ticu_Descripcion": this.TipoCuidado.ticu_Descripcion ? this.TipoCuidado.ticu_Descripcion.trim() : '',
            "ticu_UserCreacion": 1,
            "ticu_UserModificacion": 1
        }


        if (this.TipoCuidado.ticu_Descripcion?.trim() == '') {
            console.log(this.TipoCuidado.ticu_Descripcion?.toString().length);
            this.espacio = true;
        }

        if(params.ticu_Descripcion === ""){
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: "El campo es requerido.", life: 3000 });

        }
        else{
            if (params.ticu_Descripcion !== undefined &&
                params.ticu_Descripcion.trim() !== '' &&
                params.ticu_UserCreacion !== undefined &&
                params.ticu_UserModificacion !== undefined) {
    
                //Si insertara o editara
                if (!this.Editar) {
    
                    this.TiposCuidadosService.postTiposCuidados(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.TipoCuidado = {};
                                this.TipoCuidadostDialog = false;
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
                    this.TiposCuidadosService.EditTiposCuidados(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.TipoCuidado = {};
                                this.TipoCuidadostDialog = false;
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

    }
    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador



}
