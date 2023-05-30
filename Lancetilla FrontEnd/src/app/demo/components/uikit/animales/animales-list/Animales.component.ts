import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { PlantasViewModel } from 'src/app/demo/Models/PlantasViewModel';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { error } from 'console';
import { AnimalViewModel } from 'src/app/demo/Models/AnimalViewModel';
import { AnimalService } from 'src/app/demo/service/Animales.service';

@Component({
    templateUrl: './Animales.component.html',
    providers: [MessageService, AnimalService]
})
export class AnimalesComponent implements OnInit {

    //Dialogs
    AnimalesDialog: boolean = false;

    deleteAnimalesDialog: boolean = false;

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
    Animales: AnimalViewModel[] = [];
    Animal: AnimalViewModel = {};

    //Paginacion de el datatable
    selectedAnimal: AnimalViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

  

    statuses: any[] = [];


    constructor(private AnimalesService: AnimalService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.AnimalesService.getAnimales().subscribe(
            Response => {
                console.log(Response);
                this.Animales = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'anim_Id', header: 'anim_Id' },
            { field: 'anim_Nombre', header: 'anim_Nombre' },
            { field: 'anim_NombreCientifico', header: 'anim_NombreCientifico' },
            { field: 'rein_Id', header: 'rein_Id' },
            { field: 'habi_Id', header: 'habi_Id' },
            { field: 'arzo_Id', header: 'arzo_Id' },
            { field: 'alim_Id', header: 'alim_Id' },
            { field: 'espe_Id', header: 'cuid_Descespe_Idripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.AnimalesDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Animal = {};
        this.submitted = false;
        this.AnimalesDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editAnimales(Animales: AnimalViewModel) {
        this.Editar = true;
        this.Animal = { ...Animales };
        this.AnimalesDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteAnimales(Animal: AnimalViewModel) {
        this.deleteAnimalesDialog = true;
        this.Animal = { ...Animal };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteAnimalesDialog = false;
        var anim_Id = this.Animal.anim_Id;
        var params = {
            "anim_Id": this.Animal.anim_Id,
            "anim_UserCreacion": 1,
            "anim_UserModificacion": 1
        }
        console.log(params)
        this.AnimalesService.DeleteAnimales(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {
                    
                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });
                    
                } else if (this.datos.code == 200) {
                    
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Animales = this.Animales.filter(val => val.anim_Id !== this.Animal.anim_Id);
                 

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
    saveAnimal() {
        this.submitted = true;

        var params = {
            "anim_Id": this.Animal.anim_Id,
            "anim_Descripcion": this.Animal.anim_Nombre,
            "anim_UserCreacion": 1,
            "anim_UserModificacion": 1
        }


        console.log(params)


            
            //Si insertara o editara
            if (!this.Editar) {

                this.AnimalesService.postAnimales(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Planta', life: 3000 });
                            console.log("esta dentrando")
                            this.Animal = {};
                            this.AnimalesDialog = false;

                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.AnimalesService.EditAnimales(params).subscribe(
                    Response => {
                        console.log(Response);
                        if (Response) {
                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Planta', life: 3000 });
                            console.log("esta dentrando")
                            this.Animal = {};
                            this.AnimalesDialog = false;


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
    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
