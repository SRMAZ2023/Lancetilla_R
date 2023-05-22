import { Component, OnInit } from '@angular/core';
import { CargoViewModel } from 'src/app/demo/Models/CargoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { CargosService } from 'src/app/demo/service/cargo.service';
import { error } from 'console';
//import { Cargoss } from 'src/app/demo/api/CargossViewModel';

@Component({
    templateUrl: './cargos.component.html',
    providers: [MessageService, CargosService]
})
export class cargosComponent implements OnInit {

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

    cols: any[] = [];

    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor(private cargosService: CargosService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.cargosService.getCatgos().subscribe(
            Response => {
                console.log(Response);
                this.Cargos = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'carg_Id', header: 'carg_Id' },
            { field: 'carg_Descripcion', header: 'carg_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

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
        this.Cargos = this.Cargos.filter(val => val.carg_Id !== this.Cargo.carg_Id);
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
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Cargo = {};
                    this.CargostDialog = false;

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
    saveCargos() {
        this.submitted = true;

        var params = {
            "carg_Id": this.Cargo.carg_Id,
            "carg_Descripcion": this.Cargo.carg_Descripcion!.trim(),
            "carg_UserCreacion": 1,
            "carg_UserModificacion": 1
        }


        if (this.Cargo.carg_Descripcion?.trim() == '') {
            console.log(this.Cargo.carg_Descripcion?.toString().length);
            this.espacio = true;
        }
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

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Cargo = {};
                            this.CargostDialog = false;

                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
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

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Cargo = {};
                            this.CargostDialog = false;

                        } else {
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
