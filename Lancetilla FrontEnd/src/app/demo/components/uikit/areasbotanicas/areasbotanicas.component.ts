import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { AreasZoologicasViewModel } from 'src/app/demo/Models/AreasZoologicasViewModel';
import { AlimentacionService } from 'src/app/demo/service/Alimentacion.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { AreasZoologicasService } from 'src/app/demo/service/AreasZoologicas.service';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';



@Component({
    templateUrl: './areasbotanicas.component.html',
    styleUrls:   ['./areasbotanicas-design.scss'],
    providers: [MessageService, AreaBotanicaService]
})
export class AreasBotanicasComponent implements OnInit {

    //Dialogs
    AreasBotanicasDialog: boolean = false;

    deleteAreasBotanicasDialog: boolean = false;

    deleteProductDialog: boolean = false;
    //Dialogs

    datos: any = {};

    
  EsAdmin: any;
  Permiso: any;


    public Editar: boolean = false;
    AreaBot: AreaBotanicaViewModel[] = [];
    Areas: AreaBotanicaViewModel = {};

    //Paginacion de el datatable
    selectedAreaBot: AreaBotanicaViewModel[] = [];
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


    constructor(
        private _router: Router ,
        private localStorage: LocalStorageService,private AreasBotanicasService: AreaBotanicaService, private messageService: MessageService) {
    
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('ÁreasBotánica')    }

    ngOnInit() {

        if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

            if (this.EsAdmin == false) {

                if (this.Permiso == false) {
                    this._router.navigate(['/app']);
                }              
            }
    
        }else{

            this._router.navigate(['login']);
        }

       this.CargarDatos();

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'arbo_Id',          header: 'arbo_Id' },
            { field: 'arbo_Descripcion', header: 'arbo_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

private CargarDatos(){
    this.AreasBotanicasService.getAreaBotanica().subscribe(
        Response => {
            console.log(Response);
            this.AreaBot = Response
        },
        error => (
            console.log(error)
        )
    );
}

    //Metodo que desactiva el dialog
    hideDialog() {
        this.AreasBotanicasDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Areas = {};
        this.submitted = false;
        this.AreasBotanicasDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editAreasBotanicas(Areas: AreaBotanicaViewModel) {
        this.Editar = true;
        this.Areas = { ...Areas };
        this.AreasBotanicasDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteAreasBotanicas(Areas: AreaBotanicaViewModel) {
        this.deleteAreasBotanicasDialog = true;
        this.Areas = { ...Areas };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteAreasBotanicasDialog = false;
        var params = {
            "arbo_Id": this.Areas.arbo_Id,
            "arbo_Descripcion": "",
            "arbo_UserCreacion": 1,
            "arbo_UserModificacion": 1
        }

        this.AreasBotanicasService.DeleteAreaBotanica(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Areas = {};
                    this.AreasBotanicasDialog = false;
                    this.AreaBot = this.AreaBot.filter(val => val.arbo_Id !== this.Areas.arbo_Id);
                    this.CargarDatos();


                } else {
                    this.messageService.add({ severity: 'warn', summary: 'Error:', detail: this.datos.message, life: 3000 });
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
    saveAreasBotanicas() {
        this.submitted = true;

        var params = {
            "arbo_Id": this.Areas.arbo_Id,
            "arbo_Descripcion": this.Areas.arbo_Descripcion ? this.Areas.arbo_Descripcion.trim() : '',
            "arbo_UserCreacion": 1,
            "arbo_UserModificacion": 1
        }


        if (this.Areas.arbo_Descripcion?.trim() == '') {
            console.log(this.Areas.arbo_Descripcion?.toString().length);
            this.espacio = true;
        }

        if(params.arbo_Descripcion === ""){
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else{
            if (params.arbo_Descripcion !== undefined &&
                params.arbo_Descripcion.trim() !== '' &&
                params.arbo_UserCreacion !== undefined &&
                params.arbo_UserModificacion !== undefined) {
    
                //Si insertara o editara
                if (!this.Editar) {
    
                    this.AreasBotanicasService.postAreaBotanica(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Areas = {};
                                this.AreasBotanicasDialog = false;
                                this.CargarDatos()
    
                            } else {
                                this.messageService.add({ severity: 'warn', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )
    
                } else {
                    this.AreasBotanicasService.EditAreaBotanica(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Areas = {};
                                this.AreasBotanicasDialog = false;
                                this.CargarDatos();
    
                            } else {
                                this.messageService.add({ severity: 'warm', summary: 'Error:', detail: this.datos.message, life: 3000 });
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
