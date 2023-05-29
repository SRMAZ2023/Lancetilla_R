import { Component, OnInit } from '@angular/core';
import { MunicipiosViewModel } from 'src/app/demo/Models/MunicipiosViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MunicipiosService } from 'src/app/demo/service/Municipios.service';
import { error } from 'console';
//import { Municipioss } from 'src/app/demo/api/MunicipiossViewModel';

@Component({
    templateUrl: './Municipios.component.html',
    providers: [MessageService, MunicipiosService]
})
export class MunicipiosComponent implements OnInit {

    //Dialogs
    InsertMunicipiostDialog: boolean = false;
     //Dialogs
     EditarMunicipiostDialog: boolean = false;

    deleteMunicipiosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    Municipios: MunicipiosViewModel[] = [];
    Municipio: MunicipiosViewModel = {};

    departamentos: any[] = []; // Array para almacenar los datos de departamentos


    //Paginacion de el datatable
    selectedMunicipios: MunicipiosViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor(private MunicipiosService: MunicipiosService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.CargarMunicipios() 
        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'muni_Id', header: 'muni_Id' },
            { field: 'muni_Descripcion', header: 'muni_Descripcion' },
            { field: 'dept_Descripcion', header: 'dept_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

     hideDialog() {
        this.InsertMunicipiostDialog = false;
        this.EditarMunicipiostDialog = false;
        this.submitted = false;
    }

    //Metodo que desactiva el dialog
    CargarMunicipios() {
        
        this.MunicipiosService.ListarMunicipios().subscribe(
            Response => {
                console.log(Response);
                this.Municipios = Response
            },
            error => (
                console.log(error)
            )
        );
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Municipio = {};

        this.MunicipiosService.ListarDepartamentos().subscribe(
            response => {
              console.log(response);
              this.departamentos = response.map((item: { dept_Descripcion: any; dept_Id: any; }) => ({
                value: item.dept_Id,
                label: item.dept_Descripcion
              }));
            },
            error => {
              console.log(error);
            }
          );

        this.submitted = false;
        this.InsertMunicipiostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editMunicipios(Municipios: MunicipiosViewModel) {
        this.Editar = true;
         
        this.MunicipiosService.ListarDepartamentos().subscribe(
            response => {
              console.log(response);
              this.departamentos = response.map((item: { dept_Descripcion: any; dept_Id: any; }) => ({
                value: item.dept_Id,
                label: item.dept_Descripcion
              }));
            },
            error => {
              console.log(error);
            }
          );

       
       
        this.Municipio = { ...Municipios };
        this.EditarMunicipiostDialog = true;
    
    
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteMunicipios(Municipios: MunicipiosViewModel) {
        this.deleteMunicipiosDialog = true;
        this.Municipio = { ...Municipios };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteMunicipiosDialog = false;
        this.Municipios = this.Municipios.filter(val => val.muni_Id?.toString() !== this.Municipio.muni_Id?.toString());
        var params = {
            "muni_Id": this.Municipio.muni_Id?.toString(),
            "muni_Descripcion": "",
            "dept_Id": 0,
            "dept_Descripcion": "",
            "muni_UserCreacion": 1,
            "muni_UserModificacion": 1
        }

        this.MunicipiosService.EliminarMunicipio(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Municipio = {};
                    this.InsertMunicipiostDialog = false;
                    this.CargarMunicipios() 
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



    isInputEmptyOrWhitespace(value: string): boolean {
        return !value || value.trim() === '';
      }


    //Enviamos y editamos datos
    saveMunicipios() {
        this.submitted = true;
      console.log("Entro")
      if (this.Municipio.muni_Descripcion?.trim() == '') {
        console.log(this.Municipio.muni_Descripcion?.toString().length);
        this.espacio = true;
    }
       
      var params = {
            "muni_Id": this.Municipio.muni_Id?.toString(),
            "muni_Descripcion": this.Municipio.muni_Descripcion?.trim(),
            "dept_Id": this.Municipio.dept_Id?.toString(),
            "dept_Descripcion": "d",
            "muni_UserCreacion": 1,
            "muni_UserModificacion": 1
        }

         console.log(params);
 
       

         if (params.muni_Id?.toString() !== undefined && params.muni_Id?.toString().length > 4 || params.muni_Id?.toString() !== undefined && params.muni_Id?.toString().length > 0 && parseInt(params.muni_Id?.toString()) < 1) {
            
            this.messageService.add({ severity: 'info', summary: 'info', detail: "Ingrese un código válido.", life: 3000 });

        }
       
        //Validacion de params
        if (params.muni_Id?.toString() !== undefined &&
            params.muni_Id?.toString().length < 5  &&
            parseInt(params.muni_Id?.toString()) > 0 &&
            params.muni_Descripcion !== undefined &&
            params.dept_Id?.toString() !== undefined &&
            params.dept_Descripcion.trim() !== '' &&
            params.muni_UserCreacion !== undefined &&
            params.muni_UserModificacion !== undefined) {

            //Si insertara o editara
            if (!this.Editar) {

                this.MunicipiosService.CrearMunicipio(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Municipio = {};
                            this.InsertMunicipiostDialog = false;
                            this.CargarMunicipios() 
                        } else {
                            this.messageService.add({ severity: 'info', summary: 'Error', detail: "Fallo al Insertar en Codigo del municipio", life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.MunicipiosService.EditarMunicipio(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Municipio = {};
                            this.EditarMunicipiostDialog = false;
                            this.CargarMunicipios() 
                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
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
