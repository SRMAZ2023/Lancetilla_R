import { Component, OnInit } from '@angular/core';
import { MunicipiosViewModel } from 'src/app/demo/Models/MunicipiosViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MunicipiosService } from 'src/app/demo/service/Municipios.service';
import { error } from 'console';
//import { Municipioss } from 'src/app/demo/api/MunicipiossViewModel';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
    templateUrl: './Municipios.component.html',
    providers: [MessageService, MunicipiosService]
})
export class MunicipiosComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;
    //Dialogs
    InsertMunicipiostDialog: boolean = false;
     //Dialogs
     EditarMunicipiostDialog: boolean = false;

    deleteMunicipiosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};

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
    Municipios: MunicipiosViewModel[] = [];
    Municipio: MunicipiosViewModel = {};

    departamentos: any[] = []; // Array para almacenar los datos de departamentos


    //Paginacion de el datatable
    selectedMunicipios: MunicipiosViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;


    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;

    departamentoselect: string = ""
    OTROdepartamentoselect: string = ""

    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private MunicipiosService: MunicipiosService, private messageService: MessageService) {
    
   this.EsAdmin = this.localStorage.getItem('EsAdmin')
   this.Permiso = this.localStorage.getItem('Municipios') }

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
        this.departamentoselect = ""
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

    filterInput(event: any) {
        const input = event.target as HTMLInputElement;
        input.value = input.value.replace(/\D/g, ''); // Eliminar todos los caracteres que no sean dígitos
        this.Municipio.muni_Id = input.value.substring(0, 4); // Obtener solo los primeros dos caracteres
    }
    
    CambiarID(id: string){

   this.departamentoselect = id
   this.OTROdepartamentoselect =  this.departamentoselect
    }

    //Confirma el eliminar
    validateNumericInput(inputElement: HTMLInputElement) {
        const numericValue = inputElement.value.replace(/[^0-9]/g, ''); // Filtrar caracteres no numéricos
        inputElement.value = numericValue; // Actualizar el valor del campo de entrada
        this.Municipio.muni_Id = numericValue; // Actualizar el valor en la propiedad vinculada al modelo
    }


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
       
     if (this.Municipio.muni_Id?.toString() != "" && this.Municipio.muni_Id?.toString() != undefined) {
        
        if (this.Municipio.muni_Id?.toString().length == 1) {
            
            this.Municipio.muni_Id = "0" + this.Municipio.muni_Id
        }
        
        this.Municipio.muni_Id =  this.OTROdepartamentoselect  + this.Municipio.muni_Id

     }

      console.log(this.Municipio.muni_Descripcion)
   

      var params = {
            "muni_Id": this.Municipio.muni_Id?.toString(),
            "muni_Descripcion": this.Municipio.muni_Descripcion?.trim(),
            "dept_Id": this.Municipio.dept_Id?.toString(),
            "dept_Descripcion": "d",
            "muni_UserCreacion": 1,
            "muni_UserModificacion": 1
        }

         console.log(params);
 
      

         
       
        //Validacion de params
        if (params.muni_Id?.toString() !== undefined &&
            params.muni_Id?.toString().length < 5  &&
            parseInt(params.muni_Id?.toString()) > 0 &&
            params.muni_Descripcion !== undefined &&
            params.muni_Descripcion !== "" &&
            params.dept_Id?.toString() !== undefined &&
            params.dept_Descripcion.trim() !== '' &&
            params.muni_UserCreacion !== undefined &&
            params.muni_UserModificacion !== undefined) {

            //Si insertara o editara
            if (!this.Editar) {

                this.MunicipiosService.CrearMunicipio(params).subscribe(
                    Response => {
                        this.datos = Response;
                        console.log(this.datos)
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                            this.Municipio.muni_Id = this.Municipio.muni_Id?.substring(2);

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Municipio = {};
                            this.InsertMunicipiostDialog = false;
                            this.departamentoselect = ""
                            this.CargarMunicipios() 
                        } else {
                            this.messageService.add({ severity: 'info', summary: 'Error', detail: "Fallo al Insertar en Codigo del municipio", life: 3000 });
                            this.Municipio.muni_Id = this.Municipio.muni_Id?.substring(2);
                        }
                    },
                    error => {
                        console.log(error);
                        this.Municipio.muni_Id = this.Municipio.muni_Id?.substring(2);
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
        else{ this.Municipio.muni_Id = this.Municipio.muni_Id?.substring(2);}
    }
    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
