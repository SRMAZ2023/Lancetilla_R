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

    cols: any[] = [];
    products: Product[] = [];

    selectedRol: RolesViewModel[] = [];
    statuses: any[] = [];
    //validar espacio
    espacio: boolean = false;
    expandedRows: RolesPorPantallaViewModel[] = [];



    constructor(private productService: ProductService, private rolesPorPantallaService: RolesPorPantallaService, private messageService: MessageService) {
    }

    ngOnInit() {
 
        this.productService.getProductsWithOrdersSmall().then(data => this.products = data);
        //Modelo de los datos de la tabla
      
        this.rolesPorPantallaService.Roles().subscribe(
            Response => {
               
                this.Roles = Response;

                   
            },
            error => (
                console.log(error)
            )
        );

       
      
        this.cols = [
            { field: 'role_Id', header: 'role_Id' },
            { field: 'role_Descripcion', header: 'role_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }
    

    Pantallas(Roles: RolesPorPantallaViewModel) {
        this.Rol = { ...Roles };
      
        var params = {
          "role_Id": this.Rol.role_Id         
        };
      
        this.rolesPorPantallaService.PantallasPorRol(params).subscribe(
          Response => {
            this.datos = Response;
            console.log(this.datos);
      
            
             
            // Verificar si la fila ya está expandida
            const index = this.expandedRows.indexOf(this.Rol);
            if (index > -1) {
              // La fila está expandida, la contraemos para cerrar la pestaña
              this.expandedRows.splice(index, 1);
            } else {
              // La fila está contraída, la expandimos para abrir la pestaña
              this.expandedRows.push(this.Rol);
            }
          },
          error => {
            console.log("manzana");
          }
        );
      }
      

        //[expandedRowKeys]="expandedRows"

   

   
    //Metodo que desactiva el dialog

    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador



}
