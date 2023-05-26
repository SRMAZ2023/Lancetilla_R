import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { Table } from 'primeng/table';
//XAnimal
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
import { ManteniminetoXAnimalViewModel } from 'src/app/demo/Models/ManteniminetoXAnimalViewModel';
//Mantenimiento
import { TiposDeMantenimientoService } from 'src/app/demo/service/TipoDeMantenimiento.service';
import { TipoDeMatenimientoViewModel } from 'src/app/demo/Models/TipoDeManteniminetoViewModel';
//Animal
import { AnimalViewModel } from 'src/app/demo/Models/AnimalViewModel';
import { MantenimintoViewModel } from 'src/app/demo/Models/MantenimintoViewModel';


import { Router, ActivatedRoute, Params } from '@angular/router';
import { AnyARecord } from 'dns';
import { error } from 'console';


@Component({
  templateUrl: './MantenimientoPorAnimal-New.component.html',
  providers: [MessageService, ManteniminetoXAnimalService, AreaBotanicaService, TiposDeMantenimientoService]
})

export class MantenimientoPorAnimalNewComponent implements OnInit {

  minDate: Date;


  //Dialogs
  MantenimientoXanimalDialog: boolean = false;

  deleteMantenimientoXanimalDialog: boolean = false;

  //Dialogs

  public page_title!: string;
  submitted: boolean = false;

  DataAnimal:any = [];

  MantenimientoXanimal: ManteniminetoXAnimalViewModel[] = [];
  mantenimientoXanimalp: ManteniminetoXAnimalViewModel = {};

  tipoMantenimiento: TipoDeMatenimientoViewModel[] = [];
  Animal: AnimalViewModel[] = [];


  public formValid = false;
  MantenimientoPorAnimalForm: any;

  datos: any = {};

  //Paginacion de el datatable
  selectedMantenimiento: MantenimintoViewModel[] = [];
  rowsPerPageOptions = [5, 10, 20];
  //Paginacion de el datatable


  cols: any[] = [];

  statuses: any[] = [];
  //validar espacio
  espacio: boolean = false;

  

  constructor(private ManteniminetoXAnimalService: ManteniminetoXAnimalService,
    private messageService: MessageService,
    private TiposDeMantenimientoService: TiposDeMantenimientoService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
     this.page_title = "Editar Mantenimiento A Animal";
     this.minDate = new Date();


  }

  ngOnInit() {

    //this.getPlanta();

    this.GetMantenimientoInsert(1);
    this.TiposDeMantenimientoService.getTiposDeMantenimientos().subscribe(
      response => {
        console.log(response)

        this.tipoMantenimiento = response.map((item: { tima_Descripcion: any; tima_Id: any; }) => ({ label: item.tima_Descripcion, value: item.tima_Id }));
      },
      error => {
        // Manejo del error
      }
    );

    this.ManteniminetoXAnimalService.getAnimal().subscribe(
      response => {
        console.log(response)

        this.Animal = response.map((item: { anim_Nombre: any; anim_Id: any; }) => ({ label: item.anim_Nombre, value: item.anim_Id }));
      },
      error => {
        // Manejo del error
      }
    );

    //Modelo de los datos de la tabla
        this.cols = [
            { field: 'maan_Id', header: 'mant_Id' },
            { field: 'anim_Nombre', header: 'anim_Nombre' },
            { field: 'maan_Fecha', header: 'maan_Fecha' },
            { field: 'tima_Descripcion', header: 'tima_Descripcion' }

        ];
        //Modelo de los datos de la tabla

  }


  GetMantenimientoInsert(usuario_Id:any){

   var params = {
    "maan_UserCreacion": usuario_Id

   }

    this.ManteniminetoXAnimalService.GetMantenimientoInsert(params).subscribe(
      Response => {
 

    this.DataAnimal = Response;
        console.log(Response);
      }, 
      error => {
        console.log(error);
      }
    );
  }

  checkFormValidity() {
    this.formValid = this.MantenimientoPorAnimalForm.valid && this.mantenimientoXanimalp.anim_Id || this.mantenimientoXanimalp.maan_Id;
  }

  //Toma el id del item
  deleteMantenimiento(Mantenimiento: MantenimintoViewModel) {
    this.deleteMantenimientoXanimalDialog = true;
    this.mantenimientoXanimalp = { ...Mantenimiento };
}
//Toma el id del item

//Confirma el eliminar
confirmDelete() {
    this.deleteMantenimientoXanimalDialog = false;
    var params = {
        "maan_Id": this.mantenimientoXanimalp.maan_Id,
    }

    this.ManteniminetoXAnimalService.DeleteManteniminetoXAnimal(params).subscribe(
        Response => {
            this.datos = Response;
            console.log(this.datos)
            if (this.datos.code == 409) {

                this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

            } else if (this.datos.code == 200) {
                this.MantenimientoXanimal = this.MantenimientoXanimal.filter(val => val.maan_Id !== this.mantenimientoXanimalp.maan_Id);
                this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
                this.mantenimientoXanimalp = {};
 
            } else {
                this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
            }
        },
        error => {
            console.log("manzana")
        }
    );

}


  //Enviamos y editamos datos
  saveMantenimientoPorAnimal() {

    this.submitted = true;


    var params = {
      "anim_Id": this.mantenimientoXanimalp.anim_Id,
      "maan_Fecha": this.mantenimientoXanimalp.maan_Fecha,
      "tima_Id": this.mantenimientoXanimalp.tima_Id,
      "maan_UserCreacion": 1
    }

    if(params.anim_Id != 0 && params.anim_Id != undefined &&  params.tima_Id != 0 &&  params.tima_Id != undefined && params.maan_Fecha != "" && params.maan_Fecha != undefined ){
      

      this.ManteniminetoXAnimalService.postManteniminetoXAnimal(params).subscribe(Response => {
        this.datos = Response;
        if (this.datos.code == 409) {
  
          this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });
  
        } else if (this.datos.code = 200) {
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 1500 });
          this.GetMantenimientoInsert(1);
  
        }
  
  
  
      }, error => {
        console.log(error)
      })
      

    } 



  }

  //Enviamos y editamos datos

    //Buscador
    onGlobalFilter(table: Table, event: Event) {
      table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }
  //Buscador

}
