import { Component, OnInit } from '@angular/core';
import { RolesPorPantallaViewModel } from 'src/app/demo/Models/RolesPorPantallaViewModel';
import { RolesViewModel } from 'src/app/demo/Models/RolesPorPantallaViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { RolesPorPantallaService } from 'src/app/demo/service/RolesPorPantalla';
import { error } from 'console';
import { ProductService } from 'src/app/demo/service/product.service';
//import { Cargoss } from 'src/app/demo/api/CargossViewModel';
import { Product } from 'src/app/demo/api/product';
import { forkJoin } from 'rxjs';

import { LocalStorageService } from '../../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';


interface expandedRows {
    [key: string]: boolean;
}


@Component({
    templateUrl: './RolesPorPantallas-Insert.component.html',
    providers: [MessageService, RolesPorPantallaService]
})
export class RolesPorPantallaInsertComponent implements OnInit {
  EsAdmin: any;
  Permiso: any;

    //Dialogs
    CargostDialog: boolean = false;

    deleteCargosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};
    shouldShowCard = false;
  

    public Editar: boolean = false;
    public RolElejido: any = 0;

    Roles: RolesViewModel[] = [];
    Pantallass: RolesPorPantallaViewModel[] = [];

    Rol: RolesViewModel = {};

    RolSelecionado: RolesViewModel = {};

    pantallas: any = {};
    //Paginacion de el datatable
   
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;
    isExpanded: boolean = false;

    isDisabled2: boolean = true; 
    selectedPantallas: any[] = [];

    cols: any[] = [];
    products: Product[] = [];

    expandedRow: any = null;

    pantallasSinRol: any[] =  [];

    public isDisabled: boolean = false;
    
    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;
    expandedRows: RolesPorPantallaViewModel[] = [];
   

    constructor( private _router: Router ,
      private localStorage: LocalStorageService,private productService: ProductService, private rolesPorPantallaService: RolesPorPantallaService, private messageService: MessageService) {
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('Roles')}

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

      this.Pantallas()
      this.PantallasSinRol()
    

    }

    PantallasSinRol() {
    
      var params = {
        "role_Id": this.RolSelecionado
      };
    
      
      this.rolesPorPantallaService.PantallasSinRol(params).subscribe(
        Response => {
         this.pantallas = Response
          console.log(Response);
          this.pantallasSinRol = this.pantallas;
               
        },
        error => {
          console.log("manzana");
        }
      );

      

    }

    


    AgregarPantallas() {
      const params = {
        "role_Id": this.RolSelecionado,
        "pant_Id": 0,
        "role_Descripcion": "string",
        "pant_Descripcion": "string",
        "ropa_UserCreacion": 1,
        "ropa_UserModificacion": 0
      };
    
      let contador = 0;
      const requests = [];
    
      for (const pantalla of this.selectedPantallas) {
        params.pant_Id = pantalla.pant_Id;
        requests.push(this.rolesPorPantallaService.AgregarPantallas(params));
      }
    
      forkJoin(requests).subscribe(
        (responses: any[]) => {
          for (const response of responses) {
            this.datos = response;
    
            if (this.datos.code == 409) {
              this.messageService.add({ severity: 'info', summary: 'Atención', detail: this.datos.message, life: 3000 });
            } else if (this.datos.code == 200) {
              contador++;
              this.Pantallas();
              this.PantallasSinRol();
            } else {
              this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
            }
          }
    
          if (contador > 0) {
            if (contador === 1) {
              this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Pantalla ingresada exitosamente', life: 3000 });
            } else {
              this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Pantallas ingresadas exitosamente', life: 3000 });
            }
          }
        },
        error => {
          console.log("manzana");
        }
      );
    
      this.selectedPantallas = [];
    }
    
    

    Pantallas() {
    
      var params = {
        "role_Id": this.RolSelecionado
      };
    
      console.log(params);
      this.rolesPorPantallaService.PantallasPorRol(params).subscribe(
        Response => {
          this.datos = Response;
          console.log(this.datos);
    
               
        },
        error => {
          console.log("manzana");
        }
      );

      

    }
    
  
    toggleRow(row: any) {
      if (this.isRowExpanded(row)) {
        this.expandedRow = null;
      } else {
        this.expandedRow = row;
      }
    }
    
    isRowExpanded(row: any): boolean {
      return this.expandedRow === row;
    }
   
        
    CrearRol() {
   
      var params = {
        "role_Id": 0       ,
        "role_Descripcion": this.Rol.role_Descripcion ? this.Rol.role_Descripcion.trim() : '',    
        "role_UserCreacion": 1,
        "role_UserModificacion": 1
      }
      
      if(params.role_Descripcion == ""){
        this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: "El campo es requerido.", life: 3000 });

      }
      else{
        if (this.Rol.role_Descripcion != undefined && this.Rol.role_Descripcion != "") {
            this.rolesPorPantallaService.CrearRoles(params).subscribe(
              Response => {
                  this.datos = Response;
               
                
                  if (this.datos.data.role_Descripcion == "El rol ya existe.") {
                      
                      this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: "El rol ya existe.", life: 3000 });
                      
                  } else if (this.datos.data.role_Descripcion == "Rol creado con éxito.") {
                      
                      this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: "Rol creado con éxito.", life: 3000 });
                      console.log(this.datos.data)
                     
                      this.RolSelecionado = this.datos.data.role_Id
                      this.isDisabled2 = false;
                      this.isDisabled = true;

                      this.shouldShowCard = true;
    
                      this.Pantallas()
                      this.PantallasSinRol()
                            
    
                  } else {
                      this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
                  }
              },
              error => {
                  console.log("manzana")
              }
          );
          }
      }
          
      
     

  }
      
       
    EliminarPantallas(Pantallas: RolesPorPantallaViewModel) {
   
      var params = {
        "role_Id": this.RolSelecionado,
        "pant_Id": Pantallas.pant_Id,
        "role_Descripcion": "string",     
        "pant_Descripcion": "string",
        "ropa_UserCreacion": 0,
        "ropa_UserModificacion": 0
      }

       
      console.log(params)
      this.rolesPorPantallaService.EliminarPantallas(params).subscribe(
          Response => {
              this.datos = Response;
           
              if (this.datos.code == 409) {
                  
                  this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });
                  
              } else if (this.datos.code == 200) {
                  
                  this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                 
                  this.Pantallas()
                  this.PantallasSinRol()
                  this.selectedPantallas = []

              } else {
                  this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
              }
          },
          error => {
              console.log("manzana")
          }
      );

  }
      
   
    //Metodo que desactiva el dialog

    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador



}
