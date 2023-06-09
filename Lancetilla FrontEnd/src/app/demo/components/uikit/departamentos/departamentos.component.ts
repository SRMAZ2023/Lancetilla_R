import { Component, OnInit } from '@angular/core';
import { DepartamentoViewModel } from 'src/app/demo/Models/DepartamentoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { DepartamentosService } from 'src/app/demo/service/departamento.service';
import { error } from 'console';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

//import { Departamentoss } from 'src/app/demo/api/DepartamentossViewModel';

@Component({
    templateUrl: './departamentos.component.html',
    providers: [MessageService, DepartamentosService]
})
export class DepartamentosComponent implements OnInit {

    EsAdmin: any;
    Permiso: any;

    //Dialogs
    InsertDepartamentostDialog: boolean = false;
     //Dialogs
     EditarDepartamentostDialog: boolean = false;

    deleteDepartamentosDialog: boolean = false;

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
    Departamentos: DepartamentoViewModel[] = [];
    Departamento: DepartamentoViewModel = {};

    //Paginacion de el datatable
    selectedDepartamentos: DepartamentoViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;


    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private DepartamentosService: DepartamentosService, private messageService: MessageService) {
  
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Departamentos')  }

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

       this.CargarDepartamentos()

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'dept_Id', header: 'dept_Id' },
            { field: 'dept_Descripcion', header: 'dept_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    CargarDepartamentos() {
        this.DepartamentosService.getCatgos().subscribe(
            Response => {
                console.log(Response);
                this.Departamentos = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    
   
    hideDialog() {
        this.InsertDepartamentostDialog = false;
        this.EditarDepartamentostDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Departamento = {};
        this.submitted = false;
        this.InsertDepartamentostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editDepartamentos(Departamentos: DepartamentoViewModel) {
        this.Editar = true;
        this.Departamento = { ...Departamentos };
        this.EditarDepartamentostDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteDepartamentos(Departamentos: DepartamentoViewModel) {
        this.deleteDepartamentosDialog = true;
        this.Departamento = { ...Departamentos };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteDepartamentosDialog = false;
        this.Departamentos = this.Departamentos.filter(val => val.dept_Id?.toString() !== this.Departamento.dept_Id?.toString());
        var params = {
            "dept_Id": this.Departamento.dept_Id?.toString(),
            "dept_Descripcion": "",
            "dept_UserCreacion": 1,
            "dept_UserModificacion": 1
        }

        this.DepartamentosService.DeleteDepartamentos(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                    this.CargarDepartamentos()
                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Departamento = {};
                    this.InsertDepartamentostDialog = false;
                    this.CargarDepartamentos()
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

    isInputEmptyOrWhitespace(value: string | undefined): boolean {
        if (value === undefined) {
            return true; // Tratar 'undefined' como un valor vacío
        }

        return value.trim() === '';
    }

    formatInputAsText(event: any) {
        const inputValue = event.target.value;
        const numericValue = inputValue.replace(/\D/g, ''); // Eliminar todos los caracteres que no sean dígitos
        this.Departamento.dept_Id = numericValue.toString();
    }

    filterInput(event: any) {
        const input = event.target as HTMLInputElement;
        input.value = input.value.replace(/\D/g, ''); // Eliminar todos los caracteres que no sean dígitos
        this.Departamento.dept_Id = input.value.slice(0, 2); // Obtener solo los primeros dos caracteres
    }

    

    //Enviamos y editamos datos
    saveDepartamentos() {
        this.submitted = true;

        console.log(this.Departamento.dept_Id?.toString().length)    
        if (this.Departamento.dept_Id?.toString().length == 1 && this.Editar == false) {
            
            this.Departamento.dept_Id = "0" + this.Departamento.dept_Id
        }

        var params = {
            "dept_Id": this.Departamento.dept_Id?.toString(),
            "dept_Descripcion": this.Departamento.dept_Descripcion ? this.Departamento.dept_Descripcion.trim() : '',
            "dept_UserCreacion": 1,
            "dept_UserModificacion": 1
        }


        if (this.Departamento.dept_Descripcion?.trim() == '') {
            console.log(this.Departamento.dept_Descripcion?.toString().length);
            this.espacio = true;
        }

       
       
        const deptId = params.dept_Id?.toString();
        if (deptId == undefined || parseInt(deptId) < 1 && this.Editar ==  false) {
            
            this.messageService.add({ severity: 'warn', summary: 'Advertencia', detail: "Ingrese un código válido.", life: 3000 });

        }
      
        if(params.dept_Descripcion == ""){
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El campo es requerido.', life: 3000 });

        }
        else{
            if (params.dept_Id?.toString() !== undefined &&
            params.dept_Id?.toString().length < 3  &&
            parseInt(params.dept_Id?.toString()) > 0 &&
            params.dept_Descripcion !== undefined &&
            params.dept_Descripcion.trim() !== '' &&
            params.dept_UserCreacion !== undefined &&
            params.dept_UserModificacion !== undefined) {

          

         console.log(this.Departamento.dept_Id?.toString());
            //Si insertara o editara
            if (!this.Editar) {

                this.DepartamentosService.postDepartamentos(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Departamento = {};
                            this.InsertDepartamentostDialog = false;
                            this.CargarDepartamentos()
                        } else {
                            this.messageService.add({ severity: 'warm', summary: 'Error', detail: this.datos.message, life: 3000 });
                        }
                    },
                    error => {
                        console.log(error);
                    }
                )

            } else {
                this.DepartamentosService.EditDepartamentos(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });
                           
                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Departamento = {};
                            this.EditarDepartamentostDialog = false;
                            
                            this.CargarDepartamentos()
                        
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
        }
       



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
