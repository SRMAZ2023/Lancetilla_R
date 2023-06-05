import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MantenimintoService } from 'src/app/demo/service/Manteniminto.service copy';
import { MantenimintoViewModel } from 'src/app/demo/Models/MantenimintoViewModel';

import { TipoDeMatenimientoViewModel } from 'src/app/demo/Models/TipoDeManteniminetoViewModel';
import { TiposDeMantenimientoService } from 'src/app/demo/service/TipoDeMantenimiento.service';
//import { Mantenimientos } from 'src/app/demo/api/MantenimientosViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';



@Component({
    templateUrl: './Mantenimiento.component.html',
    providers: [MessageService, MantenimintoService, TiposDeMantenimientoService]
})
export class MantenimientoComponent implements OnInit {

    
  EsAdmin: any;
  Permiso: any;


    //Dialogs
    MantenimientotDialog: boolean = false;

    deleteMantenimientoDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    Mantenimiento: MantenimintoViewModel[] = [];
    Mantenimient: MantenimintoViewModel = {};

    TipoMantenimiento: TipoDeMatenimientoViewModel[] = [];


    //Paginacion de el datatable
    selectedMantenimiento: MantenimintoViewModel[] = [];
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


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private MantenimintoService: MantenimintoService, 
        private TiposDeMantenimientoService:TiposDeMantenimientoService, 
        private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Mantenimientos')}

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

        //Trae los datos de la api
        this.loadData();
        //Trae los datos de la api


        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'mant_Id', header: 'mant_Id' },
            { field: 'mant_Observaciones', header: 'mant_Observaciones' },
            { field: 'tima_Descripcion', header: 'tima_Descripcion' }

        ];
        //Modelo de los datos de la tabla

        this.TiposDeMantenimientoService.getTiposDeMantenimientos().subscribe(
            Response => {
                this.TipoMantenimiento = Response.map((item: { tima_Descripcion: any; tima_Id: any; }) => ({ label: item.tima_Descripcion, value: item.tima_Id }));

            },
             Error => {}
             )

    }

    //trae los datos
    private loadData() {
        this.MantenimintoService.getCatgos().subscribe(
            Response => {
                this.Mantenimiento = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //trae los datos

    //Metodo que desactiva el dialog
    hideDialog() {
        this.MantenimientotDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Mantenimient = {};
        this.submitted = false;
        this.MantenimientotDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editMantenimiento(Mantenimiento: MantenimintoViewModel) {
        this.Editar = true;
        this.Mantenimient = { ...Mantenimiento };
        this.MantenimientotDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteMantenimiento(Mantenimiento: MantenimintoViewModel) {
        this.deleteMantenimientoDialog = true;
        this.Mantenimient = { ...Mantenimiento };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteMantenimientoDialog = false;
        var params = {
            "mant_Id": this.Mantenimient.mant_Id,
            "mant_Observaciones": this.Mantenimient.mant_Observaciones?.trim(),
            "tima_Id": 0,
            "tima_Descripcion": this.Mantenimient.tima_Descripcion?.trim(),
            "mant_UserCreacion": 1,
            "mant_UserModificacion": 1
        }

        this.MantenimintoService.DeleteManteniminto(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {
                    this.Mantenimiento = this.Mantenimiento.filter(val => val.mant_Id !== this.Mantenimient.mant_Id);
                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Mantenimient = {};
                    this.MantenimientotDialog = false;

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
    saveMantenimiento() {
        this.submitted = true;

        var params = {
            "mant_Id": this.Mantenimient.mant_Id,
            "mant_Observaciones": this.Mantenimient.mant_Observaciones ? this.Mantenimient.mant_Observaciones.trim() : '',
            "tima_Id": this.Mantenimient.tima_Id ? this.Mantenimient.tima_Id : 0,
            "tima_Descripcion": "",
            "mant_UserCreacion": 1,
            "mant_UserModificacion": 1
        }

        console.log(params)

        if (this.Mantenimient.mant_Observaciones?.trim() == '') {
            console.log(this.Mantenimient.mant_Observaciones?.toString().length);
            this.espacio = true;
        }

        if(params.mant_Observaciones == "" || params.tima_Id == 0 || params.tima_Id == undefined){
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        else{
       //Validacion de params
        if (params.mant_Observaciones !== undefined &&
            params.mant_Observaciones.trim() !== '' ) {

            //Si insertara o editara
            if (!this.Editar) {

                this.MantenimintoService.postManteniminto(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                            this.Mantenimient = {};
                            this.MantenimientotDialog = false;
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
                this.MantenimintoService.EditManteniminto(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                            this.Mantenimient = {};
                            this.MantenimientotDialog = false;
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
