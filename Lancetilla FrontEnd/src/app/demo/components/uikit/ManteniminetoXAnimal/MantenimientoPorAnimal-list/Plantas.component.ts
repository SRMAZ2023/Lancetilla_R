import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { ManteniminetoXAnimalViewModel } from 'src/app/demo/Models/ManteniminetoXAnimalViewModel';
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
import { error } from 'console';

@Component({
    templateUrl: './MantenimientoPorAnimal.html',
    providers: [MessageService, ManteniminetoXAnimalService]
})
export class MantenimientoPorAnimalComponent implements OnInit {

    //Dialogs
    MantenimientoPorAnimaltDialog: boolean = false;

    deleteMantenimientoPorAnimalDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos:any = {};


    public Editar: boolean = false;
    MantenimientoPorAnimal: ManteniminetoXAnimalViewModel[] = [];
    mantenimientoXanimal: ManteniminetoXAnimalViewModel = {};

    //Paginacion de el datatable
    selectedMantenimientoPorAnimal: ManteniminetoXAnimalViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];


    constructor(private ManteniminetoXAnimalService: ManteniminetoXAnimalService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.ManteniminetoXAnimalService.getManteniminetoXAnimal().subscribe(
            Response => {
                console.log(Response);
                this.MantenimientoPorAnimal = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'maan_Id', header: 'maan_Id' },
            { field: 'plan_Nombre', header: 'plan_Nombre' },
            { field: 'plan_NombreCientifico', header: 'plan_NombreCientifico' },
            { field: 'plan_Reino', header: 'plan_Reino' },
            { field: 'arbo_Descripcion', header: 'arbo_Descripcion' },
            { field: 'cuid_Descripcion', header: 'cuid_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.MantenimientoPorAnimaltDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.mantenimientoXanimal = {};
        this.submitted = false;
        this.MantenimientoPorAnimaltDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editMantenimientoPorAnimal(MantenimientoPorAnimal: ManteniminetoXAnimalViewModel) {
        this.Editar = true;
        this.mantenimientoXanimal = { ...MantenimientoPorAnimal };
        this.MantenimientoPorAnimaltDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteMantenimientoPorAnimal(MantenimientoPorAnimal: ManteniminetoXAnimalViewModel) {
        this.deleteMantenimientoPorAnimalDialog = true;
        this.mantenimientoXanimal = { ...MantenimientoPorAnimal };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteMantenimientoPorAnimalDialog = false;
        var maan_Id = this.mantenimientoXanimal.maan_Id;
        var params = {
            "maan_Id": this.mantenimientoXanimal.maan_Id,
            "plan_UserCreacion": 1,
            "plan_UserModificacion": 1
        }
        console.log(params)
        this.ManteniminetoXAnimalService.DeleteManteniminetoXAnimal(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {
                    
                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });
                    
                } else if (this.datos.code == 200) {
                    
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.MantenimientoPorAnimal = this.MantenimientoPorAnimal.filter(val => val.maan_Id !== this.mantenimientoXanimal.maan_Id);
                 

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


    //Enviamos y editamos datos
    saveMantenimientoPorAnimal() {
        this.submitted = true;

        var params = {
            "maan_Id": this.mantenimientoXanimal.maan_Id,
            "espe_Descripcion": this.mantenimientoXanimal.anim_Nombre,
            "espe_UserCreacion": 1,
            "espe_UserModificacion": 1
        }


        console.log(params)

        //Validacion de params
        if (params.espe_Descripcion !== undefined &&
            params.espe_Descripcion.trim() !== '' &&
            params.espe_UserCreacion !== undefined &&
            params.espe_UserModificacion !== undefined) {
            
            //Si insertara o editara
            if (!this.Editar) {

                this.ManteniminetoXAnimalService.postManteniminetoXAnimal(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva mantenimientoXanimal', life: 3000 });
                            console.log("esta dentrando")
                            this.mantenimientoXanimal = {};
                            this.MantenimientoPorAnimaltDialog = false;

                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.ManteniminetoXAnimalService.EditManteniminetoXAnimal(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva mantenimientoXanimal', life: 3000 });
                            console.log("esta dentrando")
                            this.mantenimientoXanimal = {};
                            this.MantenimientoPorAnimaltDialog = false;


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
