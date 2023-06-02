import { Component, ViewChild, ElementRef, Renderer2 } from '@angular/core';
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
import { format, parse } from 'date-fns';


import { Router, ActivatedRoute, Params } from '@angular/router';
import { AnyARecord } from 'dns';
import { error, timeEnd } from 'console';
import { timeout } from 'rxjs';


@Component({
  selector: 'app-MantenimientoPorAnimal-edit',
  templateUrl: './ManteniminetoPorAnimal-edit.component.html',
  styleUrls: ['./ManteniminetoPorAnimal-edit.component.scss'],
  providers: [MessageService, ManteniminetoXAnimalService, AreaBotanicaService, TiposDeMantenimientoService]

})

export class MantenimientoPorAnimalEditComponent {
  minDate: Date;

  panelDisabled: boolean = false;

  //Dialogs
  MantenimientoXanimalDialog: boolean = false;
  deleteMantenimientoXanimalDialog: boolean = false;
  //Dialogs

  Sube: boolean = false;

  public page_title!: string;
  submitted: boolean = false;

  DataAnimal: any = [];

  MantenimientoXanimal: ManteniminetoXAnimalViewModel[] = [];
  mantenimientoXanimalp: ManteniminetoXAnimalViewModel = {};

  tipoMantenimiento: TipoDeMatenimientoViewModel[] = [];
  Animal: AnimalViewModel[] = [];

  newParametros: ManteniminetoXAnimalViewModel = {};

  @ViewChild('animalDropdown', { static: false }) animalDropdown: ElementRef;
  panelCollapsed: boolean = false;
  abrirPanel() {
    this.panelCollapsed = false;
    this.togglePanel();
  }

  togglePanel() {

    if (this.animalDropdown && this.animalDropdown.nativeElement) {
      this.animalDropdown.nativeElement.focus();
    }
     this.panelCollapsed = true
  }

  scrollIntoViewIfNeeded() {
    const panelElement = document.getElementById('hasta_Arriba');

    if (panelElement) {
      panelElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
      if (this.panelCollapsed) {
         this.panelCollapsed = true
      } 
    }
  }

  public formValid = false;
  MantenimientoPorAnimalForm: any;

  datos: any = {};

  //Paginacion de el datatable
  selectedMantenimiento: MantenimintoViewModel[] = [];
  rowsPerPageOptions = [5, 10, 20];
  //Paginacion de el datatable

  fechaSola!: Date;

  ocultarBoton: any = document.getElementById('p-panel-0-label');


  cols: any[] = [];

  statuses: any[] = [];
  //validar espacio
  espacio: boolean = false;

  filtrar: [] = [];

  count: number = 0;

  constructor(private ManteniminetoXAnimalService: ManteniminetoXAnimalService,
    private renderer: Renderer2,
    private messageService: MessageService,
    private TiposDeMantenimientoService: TiposDeMantenimientoService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
    this.page_title = "Editar Mantenimiento A Animal";
    this.minDate = new Date();
    this.animalDropdown = new ElementRef(null);

  }



  ngOnInit() {


    this.getMantenimientoPorAnimal();

    this.TiposDeMantenimientoService.getTiposDeMantenimientos().subscribe(
      response => {
        // console.log(response)

        this.tipoMantenimiento = response.map((item: { tima_Descripcion: any; tima_Id: any; }) => ({ label: item.tima_Descripcion, value: item.tima_Id }));
      },
      error => {
        // Manejo del error
      }
    );

    this.ManteniminetoXAnimalService.getAnimal().subscribe(
      response => {
        // console.log(response)

        this.Animal = response.map((item: { anim_Nombre: any; anim_Id: any; anim_Codigo:any }) => ({ label: `${item.anim_Nombre}  Codigo:${item.anim_Codigo}`, value: item.anim_Id }));
      },
      error => {
        // Manejo del error
      }

    )




    //Modelo de los datos de la tabla
    this.cols = [
      { field: 'maan_Id', header: 'mant_Id' },
      { field: 'anim_Nombre', header: 'anim_Nombre' },
      { field: 'maan_Fecha', header: 'maan_Fecha' },
      { field: 'tima_Descripcion', header: 'tima_Descripcion' }

    ];
    //Modelo de los datos de la tabla

  }

  toco(){


    if(!this.panelCollapsed){
      console.log("True")
      this.panelCollapsed = true
    }else if(this.panelCollapsed){
      console.log("False")

      this.panelCollapsed = false

    }
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

  //Enviamos y editamos datos
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
          this.getMantenimientoPorAnimal();

        } else {
          this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
        }
      },
      error => {
        console.log("manzana")
      }
    );

  }

   

  getInputsValues(id: any) {

    this.datos = this.DataAnimal;
    const mantenimiento = this.datos.find((item: any) => item.maan_Id === id);

    try {


      var cambio = mantenimiento.maan_Fecha;

      if (mantenimiento) {


        if (mantenimiento.maan_Fecha) {

          var fechaFormateada = format(parse(cambio, 'dd-MM-yyyy', new Date()), 'yyyy-MM-dd\'T\'HH:mm:ss.SSS');

          fechaFormateada = new Date(fechaFormateada!).toDateString();


          this.fechaSola = new Date(fechaFormateada);
          this.newParametros.maan_Id = mantenimiento.maan_Id;
          this.newParametros.anim_Id = mantenimiento.anim_Id;
          this.newParametros.tima_Id = mantenimiento.tima_Id;
          this.scrollIntoViewIfNeeded();
          this.abrirPanel();




        } else {
          console.log('El valor de maan_Fecha es nulo o indefinido');
        }
      } else {
        console.log('No se encontró el ID de mantenimiento');
      }

    } catch (error) {

    }


  }



  //Enviamos y editamos datos
  saveMantenimientoPorAnimal() {

    this.submitted = true;


    var params = {
      "maan_Id": this.newParametros.maan_Id,
      "anim_Id": this.newParametros.anim_Id,
      "maan_Fecha": this.fechaSola,
      "tima_Id": this.newParametros.tima_Id,
      "maan_UserCreacion": 1,
      "maan_UserModificacion": 1

    }

    console.log(params);

    if (params.anim_Id != 0 && params.anim_Id != undefined && params.tima_Id != 0 && params.tima_Id != undefined && this.fechaSola.toDateString() != "" && params.maan_Fecha != undefined) {

      this.ManteniminetoXAnimalService.EditManteniminetoXAnimal(params).subscribe(Response => {
        this.datos = Response;
        if (this.datos.code == 409) {

          this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

        } else if (this.datos.code = 200) {
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 1500 });
          this.getMantenimientoPorAnimal();
        }

      }, error => {
        console.log(error)
      })

    }

  }

  //Enviamos y editamos datos

  getMantenimientoPorAnimal() {
    this._route.params.subscribe(Params => {
      let maan_Id = Params['id'];

      var params = {
        "anim_Id": maan_Id,

      }
      this.ManteniminetoXAnimalService.GetAnimalesXMantenimineto(params).subscribe(Response => {
        this.DataAnimal = Response;
      }, error => {
        console.log(error);
      })
    });
  }


  //Buscador
  onGlobalFilter(table: Table, event: Event) {
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }
  //Buscador
}
function ngDoCheck() {
  throw new Error('Function not implemented.');
}

