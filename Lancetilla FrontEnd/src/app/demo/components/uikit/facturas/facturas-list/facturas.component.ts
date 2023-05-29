import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';
import { FacturaService } from 'src/app/demo/service/facturas.service';

@Component({
    templateUrl: './facturas.component.html',
    providers: [MessageService, FacturaService]
})
export class FacturasComponent implements OnInit {

    //Dialogs
    FacturasDialog: boolean = false;

    deleteFacturasDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos:any = {};

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
  
    public Editar: boolean = false;
    Facturas: FacturasViewModel[] = [];
    Factura: FacturasViewModel = {};

    //Paginacion de el datatable
    selectedFacturas: FacturasViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

  

    statuses: any[] = [];


    constructor(private FacsService: FacturaService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.FacsService.getFacs().subscribe(
            Response => {
                console.log(Response);
                this.Facturas = Response
            },
            error => (
                console.log(error)
            )
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'fact_Id', header: 'fact_Id' },
            { field: 'empleado', header: 'empleado' },
            { field: 'visitante', header: 'visitante' },
            { field: 'meto_Descripcion', header: 'meto_Descripcion' },


        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.FacturasDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.Factura = {};
        this.submitted = false;
        this.FacturasDialog = true;
    }
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editPlantas(Plantas: FacturasViewModel) {
        this.Editar = true;
        this.Factura = { ...Plantas };
        this.FacturasDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deletePlantas(Plantas: FacturasViewModel) {
        this.deleteFacturasDialog = true;
        this.Factura = { ...Plantas };
    }
    //Toma el id del item

    //Confirma el eliminar
    // confirmDelete() {
    //     this.deleteFacturasDialog = false;
    //     var fact_Id = this.Factura.fact_Id;
    //     var params = {
    //         "fact_Id": this.Factura.fact_Id,
    //         "fact_UserCreacion": 1,
    //         "fact_UserModificacion": 1
    //     }
    //     console.log(params)
    //     this.FacsService.DeletePlantas(params).subscribe(
    //         Response => {
    //             this.datos = Response;
    //             console.log(this.datos)
    //             if (this.datos.code == 409) {
                    
    //                 this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });
                    
    //             } else if (this.datos.code == 200) {
                    
    //                 this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
    //                 this.Plantas = this.Plantas.filter(val => val.plan_Id !== this.Planta.plan_Id);
                 

    //             } else {
    //                 this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
    //             }
    //         },
    //         error => {
    //             console.log("manzana")
    //         }
    //     );

    // }
    // //Confirma el eliminar


    // //Enviamos y editamos datos
    // savePlantas() {
    //     this.submitted = true;

    //     var params = {
    //         "fact_Id": this.Factura.fact_Id,
    //         "espe_UserCreacion": 1,
    //         "espe_UserModificacion": 1
    //     }


    //     console.log(params)

    //     //Validacion de params
    //     if (params.espe_Descripcion !== undefined &&
    //         params.espe_Descripcion.trim() !== '' &&
    //         params.espe_UserCreacion !== undefined &&
    //         params.espe_UserModificacion !== undefined) {
            
    //         //Si insertara o editara
    //         if (!this.Editar) {

    //             this.PlantasService.postPlantas(params).subscribe(
    //                 Response => {
    //                     console.log(Response);
    //                     if (Response) {
    //                         this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Planta', life: 3000 });
    //                         console.log("esta dentrando")
    //                         this.Planta = {};
    //                         this.PlantastDialog = false;

    //                     } else {
    //                         this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
    //                     }
    //                 },
    //                 error => {
    //                     console.log(error);
    //                 }
    //             )

    //         } else {
    //             this.PlantasService.EditPlantas(params).subscribe(
    //                 Response => {
    //                     console.log(Response);
    //                     if (Response) {
    //                         this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'Has ingresado una nueva Planta', life: 3000 });
    //                         console.log("esta dentrando")
    //                         this.Planta = {};
    //                         this.PlantastDialog = false;


    //                     } else {
    //                         this.messageService.add({ severity: 'warm', summary: 'Error', detail: 'Intenta mas tarde', life: 3000 });
    //                     }
    //                 },
    //                 error => {
    //                     console.log(error);
    //                 }
    //             )

    //         }


    //     }
    // }
    // //Enviamos y editamos datos



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
