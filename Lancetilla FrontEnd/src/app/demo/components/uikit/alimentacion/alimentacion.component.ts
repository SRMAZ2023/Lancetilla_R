import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { AlimentacionViewModel } from 'src/app/demo/Models/AlimentacionViewModel';
import { AlimentacionService } from 'src/app/demo/service/Alimentacion.service';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';




@Component({
    templateUrl: './alimentacion.component.html',
    styleUrls:   ['./alimentacion-design.scss'],
    providers: [MessageService, AlimentacionService]
})
export class AlimentacionComponent implements OnInit {

    
    AlimentacionPermiso: any;

    EsAdmin: any;

    
    
    //Dialogs
    AlimentaciontDialog: boolean = false;

    deleteAlimentacionDialog: boolean = false;

    deleteProductDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    Alimentacion: AlimentacionViewModel[] = [];
    Alimento: AlimentacionViewModel = {};

    //Paginacion de el datatable
    selectedAlimentos: AlimentacionViewModel[] = [];
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


    constructor(private alimentosService: AlimentacionService, private messageService: MessageService, 
        private _router: Router ,
        private localStorage: LocalStorageService) {

            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.AlimentacionPermiso = this.localStorage.getItem('Alimentación')
    }

    ngOnInit() {
      
        if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

            if (this.EsAdmin == false) {

                if (this.AlimentacionPermiso == false) {
                    this._router.navigate(['/app']);
                }
                
            }
    
        }else{

            this._router.navigate(['login']);
        }



this.CargarDatos();
        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'alim_Id', header: 'alim_Id' },
            { field: 'alim_Descripcion', header: 'alim_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    private CargarDatos(){
        this.alimentosService.getAlimentacion().subscribe(
            Response => {
                console.log(Response);
                this.Alimentacion = Response
            },
            error => (
                console.log(error)
            )
        );
    }


    //Metodo que desactiva el dialog
    hideDialog() {
        this.AlimentaciontDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Alimento = {};
        this.submitted = false;
        this.AlimentaciontDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editAlimentacion(alimentos: AlimentacionViewModel) {
        this.Editar = true;
        this.Alimento = { ...alimentos };
        this.AlimentaciontDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteAlimentacion(alimentos: AlimentacionViewModel) {
        this.deleteAlimentacionDialog = true;
        this.Alimento = { ...alimentos };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteAlimentacionDialog = false;

        var params = {
            "alim_Id": this.Alimento.alim_Id,
            "alim_Descripcion": "",
            "alim_UserCreacion": 1,
            "alim_UserModificacion": 1
        }

        this.alimentosService.DeleteAlimentacion(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Alimento = {};
                    this.AlimentaciontDialog = false;
                    this.Alimentacion = this.Alimentacion.filter(val => val.alim_Id !== this.Alimento.alim_Id);
                    this.CargarDatos();

                } else {
                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });
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
    saveAlimentacion() {
        this.submitted = true;

        var params = {
            "alim_Id": this.Alimento.alim_Id,
            "alim_Descripcion": this.Alimento.alim_Descripcion ? this.Alimento.alim_Descripcion.trim() : '',
            "alim_UserCreacion": 1,
            "alim_UserModificacion": 1
        }


        if (this.Alimento.alim_Descripcion?.trim() == '') {
            console.log(this.Alimento.alim_Descripcion?.toString().length);
            this.espacio = true;
        }

        if(params.alim_Descripcion === ""){
            this.messageService.add({ severity: 'warn', summary: 'Atención:', detail: 'El campo es requerido.', life: 3000 });

        }
        else{
            if (params.alim_Descripcion !== undefined &&
                params.alim_Descripcion.trim() !== '' &&
                params.alim_UserCreacion !== undefined &&
                params.alim_UserModificacion !== undefined) {
    
                //Si insertara o editara
                if (!this.Editar) {
    
                    this.alimentosService.postAlimentacion(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Alimento = {};
                                this.AlimentaciontDialog = false
                                this.CargarDatos();
    
                            } else {
                                this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )
    
                } else {
                    this.alimentosService.EditAlimentacion(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {
    
                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });
    
                            } else if (this.datos.code == 200) {
    
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Alimento = {};
                                this.AlimentaciontDialog = false;
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
