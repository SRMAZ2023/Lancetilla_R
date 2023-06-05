import { Component, OnInit } from '@angular/core';
import { Especies, Product } from 'src/app/demo/api/product';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { ProductService } from 'src/app/demo/service/product.service';
import { error } from 'console';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

//import { Especiess } from 'src/app/demo/api/EspeciessViewModel';

@Component({
    templateUrl: './especies.component.html',
    providers: [MessageService, ProductService]
})
export class especiesComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;
    //Dialogs
    EspeciestDialog: boolean = false;

    deleteEspeciesDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs


    public Editar: boolean = false;
    Especies: Especies[] = [];
    Especie: Especies = {};

    //Paginacion de el datatable
    selectedEspecies: Product[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    datos: any = {};


    //Validacion
    submitted: boolean = false;

    //validar espacio
    espacio: boolean = false;
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


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private productService: ProductService, private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Especies')}

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
            { field: 'espe_Id', header: 'espe_Id' },
            { field: 'espe_Descripcion', header: 'espe_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //trae los datos
    private loadData() {
        this.productService.getEspecies().subscribe(
            Response => {
                console.log(Response);
                this.Especies = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //trae los datos

    //Metodo que desactiva el dialog
    hideDialog() {
        this.EspeciestDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Especie = {};
        this.submitted = false;
        this.EspeciestDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editEspecies(Especies: Especies) {
        this.Editar = true;
        this.Especie = { ...Especies };
        this.EspeciestDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteEspecies(Especies: Especies) {
        this.deleteEspeciesDialog = true;
        this.Especie = { ...Especies };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteEspeciesDialog = false;
        var espe_Id = this.Especie.espe_Id;
        var params = {
            "espe_Id": this.Especie.espe_Id,
            "espe_Descripcion": "",
            "espe_UserCreacion": 1,
            "espe_UserModificacion": 1
        }
        console.log(params)
        this.productService.DeleteEspecies(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Especies = this.Especies.filter(val => val.espe_Id !== this.Especie.espe_Id);


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
    saveEspecies() {
        this.submitted = true;

        var params = {
            "espe_Id": this.Especie.espe_Id,
            "espe_Descripcion": this.Especie.espe_Descripcion ? this.Especie.espe_Descripcion.trim() : '',
            "espe_UserCreacion": 1,
            "espe_UserModificacion": 1
        }


        if (this.Especie.espe_Descripcion?.trim() == '') {
            console.log(this.Especie.espe_Descripcion?.toString().length);
            this.espacio = true;
        }
        if (params.espe_Descripcion == "") {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else{
                 //Validacion de params
        if (params.espe_Descripcion !== undefined &&
            params.espe_Descripcion.trim() !== '' &&
            params.espe_UserCreacion !== undefined &&
            params.espe_UserModificacion !== undefined) {

            //Si insertara o editara
            if (!this.Editar) {

                this.productService.postEspecies(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: 'La especie ha sido creada con éxito.', life: 3000 });
                            this.Especie = {};
                            this.EspeciestDialog = false;

                            this.loadData();


                        } else {
                            this.messageService.add({ severity: 'error', summary: 'Error:', detail: 'Intenta mas tarde', life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.productService.EditEspecies(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: 'La especie ha sido actualizado con éxito.', life: 3000 });
                            this.Especie = {};
                            this.EspeciestDialog = false;
                            this.loadData();


                        } else {
                            this.messageService.add({ severity: 'error', summary: 'Error:', detail: 'Intenta mas tarde', life: 3000 });
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
   
    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
