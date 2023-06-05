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




   Gráficas: any = false;
 

   Reporte: any = false;
   CuidadoPlantas: any = false;
   
   Empleados: any = false; 
   Visitantes: any = false;
   Cargos: any = false;
   Municipios: any = false;
   Departamentos: any = false;
   TiposDeMantenimiento: any = false;
   EstadoCivil: any = false;
   MantenimientoPorAnimal: any = false;
   Mantenimientos: any = false;
  
   CuidadoDePlantas: any = false;
   TiposDeCuidados: any = false;
   CuidadosGenerales: any = false;
   ÁreasBotánica: any = false;
   TiposDePlantas: any = false;
   Plantas: any = false;
   
   Hábitats: any = false;
   Alimentación: any = false;
   ÁreasZoológicas: any = false;
   Especies: any = false;
   Animales: any = false;
   Razas: any = false;
   
  
   Facturas: any = false;
   Tickets: any = false;
   MétodosDePago: any = false;
 
  
   Usuarios: any = false;
   Roles: any = false;
   


   

   model : any[] = []; 
   usuarioID: any;
   EsAdmin: any;
   RolID: any;
   datos: any = {};

   Mantenimiento: any[] = []; 
   Botanica: any[] = []; 
   Facturacion: any[] = []; 
   Zoologico: any[] = []; 
   Seguridad: any[] = [];
   



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
           
            console.log( this.datos);

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 1) {
                    this.Mantenimiento.push({ label: 'Empleados', icon: 'pi pi-user', routerLink: ['/app/uikit/Empleados']},);
                    
                    this.Empleados = true;

                }

                if (item.pant_Id === 2) {
                    this.Mantenimiento.push( { label: 'Mantenimientos', icon: 'pi pi-briefcase', routerLink: ['/app/uikit/Mantenimineto'] },);
                    this.Mantenimientos = true;
               
                }

                if (item.pant_Id === 3) {
                    this.Mantenimiento.push( { label: 'Visitantes', icon: 'pi pi-users', routerLink: ['/app/uikit/visitantes'] },);
                    this.Visitantes = true;
               
               
                }

                if (item.pant_Id === 4) {
                    this.Mantenimiento.push({ label: 'Cargos', icon: 'pi pi-desktop', routerLink: ['/app/uikit/cargos'] },);
                    this.Cargos = true;
                  
               
                }

                if (item.pant_Id === 5) {
                    this.Mantenimiento.push( { label: 'Municipios', icon: 'pi pi-home', routerLink: ['/app/uikit/Municipios'] },);
                
                    this.Municipios = true;
                   
                }

                if (item.pant_Id === 6) {
                    this.Mantenimiento.push( { label: 'Departamentos', icon: 'pi pi-map', routerLink: ['/app/uikit/departamentos'] },);
                    
                    this.Departamentos = true;
                  
                
                }

                if (item.pant_Id === 7) {
                    this.Mantenimiento.push({ label: 'Tipos De Mantenimiento', icon: 'pi pi-wrench', routerLink: ['/app/uikit/TiposDeMantenimiento'] },);
               
                       
                    this.TiposDeMantenimiento = true;
                  
                }

                if (item.pant_Id === 8) {
                    this.Mantenimiento.push({ label: 'Estado Civil', icon: 'pi pi-envelope', routerLink: ['/app/uikit/EstadoCivil'] },);
                
                    this.EstadoCivil = true;
                   
                
                }

                if (item.pant_Id === 9) {
                    this.Mantenimiento.push( { label: 'Mantenimiento Por Animal', icon: 'pi pi-cog', routerLink: ['/app/uikit/ManteniminetoXAnimal'] },);
                    this.MantenimientoPorAnimal = true;
                
                }

             
            });
           
          
            
            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 10) {
                    this.Botanica.push( { label: 'Cuidado de Plantas', icon: 'pi pi-apple', routerLink: ['/app/uikit/cuidadosplantas'] },);
                    this.CuidadoDePlantas = true;
               
               
                }
            });

           
            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 11) {
                    this.Botanica.push({ label: 'Tipos de Cuidados', icon: 'pi pi-arrows-v', routerLink: ['/app/uikit/TipoCuidado'] },);
               
                    this.TiposDeCuidados = true;

                  
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 12) {
                    this.Botanica.push( { label: 'Cuidados Generales', icon: 'pi pi-compass', routerLink: ['/app/uikit/Cuidados'] },);
               
                    this.CuidadosGenerales = true;
                  
                }
            });




            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 13) {
                    this.Botanica.push({ label: 'Áreas Botánica', icon: 'pi pi-gift', routerLink: ['/app/uikit/areasbotanicas'] },);
               
                    this.ÁreasBotánica = true;
                  
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 14) {
                    this.Botanica.push( { label: 'Tipos de Plantas', icon: 'pi pi-palette', routerLink: ['/app/uikit/TiposPlantas'] },);
                    this.TiposDePlantas = true;
                  
                
                }
            });


            

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 15) {
                    this.Botanica.push({ label: 'Plantas', icon: 'pi pi-slack', routerLink: ['/app/uikit/Plantas'] },);
                    this.Plantas = true;
                  
                
                }
            });
            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 16) {
                    this.Zoologico.push(  { label: 'Hábitat', icon: 'pi pi-qrcode', routerLink: ['/app/uikit/habitat'] },);
                    this.Hábitats = true;
                
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 17) {
                    this.Zoologico.push( { label: 'Alimentación', icon: 'pi pi-sitemap', routerLink: ['/app/uikit/alimentacion'] },);
                
                       
                   this.Alimentación = true;
                                      
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 18) {
                    this.Zoologico.push( { label: 'Áreas Zoológicas', icon: 'pi pi-sun', routerLink: ['/app/uikit/areaszoologicas'] },);
                
                    this.ÁreasZoológicas = true;
                 
                
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 19) {
                    this.Zoologico.push( { label: 'Especies', icon: 'pi pi-th-large', routerLink: ['/app/uikit/Especies'] },);
                    this.Especies = true;
               
                }
            });

            
            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 20) {
                    this.Zoologico.push(  { label: 'Animales', icon: 'pi pi-twitter', routerLink: ['/app/uikit/animales'] },);
                    this.Animales = true;
                   
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 21) {
                    this.Zoologico.push(   { label: 'Razas', icon: 'pi pi-star-fill', routerLink: ['/app/uikit/razas'] },);
                    this.Razas = true;
                   
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 22) {
                    this.Facturacion.push( { label: 'Facturas', icon: 'pi pi-paypal', routerLink: ['/app/uikit/facturas'] },);
                    this.Facturas = true;
              
                }
            });



            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 23) {
                    this.Facturacion.push({ label: 'Tickets', icon: 'pi pi-ticket', routerLink: ['/app/uikit/Tickets'] },);
                    this.Tickets = true;
   
                
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 24) {
                    this.Facturacion.push( { label: 'Metodos de pago', icon: 'pi pi-money-bill', routerLink: ['/app/uikit/MetodoDePago'] },);
                    
                   this.MétodosDePago = true;
   
                }
            });


            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 25) {
                    this.Seguridad.push(  { label: 'Usuarios', icon: 'pi pi-user-plus', routerLink: ['/app/uikit/Usuarios'] },);              
                    this.Usuarios = true;
                 
                }
            });

            this.datos.forEach((item: DatosItem) => {
                if (item.pant_Id === 26) {
                    this.Seguridad.push({ label: 'Roles', icon: 'pi pi-upload', routerLink: ['/app/uikit/RolesPorPantalla'] },);
             
                    this.Roles = true;
                       
                }
            });

            this.localStorage.setItem('Empleados', this.Empleados);
            this.localStorage.setItem('Mantenimientos', this.Mantenimientos);
            this.localStorage.setItem('Visitantes', this.Visitantes);
            this.localStorage.setItem('Cargos', this.Cargos);
            this.localStorage.setItem('Municipios', this.Municipios);
            this.localStorage.setItem('Departamentos', this.Departamentos);        
            this.localStorage.setItem('TiposDeMantenimiento', this.TiposDeMantenimiento);
            this.localStorage.setItem('EstadoCivil', this.EstadoCivil);
            this.localStorage.setItem('MantenimientoPorAnimal', this.MantenimientoPorAnimal);
         
            this.localStorage.setItem('CuidadoDePlantas', this.CuidadoDePlantas);
            this.localStorage.setItem('TiposDeCuidados', this.TiposDeCuidados);
            this.localStorage.setItem('CuidadosGenerales', this.CuidadosGenerales);
            this.localStorage.setItem('ÁreasBotánica', this.ÁreasBotánica);
            this.localStorage.setItem('TiposDePlantas', this.TiposDePlantas);
            this.localStorage.setItem('Plantas', this.Plantas);
           
            this.localStorage.setItem('Hábitats', this.Hábitats);
            this.localStorage.setItem('Alimentación', this.Alimentación);
            this.localStorage.setItem('ÁreasZoológicas', this.ÁreasZoológicas);
            this.localStorage.setItem('Especies', this.Especies);
            this.localStorage.setItem('Animales', this.Animales);
            this.localStorage.setItem('Razas', this.Razas);
         
            this.localStorage.setItem('Facturas', this.Facturas);
            this.localStorage.setItem('Tickets', this.Tickets);
            this.localStorage.setItem('MétodosDePago', this.MétodosDePago);
          
            this.localStorage.setItem('Usuarios', this.Usuarios);
            this.localStorage.setItem('Roles', this.Roles);
          
         

           
            this.model = [
                {
                  label: 'Inicio',
                  items: [
                    { label: 'Inicio', icon: 'pi pi-fw pi-home', routerLink: ['/app'] },
                    { label: 'Gráficas', icon: 'pi pi-chart-line', routerLink: ['/app/uikit/charts'] },  
                  ]
                },
                
              
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
                    label: 'Botánica',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Botánica',
                        icon: 'pi pi-fw pi-user',
                        items: this.Botanica
                      }
                    ]
                  }] : []),
                
                 
              

                  ...(this.Zoologico.length > 0 ? [{
                    label: 'Zoológico',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Zoológico',
                        icon: 'pi pi-fw pi-user',
                        items: this.Zoologico
                      }
                    ]
                  }] : []),

                  ...(this.Facturacion.length > 0 ? [{
                    label: 'Facturación',
                    icon: 'pi pi-fw pi-briefcase',
                    items: [
                      {
                        label: 'Páginas de Facturación',
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
                    { label: 'Gráficas', icon: 'pi pi-chart-line', routerLink: ['/app/uikit/charts'] },  
              
                   
                ]
            },
          
            {
                label: 'Mantenimiento',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Páginas de Mantenimeinto',
                        icon: 'pi pi-fw pi-user',
                        items: [
                                { label: 'Empleados', icon: 'pi pi-user', routerLink: ['/app/uikit/Empleados'] },  
                                { label: 'Mantenimiento', icon: 'pi pi-briefcase', routerLink: ['/app/uikit/Mantenimineto'] },             
                                { label: 'Visitantes', icon: 'pi pi-users', routerLink: ['/app/uikit/visitantes'] },                              
                                { label: 'Cargos', icon: 'pi pi-desktop', routerLink: ['/app/uikit/cargos'] },
                                { label: 'Municipios', icon: 'pi pi-home', routerLink: ['/app/uikit/Municipios'] },
                                { label: 'Departamentos', icon: 'pi pi-map', routerLink: ['/app/uikit/departamentos'] },
                                { label: 'Tipos De Mantenimiento', icon: 'pi pi-wrench', routerLink: ['/app/uikit/TiposDeMantenimiento'] },           
                                { label: 'Estado Civil', icon: 'pi pi-envelope', routerLink: ['/app/uikit/EstadoCivil'] },
                                { label: 'Mantenimiento Por Animal', icon: 'pi pi-cog', routerLink: ['/app/uikit/ManteniminetoXAnimal'] },
                        ]
                    },
                   
                ]
            },    
            {
                label: 'Botánica',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Páginas de Botánica',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Cuidados de Plantas', icon: 'pi pi-apple', routerLink: ['/app/uikit/CuidadoPlantas'] }, 
                            { label: 'Tipos de Cuidados', icon: 'pi pi-arrows-v', routerLink: ['/app/uikit/TipoCuidado'] },
                            { label: 'Cuidados Generales', icon: 'pi pi-compass', routerLink: ['/app/uikit/Cuidados'] },
                            { label: 'Áreas Botánica', icon: 'pi pi-gift', routerLink: ['/app/uikit/areasbotanicas'] },
                            { label: 'Tipos de Plantas', icon: 'pi pi-palette', routerLink: ['/app/uikit/TiposPlantas'] },
                            { label: 'Plantas', icon: 'pi pi-slack', routerLink: ['/app/uikit/Plantas'] },
                        ]
                    },
                   
                ]
            },       
            
            {
                label: 'Zoológico',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Páginas de Zoológico',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Hábitats', icon: 'pi pi-qrcode', routerLink: ['/app/uikit/habitat'] },
                            { label: 'Alimentación', icon: 'pi pi-sitemap', routerLink: ['/app/uikit/alimentacion'] },
                            { label: 'Áreas Zoológicas', icon: 'pi pi-sun', routerLink: ['/app/uikit/areaszoologicas'] },
                            { label: 'Especies', icon: 'pi pi-th-large', routerLink: ['/app/uikit/Especies'] },
                            { label: 'Animales', icon: 'pi pi-twitter', routerLink: ['/app/uikit/animales'] },
                            { label: 'Razas', icon: 'pi pi-star-fill', routerLink: ['/app/uikit/razas'] },
                        ]
                    },
                   
                ]
            },   
            {
                label: 'Facturación',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Páginas de Facturación',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Facturas', icon: 'pi pi-paypal', routerLink: ['/app/uikit/facturas'] },
                     
                            { label: 'Tickets', icon: 'pi pi-ticket', routerLink: ['/app/uikit/Tickets'] },
                            { label: 'Métodos de Pago', icon: 'pi pi-money-bill', routerLink: ['/app/uikit/MetodoDePago'] },
                        ]
                    },
                   
                ]
            },     
            {
                label: 'Seguridad',
                icon: 'pi pi-fw pi-briefcase',
                items: [                 
                    {
                        label: 'Páginas de Seguridad',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            { label: 'Usuarios', icon: 'pi pi-user-plus', routerLink: ['/app/uikit/Usuarios'] },
                            { label: 'Roles', icon: 'pi pi-upload', routerLink: ['/app/uikit/RolesPorPantalla'] },
                        ]
                    },
                   
                ]
            }
        
            
                  
            
            
         
         ];
     }
   }
}
      
