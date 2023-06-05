import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { AreasZoologicasViewModel } from 'src/app/demo/Models/AreasZoologicasViewModel';
import { HabitatViewModel } from 'src/app/demo/Models/HabitatViewModel';
import { AreasZoologicasService } from 'src/app/demo/service/AreasZoologicas.service';
import { HabitatService } from 'src/app/demo/service/Habitat.service';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';



@Component({
    templateUrl: './habitat.component.html',
    styleUrls: ['./habitat-design.scss'],
    providers: [MessageService, HabitatService]
})
export class HabitatComponent implements OnInit {


    EsAdmin: any;
    Permiso: any;

    //Dialogs
    HabitatDialog: boolean = false;

    deleteHabitatDialog: boolean = false;

    deleteProductDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    habitat: HabitatViewModel[] = [];
    habi: HabitatViewModel = {};

    //Paginacion de el datatable
    selectedHabitat: HabitatViewModel[] = [];
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


    constructor(private _router: Router,
        private localStorage: LocalStorageService, private habitatservice: HabitatService, private messageService: MessageService) {
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('Hábitats')
    }

    ngOnInit() {

        if (this.EsAdmin != null || this.EsAdmin != undefined) {

            if (this.EsAdmin == false) {

                if (this.Permiso == false) {
                    this._router.navigate(['login']);
                }
            }

        } else {

            this._router.navigate(['login']);
        }

        this.CargarDatos();

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'habi_Id', header: 'habi_Id' },
            { field: 'habi_Descripcion', header: 'habi_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    private CargarDatos() {
        this.habitatservice.getHabitat().subscribe(
            Response => {
                console.log(Response);
                this.habitat = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.HabitatDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.habi = {};
        this.submitted = false;
        this.HabitatDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editHabitat(habi: HabitatViewModel) {
        this.Editar = true;
        this.habi = { ...habi };
        this.HabitatDialog = true;

    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteHabitat(habi: HabitatViewModel) {
        this.deleteHabitatDialog = true;
        this.habi = { ...habi };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteHabitatDialog = false;
        var params = {
            "habi_Id": this.habi.habi_Id,
            "habi_Descripcion": "",
            "habi_UserCreacion": 1,
            "habi_UserModificacion": 1
        }

        this.habitatservice.DeleteHabitat(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.habi = {};
                    this.HabitatDialog = false;
                    this.habitat = this.habitat.filter(val => val.habi_Id !== this.habi.habi_Id);
                    this.CargarDatos();


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
    saveHabitat() {
        this.submitted = true;

        var params = {
            "habi_Id": this.habi.habi_Id,
            "habi_Descripcion": this.habi.habi_Descripcion ? this.habi.habi_Descripcion.trim() : '',
            "habi_UserCreacion": 1,
            "habi_UserModificacion": 1
        }


        if (this.habi.habi_Descripcion?.trim() == '') {
            console.log(this.habi.habi_Descripcion?.toString().length);
            this.espacio = true;
        }

        if (params.habi_Descripcion === "") {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else {
            if (params.habi_Descripcion !== undefined &&
                params.habi_Descripcion.trim() !== '' &&
                params.habi_UserCreacion !== undefined &&
                params.habi_UserModificacion !== undefined) {

                //Si insertara o editara
                if (!this.Editar) {

                    this.habitatservice.postHabitat(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.habi = {};
                                this.HabitatDialog = false;
                                this.CargarDatos()

                            } else {
                                this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )

                } else {
                    this.habitatservice.EditHabitat(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.habi = {};
                                this.HabitatDialog = false;
                                this.CargarDatos();

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
    //Validacion de params

    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
