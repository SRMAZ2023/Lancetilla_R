import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { CuidadoDePlantasViewModel } from 'src/app/demo/Models/CuidadoDePlantasViewModel';
import { CuidadosDePlantasService } from 'src/app/demo/service/CuidadoDePlantas';

@Component({
    templateUrl: './cuidadosplantas.component.html',
    providers: [MessageService, CuidadosDePlantasService]
})
export class CuidadosPlantasComponent implements OnInit {

    //Dialogs
    CuidadosPlantasDialog: boolean = false;

    deleteCuidadosPlantasDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    cuidadosplans: CuidadoDePlantasViewModel[] = [];
    cuidado: CuidadoDePlantasViewModel = {};

    //Paginacion de el datatable
    selectedCuidadosPlantas: CuidadoDePlantasViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor(private CuidadosPlantasService: CuidadosDePlantasService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.CargarDatos();
        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'cuid_Id', header: 'cuid_Id' },
            { field: 'cuid_Descripcion', header: 'cuid_Descripcion' },
            { field: 'cuid_Frecuencia', header: 'cuid_Frecuencia' }

        ];
        //Modelo de los datos de la tabla

    }
    private CargarDatos() {
        this.CuidadosPlantasService.getCuidadosDePlantas().subscribe(
            Response => {
                console.log(Response);
                this.cuidadosplans = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.CuidadosPlantasDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.cuidado = {};
        this.submitted = false;
        this.CuidadosPlantasDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editCuidadosPlantas(Cuidados: CuidadoDePlantasViewModel) {
        this.Editar = true;
        this.cuidado = { ...Cuidados };
        this.CuidadosPlantasDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteCuidadosPlantas(Cuidados: CuidadoDePlantasViewModel) {
        this.deleteCuidadosPlantasDialog = true;
        this.cuidado = { ...Cuidados };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteCuidadosPlantasDialog = false;
        var params = {
            "cuid_Id": this.cuidado.cuid_Id,
            "cuid_Descripcion": "",
            "cuid_Frecuencia": "",
            "cuid_UserCreacion": 1,
            "cuid_UserModificacion": 1
        }

        this.CuidadosPlantasService.DeleteCuidadosDePlantas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.cuidado = {};
                    this.CuidadosPlantasDialog = false;
                    this.cuidadosplans = this.cuidadosplans.filter(val => val.cuid_Id !== this.cuidado.cuid_Id);                  
                    this.CargarDatos();
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
    saveCuidadosPlantas() {
        this.submitted = true;

        var params = {
            "cuid_Id": this.cuidado.cuid_Id,
            "cuid_Descripcion": this.cuidado.cuid_Descripcion ? this.cuidado.cuid_Descripcion.trim() : '',
            "cuid_Frecuencia": this.cuidado.cuid_Frecuencia ? this.cuidado.cuid_Frecuencia.trim() : '',
            "cuid_UserCreacion": 1,
            "cuid_UserModificacion": 1
        }


        if (this.cuidado.cuid_Descripcion?.trim() == '' || this.cuidado.cuid_Frecuencia?.trim() == '') {
            this.espacio = true;
        }



        if (params.cuid_Descripcion === "" || params.cuid_Frecuencia === "") {
            this.messageService.add({ severity: 'warn', summary: 'Atención:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        else {
            //Validacion de params
            if (params.cuid_Descripcion !== undefined &&
                params.cuid_Descripcion.trim() !== '' &&
                params.cuid_Frecuencia !== undefined &&
                params.cuid_Frecuencia.trim() !== '' &&
                params.cuid_UserCreacion !== undefined &&
                params.cuid_UserModificacion !== undefined) {

                //Si insertara o editara
                if (!this.Editar) {

                    this.CuidadosPlantasService.postCuidadosDePlantas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                                this.cuidado = {};
                                this.CuidadosPlantasDialog = false;

                                this.CargarDatos();

                            } else {
                                this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )

                } else {
                    this.CuidadosPlantasService.EditCuidadosDePlantas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                                this.cuidado = {};
                                this.CuidadosPlantasDialog = false;

                                this.CargarDatos();

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
    }
    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
