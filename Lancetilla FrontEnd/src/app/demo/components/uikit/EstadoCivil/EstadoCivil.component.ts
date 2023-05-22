import { Component, OnInit } from '@angular/core';import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { EstadoCivilesService } from 'src/app/demo/service/EstadoCivil.service';
import { EstadoCivilViewModel } from 'src/app/demo/Models/EstadoCivilViewModel';
import { error } from 'console';
//import { EstadoCiviless } from 'src/app/demo/api/EstadoCivilessViewModel';

@Component({
    templateUrl: './EstadoCivil.component.html',
    providers: [MessageService, EstadoCivilesService]
})
export class EstadoCivilesComponent implements OnInit {

    //Dialogs
    EstadoCivilestDialog: boolean = false;

    deleteEstadoCivilesDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    EstadoCiviles: EstadoCivilViewModel[] = [];
    EstadoCivil: EstadoCivilViewModel = {};

    //Paginacion de el datatable
    selectedEstadoCiviles: EstadoCivilViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor(private EstadoCivilesService: EstadoCivilesService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.EstadoCivilesService.getEstadoCiviles().subscribe(
            Response => {
                console.log(Response);
                this.EstadoCiviles = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'estc_Id', header: 'estc_Id' },
            { field: 'estc_Descripcion', header: 'estc_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.EstadoCivilestDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.EstadoCivil = {};
        this.submitted = false;
        this.EstadoCivilestDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editEstadoCiviles(EstadoCiviles: EstadoCivilViewModel) {
        this.Editar = true;
        this.EstadoCivil = { ...EstadoCiviles };
        this.EstadoCivilestDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteEstadoCiviles(EstadoCiviles: EstadoCivilViewModel) {
        this.deleteEstadoCivilesDialog = true;
        this.EstadoCivil = { ...EstadoCiviles };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteEstadoCivilesDialog = false;
        this.EstadoCiviles = this.EstadoCiviles.filter(val => val.estc_Id !== this.EstadoCivil.estc_Id);
        var params = {
            "estc_Id": this.EstadoCivil.estc_Id,
            "estc_Descripcion": "",
            "estc_UserCreacion": 1,
            "estc_UserModificacion": 1
        }

        this.EstadoCivilesService.DeleteEstadoCiviles(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.EstadoCivil = {};
                    this.EstadoCivilestDialog = false;

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
    saveEstadoCiviles() {
        this.submitted = true;

        var params = {
            "estc_Id": this.EstadoCivil.estc_Id,
            "estc_Descripcion": this.EstadoCivil.estc_Descripcion!.trim(),
            "estc_UserCreacion": 1,
            "estc_UserModificacion": 1
        }


        if (this.EstadoCivil.estc_Descripcion?.trim() == '') {
            console.log(this.EstadoCivil.estc_Descripcion?.toString().length);
            this.espacio = true;
        }
        //Validacion de params
        if (params.estc_Descripcion !== undefined &&
            params.estc_Descripcion.trim() !== '' &&
            params.estc_UserCreacion !== undefined &&
            params.estc_UserModificacion !== undefined) {

            //Si insertara o editara
            if (!this.Editar) {

                this.EstadoCivilesService.postEstadoCiviles(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.EstadoCivil = {};
                            this.EstadoCivilestDialog = false;

                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.EstadoCivilesService.EditEstadoCiviles(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.EstadoCivil = {};
                            this.EstadoCivilestDialog = false;

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
