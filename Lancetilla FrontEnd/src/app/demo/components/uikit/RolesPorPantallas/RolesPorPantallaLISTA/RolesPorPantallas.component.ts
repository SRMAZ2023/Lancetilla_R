import { Component, OnInit } from '@angular/core';
import { RolesViewModel, RolesPorPantallaViewModel } from 'src/app/demo/Models/RolesPorPantallaViewModel';


import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { RolesPorPantallaService } from 'src/app/demo/service/RolesPorPantalla';
import { error } from 'console';
import { ProductService } from 'src/app/demo/service/product.service';
//import { Cargoss } from 'src/app/demo/api/CargossViewModel';
import { Product } from 'src/app/demo/api/product';
import { LocalStorageService } from '../../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

interface expandedRows {
  [key: string]: boolean;
}


@Component({
    templateUrl: './RolesPorPantallas.component.html',
    providers: [MessageService, RolesPorPantallaService]
})
export class RolesPorPantallaComponent implements OnInit {

    //Dialogs
    CargostDialog: boolean = false;
    EsAdmin: any;
    Permiso: any;
    deleteCargosDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};
  

    public Editar: boolean = false;
    Roles: RolesViewModel[] = [];
    Pantallass: RolesPorPantallaViewModel[] = [];

    Rol: RolesViewModel = {};


    //Paginacion de el datatable
   
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;
    isExpanded: boolean = false;
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
  



    products: Product[] = [];

    expandedRow: any = null;


    selectedRol: RolesViewModel[] = [];
    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;
    expandedRows: RolesPorPantallaViewModel[] = [];
   
    
    constructor( private _router: Router ,
      private localStorage: LocalStorageService,private productService: ProductService, private rolesPorPantallaService: RolesPorPantallaService, private messageService: MessageService) {
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('Roles') }

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

 
        this.productService.getProductsWithOrdersSmall().then(data => this.products = data);
        //Modelo de los datos de la tabla
      
       
       this.CargarRoles()
      
        this.cols = [
            { field: 'role_Id', header: 'role_Id' },
            { field: 'role_Descripcion', header: 'role_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }


    CargarRoles() {
      this.rolesPorPantallaService.Roles().subscribe(
        Response => {
           
            this.Roles = Response;

               
        },
        error => (
            console.log(error)
        )
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
   
   
    Pantallas(Roles: RolesViewModel) {
      this.Rol = { ...Roles };
    
      var params = {
        "role_Id": this.Rol.role_Id
      };
    
      console.log(params);
      this.rolesPorPantallaService.PantallasPorRol(params).subscribe(
        Response => {
          this.datos = Response;
          console.log(this.datos);
    
          // Verificar si la fila seleccionada ya está expandida
          const index = this.expandedRows.findIndex(row => row.role_Id === this.Rol.role_Id);
          if (index > -1) {
            // La fila está expandida, la contraemos para ocultarla
            this.expandedRows.splice(index, 1);
            this.expandedRow = null;
          } else {
            // Cerrar todas las filas expandidas
            this.expandedRows = [];
    
            // Expandir la fila seleccionada
            const selectedRow = this.Roles.find(row => row.role_Id === this.Rol.role_Id);
            if (selectedRow) {
              this.expandedRows.push(selectedRow);
              this.expandedRow = selectedRow;
            }
          }
        },
        error => {
          console.log("manzana");
        }
      );
    }

      
    EliminarRol(Roles: RolesViewModel) {
   
      var params = {
        "role_Id": Roles.role_Id,       
        "role_Descripcion": "string",      
        "role_UserCreacion": 1,
        "role_UserModificacion": 1
      }
      
          
      console.log(params)
      this.rolesPorPantallaService.EliminarRoles(params).subscribe(
          Response => {
              this.datos = Response;
           
              if (this.datos.code == 409) {
                  
                  this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });
                  
              } else if (this.datos.code == 200) {
                  
                  this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                 
                  this.CargarRoles()

              } else {
                  this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });
              }
          },
          error => {
              console.log("manzana")
          }
      );

  }
      
    
    
    EliminarPantallas(Roles: RolesViewModel, Pantallas: RolesPorPantallaViewModel) {
   
      var params = {
        "role_Id": Roles.role_Id,
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
                  
                  this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                 
               
                  this.Pantallas(this.Rol);

                  const index = this.expandedRows.findIndex(row => row.role_Id === this.Rol.role_Id);
                  if (index > -1) {
                    // La fila está expandida, la contraemos para ocultarla
                    this.expandedRows.splice(index, 1);
                    this.expandedRow = null;
                  } else {
                    // Cerrar todas las filas expandidas
                    this.expandedRows = [];
            
                    // Expandir la fila seleccionada
                    const selectedRow = this.Roles.find(row => row.role_Id === this.Rol.role_Id);
                    if (selectedRow) {
                      this.expandedRows.push(selectedRow);
                      this.expandedRow = selectedRow;
                    }
                  }


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
