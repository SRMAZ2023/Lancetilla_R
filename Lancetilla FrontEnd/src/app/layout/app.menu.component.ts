import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { LayoutService } from './service/app.layout.service';
import { Console } from 'console';
import { LocalStorageService } from '../local-storage.service';
import { RolesPorPantallaService } from 'src/app/demo/service/RolesPorPantalla';
import { RolesViewModel, RolesPorPantallaViewModel } from 'src/app/demo/Models/RolesPorPantallaViewModel';

interface DatosItem {
    pant_Id: number;
    // Otros campos en DatosItem
}
@Component({
    selector: 'app-menu',
    templateUrl: './app.menu.component.html',
    providers: [RolesPorPantallaService]
})
export class AppMenuComponent implements OnInit {

    model : any[] = []; 
    usuarioID: any;
    EsAdmin: any;
    RolID: any;
    datos: any = {};

    Mantenimiento : any[] = []; 
    
    Botanica : any[] = []; 

    Facturacion : any[] = []; 

    Zoologico : any[] = []; 

    Seguridad : any[] = []; 

    constructor(public layoutService: LayoutService,private rolesPorPantallaService: RolesPorPantallaService,private localStorage: LocalStorageService) { 
     
        this.usuarioID = this.localStorage.getItem('UsuarioID')
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.RolID = this.localStorage.getItem('RolID')
    }

  
    Pantallas() {
        
       
     
      
        var params = {
          "role_Id": this.RolID
        };
      
        
        this.rolesPorPantallaService.PantallasPorRol(params).subscribe(
          Response => {
            this.datos = Response;
           
            console.log(  this.datos);

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 1) {
                    this.Mantenimiento.push({ label: 'Empleados', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Empleados']},);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 2) {
                    this.Mantenimiento.push( { label: 'Visitantes', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/visitantes'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 3) {
                    this.Mantenimiento.push({ label: 'Tipos De Mantenimiento', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/TiposDeMantenimiento'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 4) {
                    this.Mantenimiento.push( { label: 'Mantenimientos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Mantenimineto'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 5) {
                    this.Mantenimiento.push( { label: 'Mantenimiento Animal', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/ManteniminetoXAnimal'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 6) {
                    this.Mantenimiento.push( { label: 'Departamentos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/departamentos'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 7) {
                    this.Mantenimiento.push( { label: 'Municipios', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Municipios'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 8) {
                    this.Mantenimiento.push({ label: 'Estado Civil', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/EstadoCivil'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 9) {
                    this.Mantenimiento.push({ label: 'Cargos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/cargos'] },);
                }
            });


            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 10) {
                    this.Botanica.push({ label: 'Áreas Botánica', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/areasbotanicas'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 11) {
                    this.Botanica.push( { label: 'Cuidado de Plantas', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/cuidadosplantas'] },);
                }
            });


            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 12) {
                    this.Botanica.push({ label: 'Plantas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Plantas'] },);
                }
            });


            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 13) {
                    this.Facturacion.push({ label: 'Tickets', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/Especies'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 14) {
                    this.Facturacion.push( { label: 'Metodos de pago', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/MetodoDePago'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 15) {
                    this.Facturacion.push( { label: 'Facturas', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/Especies'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 16) {
                    this.Zoologico.push( { label: 'Áreas Zoológicas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/areaszoologicas'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 17) {
                    this.Zoologico.push(  { label: 'Hábitat', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/habitat'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 18) {
                    this.Zoologico.push( { label: 'Especies', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/Especies'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 19) {
                    this.Zoologico.push( { label: 'Alimentacion', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/alimentacion'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 20) {
                    this.Zoologico.push(  { label: 'Animales', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/animales'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 21) {
                    this.Seguridad.push(  { label: 'Usuarios', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Usuarios'] },);
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 22) {
                    this.Seguridad.push({ label: 'Roles', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/RolesPorPantalla'] },);
                }
            });

            
            this.model = [
                {
                  label: 'Inicio',
                  items: [
                    { label: 'Inicio', icon: 'pi pi-fw pi-home', routerLink: ['/app'] }
                  ]
                },
                // ... otros elementos del menú ...
                
                // Pestaña de Mantenimiento (con condición)
                ...(this.Mantenimiento.length > 0 ? [{
                  label: 'Mantenimiento',
                  icon: 'pi pi-fw pi-briefcase',
                  items: [
                    {
                      label: 'Páginas de Mantenimiento',
                      icon: 'pi pi-fw pi-user',
                      items: this.Mantenimiento
                    }
                  ]
                }] : []),
              
                 
                ...(this.Botanica.length > 0 ? [{
                    label: 'Botanica',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Botanica',
                        icon: 'pi pi-fw pi-user',
                        items: this.Botanica
                      }
                    ]
                  }] : []),

                  ...(this.Zoologico.length > 0 ? [{
                    label: 'Zoologico',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Zoologico',
                        icon: 'pi pi-fw pi-user',
                        items: this.Zoologico
                      }
                    ]
                  }] : []),

                  ...(this.Facturacion.length > 0 ? [{
                    label: 'Facturacion',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Facturacion',
                        icon: 'pi pi-fw pi-user',
                        items: this.Facturacion
                      }
                    ]
                  }] : []),

                  ...(this.Seguridad.length > 0 ? [{
                    label: 'Seguridad',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Seguridad',
                        icon: 'pi pi-fw pi-user',
                        items: this.Seguridad
                      }
                    ]
                  }] : []),
                 
              ];
              
                      
        },
          error => {
            console.log("manzana");
          }
        );
      }
  
  
  
    ngOnInit() {
               
      if (this.EsAdmin == false) {
        this.Pantallas()
      }
      else{

        this.model = [
            {
                label: 'Inicio',
                items: [
                    { label: 'Inicio', icon: 'pi pi-fw pi-home', routerLink: ['/app'] },
                    { label: 'Graficas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/charts'] },  
                    { label: 'Reporte Factura', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Reporte Factura'] },  
                ]
            },
          
            {
                label: 'Mantenimiento',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Paginas de Mantenimeinto',
                        icon: 'pi pi-fw pi-user',
                        items: [
                                { label: 'Empleados', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Empleados'] },  
                                { label: 'Manteniminto', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Mantenimineto'] },             
                                { label: 'Visitantes', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/visitantes'] },                              
                                { label: 'Cargos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/cargos'] },
                                { label: 'Municipios', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Municipios'] },
                                { label: 'Departamentos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/departamentos'] },
                                { label: 'Tipos De Mantenimiento', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/TiposDeMantenimiento'] },           
                                { label: 'Metodo De Pago', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/MetodoDePago'] },
                                { label: 'Estado Civil', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/EstadoCivil'] },
                                { label: 'Mantenimiento Animal', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/ManteniminetoXAnimal'] },
                        ]
                    },
                   
                ]
            },    
            {
                label: 'Botanica',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Pagina de Botanica',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Cuidado de Plantas', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/cuidadosplantas'] },
                            { label: 'Áreas Botánica', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/areasbotanicas'] },
                            { label: 'Plantas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Plantas'] },
                        ]
                    },
                   
                ]
            },       
            
            {
                label: 'Zoologico',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Paginas de Zoologico',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Hábitat', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/habitat'] },
                            { label: 'Alimentacion', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/alimentacion'] },
                            { label: 'Áreas Zoológicas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/areaszoologicas'] },
                            { label: 'Especies', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/Especies'] },
                            { label: 'Animales', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/animales'] },
                        ]
                    },
                   
                ]
            },   
            {
                label: 'Facturacion',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Paginas de Facturacion',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Facturas', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/Especies'] },
                            { label: 'Tickets', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/Especies'] },
                            { label: 'Metodos de pago', icon: 'pi pi-fw pi-id-card', routerLink: ['/app/uikit/MetodoDePago'] },
                        ]
                    },
                   
                ]
            },     
            {
                label: 'Seguridad',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Paginas de Seguridad',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Usuarios', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/Usuarios'] },
                            { label: 'Roles', icon: 'pi pi-fw pi-bookmark', routerLink: ['/app/uikit/RolesPorPantalla'] },
                        ]
                    },
                   
                ]
            }
        
            
                  
            
            
         
         ];
     }
   }
}
      
