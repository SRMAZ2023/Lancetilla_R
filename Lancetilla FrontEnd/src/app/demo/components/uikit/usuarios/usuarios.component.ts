import { Component, OnInit } from '@angular/core';
import { CargoViewModel } from 'src/app/demo/Models/CargoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { CargosService } from 'src/app/demo/service/cargo.service';
import { error } from 'console';
import { UsuarioViewModel } from 'src/app/demo/Models/UsuarioViewModel';
import { UsuarioService } from 'src/app/demo/service/Usuario.service';
//import { Cargoss } from 'src/app/demo/api/CargossViewModel';

@Component({
    templateUrl: './usuarios.component.html',
    providers: [MessageService, UsuarioService]
})
export class UsuariosComponent implements OnInit {

    //Dialogs
    UsuariotDialog: boolean = false;

    deleteUsuarioDialog: boolean = false;

    deleteProductDialog: boolean = false;
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

    cols: any[] = [];

    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;


    constructor(private usuarioService: UsuarioService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.usuarioService.ListarUsuario().subscribe(
            Response => {
                console.log(Response);
                this.Usuarios = Response
            },
            error => (
                console.log(error)
            )
        );

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

    //Metodo que desactiva el dialog
    hideDialog() {
        this.UsuariotDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Usuario = {};
        this.submitted = false;
        this.UsuariotDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editAlimentacion(alimentos: UsuarioViewModel) {
        this.Editar = true;
        this.Usuario = { ...alimentos };
        this.UsuariotDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteAlimentacion(alimentos: UsuarioViewModel) {
        this.deleteUsuarioDialog = true;
        this.Usuario = { ...alimentos };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteUsuarioDialog = false;   
        this.Usuarios = this.Usuarios.filter(val => val.usua_Id !== this.Usuario.usua_Id);
        var params = {
            "usua_Id": this.Usuario.usua_Id                           
        }

        this.usuarioService.EliminarUsuario(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.Usuario = {};
                    this.UsuariotDialog = false;

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


    //Enviamos y editamos datos
    InsertarUsuario() {
        this.submitted = true;

        var params = {
            "usua_Id": this.Usuario.usua_Id,
            "usua_NombreUsuario": this.Usuario.usua_NombreUsuario!.trim(),
            "empl_Id": this.Usuario.empl_Id,
            "usua_Clave": this.Usuario.usua_Clave!.trim(),
            "usua_Admin": this.Usuario.usua_Admin,
            "role_Id": this.Usuario.role_Id,       
           
            "usua_UserCreacion": 1,
            "usua_UserModificacion": 1
        }


        if (this.Usuario.usua_NombreUsuario?.trim() == '') {
            console.log(this.Usuario.usua_NombreUsuario?.toString().length);
            this.espacio = true;
        }
        //Validacion de params
        if (params.usua_NombreUsuario !== undefined) {

            //Si insertara o editara
           

                this.usuarioService.CrearUsuario(params).subscribe(
                    Response => {
                        this.datos = Response;
                        if (this.datos.code == 409) {

                            this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                        } else if (this.datos.code == 200) {

                            this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                            this.Usuario = {};
                            this.UsuariotDialog = false;

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
    //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
