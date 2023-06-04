import { Component, OnInit } from '@angular/core';
import { CargoViewModel } from 'src/app/demo/Models/CargoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { CargosService } from 'src/app/demo/service/cargo.service';
import { error } from 'console';
//import { Cargoss } from 'src/app/demo/api/CargossViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';


@Component({
    templateUrl: './cargos.component.html',
    providers: [MessageService, CargosService]
})
export class cargosComponent implements OnInit {

    EsAdmin: any;
    Permiso: any;

    //Dialogs
    CargostDialog: boolean = false;

    deleteCargosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    Cargos: CargoViewModel[] = [];
    Cargo: CargoViewModel = {};

    //Paginacion de el datatable
    selectedCargos: CargoViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    
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
  



    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private cargosService: CargosService, private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Cargos')}

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

        //Trae los datos de la api
        this.loadData();
        //Trae los datos de la api

     
        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'carg_Id', header: 'carg_Id' },
            { field: 'carg_Descripcion', header: 'carg_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //trae los datos
    private loadData() {
        this.cargosService.getCatgos().subscribe(
            Response => {
                this.Cargos = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //trae los datos

    //Metodo que desactiva el dialog
    hideDialog() {
        this.CargostDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Cargo = {};
        this.submitted = false;
        this.CargostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editCargos(Cargos: CargoViewModel) {
        this.Editar = true;
        this.Cargo = { ...Cargos };
        this.CargostDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteCargos(Cargos: CargoViewModel) {
        this.deleteCargosDialog = true;
        this.Cargo = { ...Cargos };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteCargosDialog = false;
        var params = {
            "carg_Id": this.Cargo.carg_Id,
            "carg_Descripcion": "",
            "carg_UserCreacion": 1,
            "carg_UserModificacion": 1
        }

        this.cargosService.DeleteCargos(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {
                    this.Cargos = this.Cargos.filter(val => val.carg_Id !== this.Cargo.carg_Id);
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Cargo = {};
                    this.CargostDialog = false;

                } else {
                    this.messageService.add({ severity: 'info', summary: 'Aviso', detail: this.datos.message, life: 3000 });
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
    saveCargos() {
        this.submitted = true;

        var params = {
            "carg_Id": this.Cargo.carg_Id,
            "carg_Descripcion": this.Cargo.carg_Descripcion ? this.Cargo.carg_Descripcion.trim() : '',
            "carg_UserCreacion": 1,
            "carg_UserModificacion": 1
        }


        if (this.Cargo.carg_Descripcion?.trim() == '') {
            console.log(this.Cargo.carg_Descripcion?.toString().length);
            this.espacio = true;
        }

        if(params.carg_Descripcion === "")
        {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else{
                    //Validacion de params
        if (params.carg_Descripcion !== undefined &&
            params.carg_Descripcion.trim() !== '' &&
            params.carg_UserCreacion !== undefined &&
            params.carg_UserModificacion !== undefined) {

            //Si insertara o editara
            if (!this.Editar) {

                this.cargosService.postCargos(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                            this.Cargo = {};
                            this.CargostDialog = false;
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
                this.cargosService.EditCargos(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                            this.Cargo = {};
                            this.CargostDialog = false;
                            this.loadData();


                        } else {
                            this.messageService.add({ severity: 'error:', summary: 'Error:', detail: this.datos.message, life: 3000 });
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
