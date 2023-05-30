import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { PlantasViewModel } from 'src/app/demo/Models/PlantasViewModel';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { error } from 'console';

@Component({
    templateUrl: './Plantas.component.html',
    providers: [MessageService, PlantasService]
})
export class PlantasComponent implements OnInit {

    //Dialogs
    PlantastDialog: boolean = false;

    deletePlantasDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos:any = {};

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
    Plantas: PlantasViewModel[] = [];
    Planta: PlantasViewModel = {};

    //Paginacion de el datatable
    selectedPlantas: PlantasViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

  

    statuses: any[] = [];


    constructor(private PlantasService: PlantasService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.PlantasService.getPlantas().subscribe(
            Response => {
                console.log(Response);
                this.Plantas = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'plan_Id', header: 'plan_Id' },
            { field: 'plan_Nombre', header: 'plan_Nombre' },
            { field: 'plan_NombreCientifico', header: 'plan_NombreCientifico' },
            { field: 'rein_Descripcion', header: 'rein_Descripcion' },
            { field: 'arbo_Descripcion', header: 'arbo_Descripcion' },
            { field: 'cuid_Descripcion', header: 'cuid_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.PlantastDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Planta = {};
        this.submitted = false;
        this.PlantastDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editPlantas(Plantas: PlantasViewModel) {
        this.Editar = true;
        this.Planta = { ...Plantas };
        this.PlantastDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deletePlantas(Plantas: PlantasViewModel) {
        this.deletePlantasDialog = true;
        this.Planta = { ...Plantas };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deletePlantasDialog = false;
        var plan_Id = this.Planta.plan_Id;
        var params = {
            "plan_Id": this.Planta.plan_Id,
            "plan_UserCreacion": 1,
            "plan_UserModificacion": 1
        }
        console.log(params)
        this.PlantasService.DeletePlantas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {
                    
                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });
                    
                } else if (this.datos.code == 200) {
                    
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Plantas = this.Plantas.filter(val => val.plan_Id !== this.Planta.plan_Id);
                 

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
    savePlantas() {
        this.submitted = true;

        var params = {
            "plan_Id": this.Planta.plan_Id,
            "espe_Descripcion": this.Planta.plan_Nombre,
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

                this.PlantasService.postPlantas(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Planta', life: 3000 });
                            console.log("esta dentrando")
                            this.Planta = {};
                            this.PlantastDialog = false;

                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.PlantasService.EditPlantas(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Planta', life: 3000 });
                            console.log("esta dentrando")
                            this.Planta = {};
                            this.PlantastDialog = false;


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
