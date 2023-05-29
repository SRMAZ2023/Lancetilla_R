import { Component, OnInit } from '@angular/core';
import { RolesPorPantallaViewModel } from 'src/app/demo/Models/RolesPorPantallaViewModel';
import { RolesViewModel } from 'src/app/demo/Models/RolesPorPantallaViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { RolesPorPantallaService } from 'src/app/demo/service/RolesPorPantalla';
import { Console, error } from 'console';
import { ProductService } from 'src/app/demo/service/product.service';
//import { Cargoss } from 'src/app/demo/api/CargossViewModel';
import { Product } from 'src/app/demo/api/product';
import { ActivatedRoute } from '@angular/router';





@Component({
    templateUrl: './RolesPorPantallas-Update.component.html',
    providers: [MessageService, RolesPorPantallaService]

})
export class RolesPorPantallaUpdateComponent implements OnInit {

  role_Id: string = "";
  role_Descripcion: string = "";
 


    //Dialogs
    CargostDialog: boolean = false;

    deleteCargosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};
  

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

   
    selectedPantallas: any[] = [];

    cols: any[] = [];
    products: Product[] = [];

    expandedRow: any = null;

    pantallasSinRol: any[] =  [];

   
    
    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;
    expandedRows: RolesPorPantallaViewModel[] = [];
   

    constructor(private route: ActivatedRoute, private productService: ProductService, private rolesPorPantallaService: RolesPorPantallaService, private messageService: MessageService) {
      
    }

    ngOnInit() {
 
      this.route.paramMap.subscribe(params => {
        this.role_Id = params.get('role_Id') ?? '';
        this.role_Descripcion = params.get('role_Descripcion') ?? '';
        console.log(this.role_Id);
        console.log(this.role_Descripcion);
        this.Rol.role_Descripcion = this.role_Descripcion 
      });
       
     console.log(this.role_Id)
      this.Pantallas()
      this.PantallasSinRol()
    

    }

    PantallasSinRol() {
    
      var params = {
        "role_Id": this.role_Id
      };
    
      console.log(params);
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
        "role_Id":   this.role_Id,
        "pant_Id": 0,
        "role_Descripcion": "string",
        "pant_Descripcion": "string",
        "ropa_UserCreacion": 1,
        "ropa_UserModificacion": 0
      };
    
      for (const pantalla of this.selectedPantallas) {
        params.pant_Id = pantalla.pant_Id; // Asignar el ID de la pantalla actual al parámetro pant_Id
    
        this.rolesPorPantallaService.AgregarPantallas(params).subscribe(
          Response => {
            this.datos = Response;
    
            if (this.datos.code == 409) {
              this.messageService.add({ severity: 'info', summary: 'Atención', detail: this.datos.message, life: 3000 });
            } else if (this.datos.code == 200) {
              this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
              this.Pantallas();
              this.PantallasSinRol();
            } else {
              this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
            }
          },
          error => {
            console.log("manzana");
          }
        );
      }
      this.selectedPantallas = []
    }
    

    Pantallas() {
    
      var params = {
        "role_Id":   this.role_Id
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
   
        
    EditarRol() {
   
   
      var params = {
        "role_Id": this.role_Id       ,
        "role_Descripcion": this.Rol.role_Descripcion?.trim(),      
        "role_UserCreacion": 1,
        "role_UserModificacion": 1
      }
      
          if (this.Rol.role_Descripcion != undefined && this.Rol.role_Descripcion != "") {
            this.rolesPorPantallaService.EditarRoles(params).subscribe(
              Response => {
                  this.datos = Response;
                 console.log(this.datos)
                 
                  if (this.datos.code == 409) {
                      
                      this.messageService.add({ severity: 'info', summary: 'Atencion', detail: "El rol ya existe.", life: 3000 });
                      
                  } else if (this.datos.code == 200) {
                      
                      this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: "Nombre del rol editado con éxito.", life: 3000 });
                     
                     
                    
                                  
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
      
       
    EliminarPantallas(Pantallas: RolesPorPantallaViewModel) {
   
      var params = {
        "role_Id":   this.role_Id,
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
