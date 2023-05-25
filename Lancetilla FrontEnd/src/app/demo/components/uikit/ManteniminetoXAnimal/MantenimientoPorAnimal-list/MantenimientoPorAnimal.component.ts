import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { ManteniminetoXAnimalViewModel } from 'src/app/demo/Models/ManteniminetoXAnimalViewModel';
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
import { error } from 'console';
import { DatePipe } from '@angular/common';

interface expandedRows {
    [key: string]: boolean;
}

@Component({
    templateUrl: './MantenimientoPorAnimal.html',
    providers: [MessageService, ManteniminetoXAnimalService, DatePipe]
})
export class MantenimientoPorAnimalComponent implements OnInit {

    //Dialogs
    MantenimientoPorAnimaltDialog: boolean = false;

    deleteMantenimientoPorAnimalDialog: boolean = false;

    deleteProductsDialog: boolean = false;
    //Dialogs

    datos: any = {};


    public Editar: boolean = false;
    MantenimientoPorAnimal: ManteniminetoXAnimalViewModel[] = [];
    mantenimientoXanimal: ManteniminetoXAnimalViewModel = {};

    //Paginacion de el datatable
    selectedMantenimientoPorAnimal: ManteniminetoXAnimalViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    cols: any[] = [];

    statuses: any[] = [];
    formattedDate: string | undefined;
    formattedDate3!: Date;

    expandedRows: expandedRows = {};
    isExpanded: boolean = false;

    Animal: any;



    constructor(private ManteniminetoXAnimalService: ManteniminetoXAnimalService, private datePipe: DatePipe, private messageService: MessageService) {
    }

    ngOnInit() {

        // Obtén la fecha del API
        this.ManteniminetoXAnimalService.getManteniminetoXAnimal().subscribe(
            Response => {
                console.log(Response);
                this.datos = Response;
                this.MantenimientoPorAnimal = Response;

                this.formattedDate = this.datePipe.transform(this.datos.maan_Fecha, 'yyyy-MM-dd')?.toString();


                console.log(this.formattedDate);
                console.log(this.datos);
            },
            error => {
                console.log(error);
            }
        );

        //Modelo de los datos de la tabla
        this.cols = [
            { field: 'maan_Id', header: 'maan_Id' },
            { field: 'anim_Nombre', header: 'anim_Nombre' },
            { field: 'maan_Fecha', header: 'maan_Fecha' },
            { field: 'tima_Descripcion', header: 'tima_Descripcion' }

        ];
        //Modelo de los datos de la tabla

    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.MantenimientoPorAnimaltDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        this.mantenimientoXanimal = {};
        this.submitted = false;
        this.MantenimientoPorAnimaltDialog = true;
    }
    //Metodo que activa el dialog

    //Toma el id del item
    deleteMantenimientoPorAnimal(MantenimientoPorAnimal: ManteniminetoXAnimalViewModel) {
        this.deleteMantenimientoPorAnimalDialog = true;
        this.mantenimientoXanimal = { ...MantenimientoPorAnimal };
    }
    //Toma el id del item



    tomarAnimal(anim_Id: number) {
        if (anim_Id !== undefined) {
          console.log('anim_Id:', anim_Id);
          this.expandedRows = {}; // Reinicia el objeto expandedRows
      
          const elemento = this.MantenimientoPorAnimal.find(item => item.anim_Id === anim_Id);
          
          if (elemento) {
            console.log('Elemento encontrado:', elemento);
            
            var params = {
              anim_Id: anim_Id,
            };
            
            this.ManteniminetoXAnimalService.GetAnimalesXMantenimineto(params).subscribe(
              (response) => {
                console.log('Datos obtenidos:', response);
                this.Animal = response;
                this.expandedRows[elemento.maan_Id as any] = true; // Expande el elemento encontrado
              },
              (error) => {
                console.log('Error al obtener los datos:', error);
              }
            );
          }
        }
      }
      
      
      
      


    //Confirma el eliminar
    confirmDelete() {
        this.deleteMantenimientoPorAnimalDialog = false;
        var maan_Id = this.mantenimientoXanimal.maan_Id;
        var params = {
            "maan_Id": this.mantenimientoXanimal.maan_Id,
            "plan_UserCreacion": 1,
            "plan_UserModificacion": 1
        }
        console.log(params)
        this.ManteniminetoXAnimalService.DeleteManteniminetoXAnimal(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                    this.MantenimientoPorAnimal = this.MantenimientoPorAnimal.filter(val => val.maan_Id !== this.mantenimientoXanimal.maan_Id);


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

    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
