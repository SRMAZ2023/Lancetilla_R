import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { LayoutService } from 'src/app/layout/service/app.layout.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { UsuarioViewModel } from 'src/app/demo/Models/UsuarioViewModel';
import { UsuarioCrud } from 'src/app/demo/Models/UsuarioViewModel';
import { UsuarioService } from 'src/app/demo/service/Usuario.service';
import { AppLayoutComponent } from "../../../../layout/app.layout.component";
import { Injectable, Inject } from '@angular/core';
import { LocalStorageService } from '../../../../local-storage.service';
import { Toast } from 'primeng/toast';



@Component({
  selector: 'app-login',
  providers: [MessageService, UsuarioService, Toast],
  styleUrls: ['./login-design.scss'],
  templateUrl: './login.component.html',
  styles: [`
    :host ::ng-deep .pi-eye,
    :host ::ng-deep .pi-eye-slash {
      transform:scale(1.6);
      margin-right: 1rem;
      color: var(--primary-color) !important;
    }
  `]
})
export class LoginComponent {

  
  isInputEmptyOrWhitespace(value: string | undefined): boolean {
    if (value === undefined) {
        return true; // Tratar 'undefined' como un valor vacío
    }

    return value.trim() === '';
}

  valCheck: string[] = ['remember'];

  public Usuario!: UsuarioViewModel
  password!: string;
  datos: any = {};
  submitted: boolean = false;
  usua_Contrasena!: string;

  constructor(
   
    private layoutService: LayoutService,
    private UsuarioService: UsuarioService,
    public messageService: MessageService,
    private _route: ActivatedRoute,
    private _router: Router ,
    private localStorage: LocalStorageService
   
  ) {  this.Usuario = new UsuarioViewModel(undefined, "", undefined, "", "", undefined, "", "", undefined, 1, true)}

  Ingresar() {
    // Verificar si todos los campos están llenos



      if(this.Usuario.usua_NombreUsuario == "" || this.Usuario.usua_Clave == ""){
        this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

      }
      else{
        if (
          this.Usuario.usua_NombreUsuario &&
          this.Usuario.usua_Clave
        ) {
          // Todos los campos están llenos, realizar acciones adicionales
          this.UsuarioService.Login(this.Usuario).subscribe(Response => {
            this.datos = Response;

           
            if (this.datos.data.usua_NombreUsuario == "Usuario o Contraseña Incorrectos") {
              this.messageService.add({
                severity: 'error',
                summary: 'Error:',
                detail: this.datos.data.usua_NombreUsuario,
                life: 3000
              });
            } else if (this.datos.code === 200) {
              this.messageService.add({
                severity: 'success',
                summary: 'Felicidades',
                detail: "Bienvenido "+ this.datos.data.usua_NombreUsuario ,                     
               
             
               
                life: 1500
              });
    
              console.log(this.datos.data.usua_NombreUsuario);
             this.localStorage.setItem('NombreUsuario', this.datos.data.usua_NombreUsuario);
             this.localStorage.setItem('UsuarioID', this.datos.data.usua_Id);
             this.localStorage.setItem('RolID', this.datos.data.role_Id);
             this.localStorage.setItem('EmpleadoNombre', this.datos.data.empl_Nombre);
             this.localStorage.setItem('EsAdmin', this.datos.data.usua_Admin);
    
        
              setTimeout(() => {
               this._router.navigate(['/app']);
              }, 1500);
            }
          }, error => {
            console.log(error);
          });
        }
      }
   
  }
}
