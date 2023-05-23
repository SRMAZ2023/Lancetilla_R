import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { LayoutService } from 'src/app/layout/service/app.layout.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { UsuarioViewModel } from 'src/app/demo/Models/UsuarioViewModel';
import { UsuarioCrud } from 'src/app/demo/Models/UsuarioViewModel';
import { UsuarioService } from 'src/app/demo/service/Usuario.service';
import { AppLayoutComponent } from "../../../../layout/app.layout.component";


@Component({
  selector: 'app-login',
  providers: [MessageService, UsuarioService],
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
    private _router: Router 
   
  ) {  this.Usuario = new UsuarioViewModel(undefined, "", undefined, "", "", undefined, "", "", undefined, 1, true)}

  Ingresar() {
    // Verificar si todos los campos están llenos

    this.messageService.add({
        severity: 'success',
        summary: 'Felicidades',
        detail: "sss",
        life: 1500
      });
     
    if (
      this.Usuario.usua_NombreUsuario &&
      this.Usuario.usua_Clave
    ) {
      // Todos los campos están llenos, realizar acciones adicionales
      console.log("Holaa")
      this.UsuarioService.Login(this.Usuario).subscribe(Response => {
        this.datos = Response;
        console.log(this.datos);
       
        if (this.datos.data.usua_NombreUsuario == "Usuario o Contraseña Incorrectos") {
          this.messageService.add({
            severity: 'info',
            summary: 'Error',
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
          setTimeout(() => {
           this._router.navigate(['../../../../layout']);
          }, 1500);
        }
      }, error => {
        console.log(error);
      });
    }
  }
}
