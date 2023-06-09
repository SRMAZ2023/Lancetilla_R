import { Component, OnInit } from '@angular/core';
import { CargoViewModel } from 'src/app/demo/Models/CargoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { CargosService } from 'src/app/demo/service/cargo.service';
import { error } from 'console';
import { UsuarioViewModel } from 'src/app/demo/Models/UsuarioViewModel';
import { UsuarioService } from 'src/app/demo/service/Usuario.service';
import { isUndefined } from 'util';
import { __values } from 'tslib';
import { ChangeDetectorRef } from '@angular/core';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

//import { Cargoss } from 'src/app/demo/api/CargossViewModel';


@Component({
    templateUrl: './usuarios.component.html',
    providers: [MessageService, UsuarioService]
})
export class UsuariosComponent implements OnInit {
    EsAdmin: any;
    Permiso: any;
    UsuarioES: any;

    //Dialogs
    InsertarUsuarioDialog: boolean = false;

    EditarUsuarioDialog: boolean = false;

    EliminarUsuariosDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    Usuarios: UsuarioViewModel[] = [];
    Usuario: UsuarioViewModel = {};

    //Paginacion de el datatable
    selectedUsuario: UsuarioViewModel[] = [];
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

    roles: any[] = []; // Array para almacenar los datos de roles
    empleados: any[] = []; // Array para almacenar los datos de empleados


    constructor( private _router: Router ,
        private localStorage: LocalStorageService,private changeDetectorRef: ChangeDetectorRef, private usuarioService: UsuarioService, private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Usuarios')
            this.UsuarioES = this.localStorage.getItem('UsuarioID')
        }
            

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

        this.CargarUsuarios()

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'usua_Id', header: 'usua_Id' },
            { field: 'usua_NombreUsuario', header: 'usua_NombreUsuario' },
            { field: 'empl_Nombre', header: 'empl_Nombre' },
            { field: 'role_Descripcion', header: 'role_Descripcion' },
            { field: 'usua_EsAdmin', header: 'usua_EsAdmin' },


        ];
        //Modelo de los datos de la tabla

    }

    CargarUsuarios() {
        this.usuarioService.ListarUsuario().subscribe(
            Response => {
                console.log(Response);
                this.Usuarios = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.InsertarUsuarioDialog = false;
        this.EditarUsuarioDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Usuario = {};
        this.submitted = false;
        this.InsertarUsuarioDialog = true;

        this.usuarioService.ListarRoles().subscribe(
            response => {
                console.log(response);
                this.roles = response.map((item: { role_Descripcion: any; role_Id: any; }) => ({
                    value: item.role_Id,
                    label: item.role_Descripcion
                }));
            },
            error => {
                console.log(error);
            }
        );

        this.usuarioService.ListarEmpleados().subscribe(
            response => {
                console.log(response);
                this.empleados = response.map((item: { empl_Nombre: any; empl_Id: any; }) => ({
                    value: item.empl_Id,
                    label: item.empl_Nombre
                }));
            },
            error => {
                console.log(error);
            }
        );
    }


    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editUsuario(usuarios: UsuarioViewModel) {
        console.log(usuarios);

        this.Usuario = { ...usuarios };

        this.usuarioService.ListarRoles().subscribe(
            response => {
                this.roles = response.map((item: { role_Descripcion: any; role_Id: any; }) => ({
                    value: item.role_Id,
                    label: item.role_Descripcion
                }));

            },
            error => {
                console.log(error);
            }
        );



        this.usuarioService.ListarEmpleados().subscribe(
            response => {
                this.empleados = response.map((item: { empl_Nombre: any; empl_Id: any; }) => ({
                    value: item.empl_Id,
                    label: item.empl_Nombre
                }));

                // Agregar el empleado que viene en la respuesta al principio de la lista de empleados
                this.empleados.unshift({
                    value: usuarios.empl_Id,
                    label: usuarios.empl_Nombre
                });

                // Establecer el empleado seleccionado en el select
                this.Usuario.empl_Id = usuarios.empl_Id;

                // Forzar una nueva detección de cambios
                this.changeDetectorRef.detectChanges();
            },
            error => {
                console.log(error);
            }
        );


        this.EditarUsuarioDialog = true;
    }


    //Toma los datos de ka tabla

    //Toma el id del item
    deleteUsuario(usuarios: UsuarioViewModel) {
        this.EliminarUsuariosDialog = true;
        this.Usuario = { ...usuarios };
        console.log(usuarios);
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.EliminarUsuariosDialog = false;
        this.Usuarios = this.Usuarios.filter(val => val.usua_Id !== this.Usuario.usua_Id);
        var params = {
            "usua_Id": this.Usuario.usua_Id
        }

        if (this.Usuario.usua_Id == this.UsuarioES) {
           
            this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: "No puedes eliminarte a ti mismo.", life: 3000 });
            this.CargarUsuarios()
        }else{
            this.usuarioService.EliminarUsuario(params).subscribe(
                Response => {
                    this.datos = Response;
    
                    if (this.datos.code == 409) {
    
                        this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });
                        this.CargarUsuarios()
                  
                    } else if (this.datos.code == 200) {
    
                        this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                        this.Usuario = {};
                        this.InsertarUsuarioDialog = false;
                        this.CargarUsuarios()
    
                    } else {
                        this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                    }
                },
                error => {
                    console.log("manzana")
                }
            );

        }

        

    }
    //Confirma el eliminar

    isInputEmptyOrWhitespace(value: string | undefined): boolean {
        if (value === undefined) {
            return true; // Tratar 'undefined' como un valor vacío
        }

        return value.trim() === '';
    }


    //Enviamos y editamos datos
    InsertarUsuario() {
        this.submitted = true;

        if (this.Usuario.usua_Admin == undefined) {
            this.Usuario.usua_Admin = false;
        }

        var params = {

            "usua_NombreUsuario": this.Usuario.usua_NombreUsuario ? this.Usuario.usua_NombreUsuario.trim() : '',
            "empl_Id": this.Usuario.empl_Id ? this.Usuario.empl_Id : 0,
            "usua_Clave": this.Usuario.usua_Clave ? this.Usuario.usua_Clave.trim() : '',
            "usua_Admin": this.Usuario.usua_Admin,
            "role_Id": this.Usuario.role_Id ? this.Usuario.role_Id : 0,
            "usua_UserCreacion": 1,
            "usua_UserModificacion": 1
        }



        if (this.Usuario.usua_NombreUsuario?.trim() === '') {
            console.log(this.Usuario.usua_NombreUsuario?.toString().length);
            this.espacio = true;
        }
        else if (Object.values(params).some(value => value === undefined || value === null || value === 0)) {
            console.log('Algunos campos están vacíos o son cero.');
            this.espacio = true;
        }



        if (params.usua_NombreUsuario == "" || params.usua_Clave == "" || params.empl_Id == 0 || params.empl_Id == undefined
            || params.role_Id == 0 || params.role_Id == undefined) {

            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        else {
            this.usuarioService.CrearUsuario(params).subscribe(
                Response => {
                    this.datos = Response;
                    if (this.datos.code == 409) {
                        this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });
                    }
                    else if (this.datos.code == 200) {
                        this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                        this.Usuario = {};
                        this.InsertarUsuarioDialog = false;
                        this.CargarUsuarios()
                    }
                    else {
                        this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
                    }
                },
                error => {
                    console.log(error);
                }
            )

        }

    }
    // Si todos los campos están llenos y no son cero, se procede con el envío de datos.


    EditarUsuario() {
        this.submitted = true;

        if (this.Usuario.usua_Admin == undefined) {
            this.Usuario.usua_Admin = false;
        }

        var params = {
            "usua_Id": this.Usuario.usua_Id,
            "usua_NombreUsuario": this.Usuario.usua_NombreUsuario ? this.Usuario.usua_NombreUsuario.trim() : '',
            "empl_Id": this.Usuario.empl_Id ? this.Usuario.empl_Id : 0,
            "usua_Clave": this.Usuario.usua_Clave ? this.Usuario.usua_Clave.trim() : '',
            "usua_Admin": this.Usuario.usua_Admin,
            "role_Id": this.Usuario.role_Id ? this.Usuario.role_Id : 0,
            "usua_UserCreacion": 1,
            "usua_UserModificacion": 1
        }

        console.log(params);

        if (this.Usuario.usua_NombreUsuario?.trim() === '') {
            console.log(this.Usuario.usua_NombreUsuario?.toString().length);
            this.espacio = true;
        }
        else if (Object.values(params).some(value => value === undefined || value === null || value === 0)) {
            console.log('Algunos campos están vacíos o son cero.');
            this.espacio = true;
        }


        if (params.usua_NombreUsuario == "" || params.usua_Clave == "" || params.empl_Id == 0 || params.empl_Id == undefined
            || params.role_Id == 0 || params.role_Id == undefined) {

            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        else {
            // Si todos los campos están llenos y no son cero, se procede con el envío de datos.
            this.usuarioService.EditarUsuario(params).subscribe(
                Response => {
                    this.datos = Response;
                    if (this.datos.code == 409) {
                        this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });
                        this.CargarUsuarios()
                    }
                    else if (this.datos.code == 200) {
                        this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                        this.Usuario = {};
                        this.EditarUsuarioDialog = false;
                        this.CargarUsuarios()
                    }
                    else {
                        this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
                    
                    }
                },
                error => {
                    console.log(error);
                }
            )
        }
    }

    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
