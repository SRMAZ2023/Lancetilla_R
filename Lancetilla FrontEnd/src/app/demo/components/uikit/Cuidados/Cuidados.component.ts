import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';

import { CuidadosService } from 'src/app/demo/service/Cuidados.service';
import { CuidadosViewModel } from 'src/app/demo/Models/CuidadosViewModel';

import { TiposCuidadosService } from 'src/app/demo/service/TiposCuidadios.Service';
import { TiposCuidadosViewModel } from 'src/app/demo/Models/TiposCuidadosViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';



@Component({
    templateUrl: './Cuidados.component.html',
    providers: [MessageService, CuidadosService, TiposCuidadosService]
})
export class CuidadosComponent implements OnInit {

    EsAdmin: any;
    Permiso: any;


    //Dialogs
    CuidadostDialog: boolean = false;

    deleteCuidadosDialog: boolean = false;

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
    Cuidados: CuidadosViewModel[] = [];
    Cuidado: CuidadosViewModel = {};

    TipoCuidados: TiposCuidadosViewModel[] = [];


    //Paginacion de el datatable
    selectedCuidados: CuidadosViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;


    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,
       private CuidadosService: CuidadosService, private TiposCuidadosService:TiposCuidadosService, private messageService: MessageService) {
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('CuidadosGenerales')
              }

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
            { field: 'cuid_Id', header: 'cuid_Id' },
            { field: 'cuid_Observacion', header: 'cuid_Observacion' },
            { field: 'ticu_Descripcion', header: 'ticu_Descripcion' }

        ];
        //Modelo de los datos de la tabla

        this.TiposCuidadosService.getTiposCuidados().subscribe(
            Response => {
                this.TipoCuidados = Response.map((item: { ticu_Descripcion: any; ticu_Id: any; }) => ({ label: item.ticu_Descripcion, value: item.ticu_Id }));

            },
             Error => {}
             )

    }

    //trae los datos
    private loadData() {
        this.CuidadosService.getCuidados().subscribe(
            Response => {
                this.Cuidados = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //trae los datos

    //Metodo que desactiva el dialog
    hideDialog() {
        this.CuidadostDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Cuidado = {};
        this.submitted = false;
        this.CuidadostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editCuidados(Cuidados: CuidadosViewModel) {
        this.Editar = true;
        this.Cuidado = { ...Cuidados };
        this.CuidadostDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteCuidados(Cuidados: CuidadosViewModel) {
        this.deleteCuidadosDialog = true;
        this.Cuidado = { ...Cuidados };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteCuidadosDialog = false;
        var params = {
            "cuid_Id": this.Cuidado.cuid_Id,
        }

        this.CuidadosService.DeleteCuidados(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {
                    this.Cuidados = this.Cuidados.filter(val => val.cuid_Id !== this.Cuidado.cuid_Id);
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Cuidado = {};
                    this.CuidadostDialog = false;

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
    saveCuidados() {
        this.submitted = true;

        var params = {
            "cuid_Id": this.Cuidado.cuid_Id,
            "cuid_Observacion": this.Cuidado.cuid_Observacion ? this.Cuidado.cuid_Observacion.trim() : '',
            "ticu_Id": this.Cuidado.ticu_Id,
            "cuid_UserCreacion": 1,
            "cuid_UserModificacion": 1
        }

        console.log(params)

        if (this.Cuidado.cuid_Observacion?.trim() == '') {
            console.log(this.Cuidado.cuid_Observacion?.toString().length);
            this.espacio = true;
        }

        if(params.cuid_Observacion == "" || params.ticu_Id == 0 || params.ticu_Id == undefined){
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        //Validacion de params
        if (params.cuid_Observacion !== undefined &&
            params.cuid_Observacion.trim() !== '' ) {

            //Si insertara o editara
            if (!this.Editar) {

                this.CuidadosService.postCuidados(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                            this.Cuidado = {};
                            this.CuidadostDialog = false;
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
                this.CuidadosService.EditCuidados(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                            this.Cuidado = {};
                            this.CuidadostDialog = false;
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



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador



}
