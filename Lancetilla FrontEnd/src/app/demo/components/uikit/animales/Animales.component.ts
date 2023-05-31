import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { AnimalService } from 'src/app/demo/service/Animales.service';
import { AreasZoologicasService } from 'src/app/demo/service/AreasZoologicas.service';
import { AlimentacionService } from 'src/app/demo/service/Alimentacion.service';
import { AnimalViewModel } from 'src/app/demo/Models/AnimalViewModel';
import { RazasViewModel } from 'src/app/demo/Models/RazasViewModel';
import { AlimentacionViewModel } from 'src/app/demo/Models/AlimentacionViewModel';
import { RazasService } from 'src/app/demo/service/Razas.service';
//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';

@Component({
    templateUrl: './Animales.component.html',
    providers: [MessageService, AnimalService, AreasZoologicasService, AlimentacionService, RazasService]
})
export class AnimalesComponent implements OnInit {

    //Dialogs
    AnimalesDialog: boolean = false;

    deleteAnimalesDialog: boolean = false;


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
    Animales: AnimalViewModel[] = [];
    animal: AnimalViewModel = {};
    razas: RazasViewModel [] = [];
    arzos: AreasZoologicasService [] = [];
    alimentacion: AlimentacionViewModel [] = [];

    //validar espacio
    espacio: boolean = false;

    //Paginacion de el datatable
    selectedanimals: AnimalViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

 

    statuses: any[] = [];


    constructor(private AnimalesService: AnimalService, 
        private RazasService: RazasService,
        private AreasZoologicasService: AreasZoologicasService,
        private alimentacionService: AlimentacionService,
        private messageService: MessageService) {
    }

    ngOnInit() {
            this.loadData();
        this.cols = [
            { field: 'anim_Id', header: 'plan_Id' },
            { field: 'anim_Codigo', header: 'plan_Codigo' },
            { field: 'anim_Nombre', header: 'anim_Nombre' },
            { field: 'raza_Descripcion', header: 'raza_Descripcion' },
            { field: 'arzo_Descripcion', header: 'arzo_Descripcion' },
            { field: 'alim_Descripcion', header: 'alim_Descripcion' },
        ];
        //Modelo de los datos de la tabla

        this.RazasService.getRazas().subscribe(
            Response => {
                this.razas = Response.map((item: { raza_Descripcion: any; raza_Id: any; }) => ({ label: item.raza_Descripcion, value: item.raza_Id }));

            },
             Error => {}
             )

             
        this.AreasZoologicasService.getAreasZoologicas().subscribe(
            Response => {
                this.arzos = Response.map((item: { arzo_Descripcion: any; arzo_Id: any; }) => ({ label: item.arzo_Descripcion, value: item.arzo_Id }));

            },
             Error => {}
             )

             this.alimentacionService.getAlimentacion().subscribe(
                Response => {
                    this.alimentacion = Response.map((item: { alim_Descripcion: any; alim_Id: any; }) => ({ label: item.alim_Descripcion, value: item.alim_Id }));
    
                },
                 Error => {}
                 )
    

    }
    private loadData() {
        this.AnimalesService.getAnimales().subscribe(
            Response => {
                console.log(Response);
                this.Animales = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.AnimalesDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.animal = {};
        this.submitted = false;
        this.AnimalesDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editAnimales(animal: AnimalViewModel) {
        this.Editar = true;
        this.animal = { ...animal };
        this.AnimalesDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteAnimal(animal: AnimalViewModel) {
        this.deleteAnimalesDialog = true;
        this.animal = { ...animal };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteAnimalesDialog = false;
        var params = {
            "anim_Id": this.animal.anim_Id,
            "anim_Codigo": "",
            "tipl_Id": 0,
            "arbo_Id": 0,
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }

        this.AnimalesService.DeleteAnimales(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.animal = {};
                    this.AnimalesDialog = false;
                    this.Animales= this.Animales.filter(val => val.anim_Id !== this.animal.anim_Id);
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
    saveanimals() {
        this.submitted = true;

        var params = {
            "anim_Id": this.animal.anim_Id,
            "anim_Codigo": this.animal.anim_Codigo ? this.animal.anim_Codigo.trim() : '',
            "anim_Nombre": this.animal.anim_Nombre ? this.animal.anim_Nombre.trim() : '',
            "raza_Id": this.animal.raza_Id ? this.animal.raza_Id: 0,
            "arzo_Id": this.animal.arzo_Id ? this.animal.arzo_Id: 0,
            "alim_Id": this.animal.alim_Id ? this.animal.alim_Id: 0,
            "anim_UserCreacion": 1,
            "anim_UserModificacion": 1
        }


        if (this.animal.anim_Codigo?.trim() == '') {
            this.espacio = true;
        }

        if (params.anim_Codigo === "" || params.anim_Nombre === "" || params.arzo_Id == 0 || params.arzo_Id == undefined || params.raza_Id == 0 || params.raza_Id == undefined || params.alim_Id == 0 || params.alim_Id == undefined) {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos requeridos.', life: 3000 });

        }
        else {
            //Validacion de params
            if (params.anim_Nombre !== undefined &&
                params.anim_Nombre.trim() !== '' &&
                params.anim_Codigo !== undefined &&
                params.anim_Codigo.trim() !== '' &&
                params.raza_Id != undefined &&
                params.raza_Id != 0 &&
                params.arzo_Id != undefined &&
                params.arzo_Id != 0 &&
                params.alim_Id != 0 &&
                params.alim_Id != 0 &&           
                params.anim_UserCreacion !== undefined &&
                params.anim_UserModificacion !== undefined) {

                //Si insertara o editara
                if (!this.Editar) {

                    this.AnimalesService.postAnimales(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.animal = {};
                                this.AnimalesDialog = false;
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
                    this.AnimalesService.EditAnimales(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 500) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El código ya existe.', life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.animal = {};
                                this.AnimalesDialog= false;
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
