import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { PlantasViewModel } from 'src/app/demo/Models/PlantasViewModel';
import { TiposPlantasService } from 'src/app/demo/service/TiposPlantas.service';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { TiposPlantasViewModel } from 'src/app/demo/Models/TiposPlantasViewModel';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
    templateUrl: './Plantas.component.html',
    providers: [MessageService, PlantasService, TiposPlantasService, AreaBotanicaService]
})
export class PlantasComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;
    //Dialogs
    PlantasDialog: boolean = false;

    deletePlantasDialog: boolean = false;


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
    Plantas: PlantasViewModel[] = [];
    Planta: PlantasViewModel = {};
    arbos: AreaBotanicaViewModel [] = [];
    tiposdeplantas: TiposPlantasViewModel [] = [];

    //validar espacio
    espacio: boolean = false;

    //Paginacion de el datatable
    selectedPlantas: PlantasViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

 

    statuses: any[] = [];


    constructor(private PlantasService: PlantasService, 
        private TiposPlantasService: TiposPlantasService,
        private areabotanicassevrice: AreaBotanicaService,
        private messageService: MessageService, private _router: Router ,
        private localStorage: LocalStorageService,) {   this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('Plantas')
    }

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
            { field: 'plan_Id', header: 'plan_Id' },
            { field: 'plan_Codigo', header: 'plan_Codigo' },
            { field: 'tipl_NombreComun', header: 'tipl_NombreComun' },
            { field: 'tipl_NombreCientifico', header: 'tipl_NombreCientifico' },
            { field: 'arbo_Descripcion', header: 'arbo_Descripcion' },

        ];
        //Modelo de los datos de la tabla

        this.areabotanicassevrice.getAreaBotanica().subscribe(
            Response => {
                this.arbos = Response.map((item: { arbo_Descripcion: any; arbo_Id: any; }) => ({ label: item.arbo_Descripcion, value: item.arbo_Id }));

            },
             Error => {}
             )

             
        this.TiposPlantasService.getTiposPlantas().subscribe(
            Response => {
                this.tiposdeplantas = Response.map((item: { tipl_NombreComun: any; tipl_Id: any; }) => ({ label: item.tipl_NombreComun, value: item.tipl_Id }));

            },
             Error => {}
             )

    }
    private loadData() {
        this.PlantasService.getPlantas().subscribe(
            Response => {
                console.log(Response);
                this.Plantas = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.PlantasDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Planta = {};
        this.submitted = false;
        this.PlantasDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editPlantas(Plantas: PlantasViewModel) {
        this.Editar = true;
        this.Planta = { ...Plantas };
        this.PlantasDialog = true;
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
        var params = {
            "plan_Id": this.Planta.plan_Id,
            "plan_Codigo": "",
            "tipl_Id": 0,
            "arbo_Id": 0,
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }

        this.PlantasService.DeletePlantas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Planta = {};
                    this.PlantasDialog = false;
                    this.Plantas= this.Plantas.filter(val => val.plan_Id !== this.Planta.plan_Id);
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
    savePlantas() {
        this.submitted = true;

        var params = {
            "plan_Id": this.Planta.plan_Id,
            "plan_Codigo": this.Planta.plan_Codigo ? this.Planta.plan_Codigo.trim() : '',
            "tipl_Id": this.Planta.tipl_Id ? this.Planta.tipl_Id: 0,
            "arbo_Id": this.Planta.arbo_Id ? this.Planta.arbo_Id: 0,
            "plan_UserCreacion": 1,
            "plan_UserModificacion": 1
        }


        if (this.Planta.plan_Codigo?.trim() == '') {
            this.espacio = true;
        }

        if (params.plan_Codigo === "" || params.arbo_Id == 0 || params.arbo_Id == undefined || params.tipl_Id == 0 || params.tipl_Id == undefined) {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos requeridos.', life: 3000 });

        }
        else {
            //Validacion de params
            if (params.plan_Codigo !== undefined &&
                params.plan_Codigo.trim() !== '' &&
                params.arbo_Id != undefined &&
                params.arbo_Id != 0 &&
                params.tipl_Id != 0 &&
                params.tipl_Id != 0 &&           
                params.plan_UserCreacion !== undefined &&
                params.plan_UserModificacion !== undefined) {

                //Si insertara o editara
                if (!this.Editar) {

                    this.PlantasService.postPlantas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Planta = {};
                                this.PlantasDialog = false;
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
                    this.PlantasService.EditPlantas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 500) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El código ya existe.', life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Planta = {};
                                this.PlantasDialog= false;
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
