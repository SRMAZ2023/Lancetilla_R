import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { EmpleadosViewModel } from 'src/app/demo/Models/EmpleadaoViewModel';
import { EmpleadosService } from 'src/app/demo/service/Empleados.service';
import { error } from 'console';

@Component({
    templateUrl: './empleados.component.html',
    providers: [MessageService, EmpleadosService]
})
export class empleadosComponent implements OnInit {

    //Dialogs
    empleadostDialog: boolean = false;

    deleteempleadosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos:any = {};


    public Editar: boolean = false;
    empleados: EmpleadosViewModel[] = [];
    empleado: EmpleadosViewModel = {};

    //Paginacion de el datatable
    selectedempleados: EmpleadosViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];


    constructor(private EmpleadosService: EmpleadosService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.EmpleadosService.getEmpleados().subscribe(
            Response => {
                console.log(Response);
                this.empleados = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'empl_Id', header: 'empl_Id' },
            { field: 'plan_Nombre', header: 'plan_Nombre' },
            { field: 'plan_NombreCientifico', header: 'plan_NombreCientifico' },
            { field: 'plan_Reino', header: 'plan_Reino' },
            { field: 'arbo_Descripcion', header: 'arbo_Descripcion' },
            { field: 'cuid_Descripcion', header: 'cuid_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.empleadostDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.empleado = {};
        this.submitted = false;
        this.empleadostDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editempleados(empleados: EmpleadosViewModel) {
        this.Editar = true;
        this.empleado = { ...empleados };
        this.empleadostDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteempleados(empleados: EmpleadosViewModel) {
        this.deleteempleadosDialog = true;
        this.empleado = { ...empleados };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteempleadosDialog = false;
        var empl_Id = this.empleado.empl_Id;
        var params = {
            "empl_Id": this.empleado.empl_Id,
            
        }
        console.log(params)
        this.EmpleadosService.DeleteEmpleados(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {
                    
                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });
                    
                } else if (this.datos.code == 200) {
                    
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.empleados = this.empleados.filter(val => val.empl_Id !== this.empleado.empl_Id);
                 

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



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
