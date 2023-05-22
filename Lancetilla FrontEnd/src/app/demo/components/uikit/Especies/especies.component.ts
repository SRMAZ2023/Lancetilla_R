import { Component, OnInit } from '@angular/core';
import { Especies, Product } from 'src/app/demo/api/product';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { ProductService } from 'src/app/demo/service/product.service';
import { error } from 'console';
//import { Especiess } from 'src/app/demo/api/EspeciessViewModel';

@Component({
    templateUrl: './especies.component.html',
    providers: [MessageService, ProductService]
})
export class especiesComponent implements OnInit {

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

    datos:any = {};


    //Validacion
    submitted: boolean = false;

    //validar espacio
    espacio: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];


    constructor(private productService: ProductService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.productService.getEspecies().subscribe(
            Response => {
                console.log(Response);
                this.Especies = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'espe_Id', header: 'espe_Id' },
            { field: 'espe_Descripcion', header: 'espe_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

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
        this.Especies = this.Especies.filter(val => val.espe_Id !== this.Especie.espe_Id);
        var espe_Id = this.Especie.espe_Id;
        var params = {
            "espe_Id": this.Especie.espe_Id,
            "espe_Descripcion":"",
            "espe_UserCreacion": 1,
            "espe_UserModificacion": 1
        }
        console.log(params)
        this.productService.DeleteEspecies(params).subscribe(
            Response => {
                if (Response) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva especie', life: 3000 });
                    console.log("esta dentrando")
                    this.Especie = {};

                } else {
                    this.messageService.add({ severity: 'warn', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
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
            "espe_Descripcion": this.Especie.espe_Descripcion!.trim(),
            "espe_UserCreacion": 1,
            "espe_UserModificacion": 1
        }


        if(this.Especie.espe_Descripcion?.trim() == ''){
            console.log(this.Especie.espe_Descripcion?.toString().length);
            this.espacio = true;
        } 
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
                        if(this.datos.code == 409){
                            
                            this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                        }else  if (this.datos.code  == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Pago', life: 3000 });
                            this.Especie = {};
                            this.EspeciestDialog = false;
                            
                        } else  {
                            this.messageService.add({ severity: 'warn', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
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
                        if(this.datos.code == 409){
                            
                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        }else  if (this.datos.code  == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Pago', life: 3000 });
                            this.Especie = {};
                            this.EspeciestDialog = false;
                            
                        } else  {
                            this.messageService.add({ severity: 'warn', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
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
