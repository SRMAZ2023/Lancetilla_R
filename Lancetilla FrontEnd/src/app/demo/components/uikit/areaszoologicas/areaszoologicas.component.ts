import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { AreasZoologicasViewModel } from 'src/app/demo/Models/AreasZoologicasViewModel';
import { AlimentacionService } from 'src/app/demo/service/Alimentacion.service';
import { AreasZoologicasService } from 'src/app/demo/service/AreasZoologicas.service';

@Component({
    templateUrl: './areaszoologicas.component.html',
    styleUrls:   ['./areaszoologicas-design.scss'],
    providers: [MessageService, AreasZoologicasService]
})
export class AreasZoologicasComponent implements OnInit {

    //Dialogs
    AreasZoologicastDialog: boolean = false;

    deleteAreasZoologicasDialog: boolean = false;

    deleteProductDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    AreasZoo: AreasZoologicasViewModel[] = [];
    Area: AreasZoologicasViewModel = {};

    //Paginacion de el datatable
    selectedAreasZoo: AreasZoologicasViewModel[] = [];
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


    constructor(private AreasZoologicasService: AreasZoologicasService, private messageService: MessageService) {
    }

    ngOnInit() {

       this.CargarDatos();

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'arzo_Id', header: 'arzo_Id' },
            { field: 'arzo_Descripcion', header: 'arzo_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

private CargarDatos(){
    this.AreasZoologicasService.getAreasZoologicas().subscribe(
        Response => {
            console.log(Response);
            this.AreasZoo = Response
        },
        error => (
            console.log(error)
        )
    );
}

    //Metodo que desactiva el dialog
    hideDialog() {
        this.AreasZoologicastDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Area = {};
        this.submitted = false;
        this.AreasZoologicastDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editAreasZoologicas(alimentos: AreasZoologicasViewModel) {
        this.Editar = true;
        this.Area = { ...alimentos };
        this.AreasZoologicastDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteAreasZoologicas(Area: AreasZoologicasViewModel) {
        this.deleteAreasZoologicasDialog = true;
        this.Area = { ...Area };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteAreasZoologicasDialog = false;
        var params = {
            "arzo_Id": this.Area.arzo_Id,
            "arzo_Descripcion": "",
            "arzo_UserCreacion": 1,
            "arzo_UserModificacion": 1
        }

        this.AreasZoologicasService.DeleteAreasZoologicas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Area = {};
                    this.AreasZoologicastDialog = false;
                    this.AreasZoo = this.AreasZoo.filter(val => val.arzo_Id !== this.Area.arzo_Id);
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
    saveAreasZoologicas() {
        this.submitted = true;

        var params = {
            "arzo_Id": this.Area.arzo_Id,
            "arzo_Descripcion": this.Area.arzo_Descripcion ? this.Area.arzo_Descripcion.trim() : '',
            "arzo_UserCreacion": 1,
            "arzo_UserModificacion": 1
        }


        if (this.Area.arzo_Descripcion?.trim() == '') {
            console.log(this.Area.arzo_Descripcion?.toString().length);
            this.espacio = true;
        }

        if(params.arzo_Descripcion === ""){
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else{
            if (params.arzo_Descripcion !== undefined &&
                params.arzo_Descripcion.trim() !== '' &&
                params.arzo_UserCreacion !== undefined &&
                params.arzo_UserModificacion !== undefined) {
    
                //Si insertara o editara
                if (!this.Editar) {
    
                    this.AreasZoologicasService.postAreasZoologicas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Area = {};
                                this.AreasZoologicastDialog = false;
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
                    this.AreasZoologicasService.EditAreasZoologicas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Area = {};
                                this.AreasZoologicastDialog = false;
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
