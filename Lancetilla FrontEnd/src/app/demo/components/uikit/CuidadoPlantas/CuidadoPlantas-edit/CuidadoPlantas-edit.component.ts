import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
//XAnimal
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
//Mantenimiento
import { TiposDeMantenimientoService } from 'src/app/demo/service/TipoDeMantenimiento.service';
import { TipoDeMatenimientoViewModel } from 'src/app/demo/Models/TipoDeManteniminetoViewModel';
//Animal
import { AnimalViewModel } from 'src/app/demo/Models/AnimalViewModel';
// import { CuidadoPlantasViewModel } from 'src/app/demo/Models/CuidadoPlantasViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';

//Cuidado Plantas
import { CuidadoPlantasService } from 'src/app/demo/service/CuidadoPlantas.service';
import { CuidadoPlantasViewModel } from 'src/app/demo/Models/CuidadoPlantasViewModel';
//Areas
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';

//Plantas
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { PlantasViewModel } from 'src/app/demo/Models/PlantasViewModel';

//Tipo Cuidado
import { TiposCuidadosService } from 'src/app/demo/service/TiposCuidadios.Service';
import { TiposCuidadosViewModel } from 'src/app/demo/Models/TiposCuidadosViewModel';

import { LocalStorageService } from '../../../../../local-storage.service';
import { format, parse } from 'date-fns';


 import { AnyARecord } from 'dns';
import { error, timeEnd } from 'console';
import { timeout } from 'rxjs';


@Component({
  selector: 'app-MantenimientoPorAnimal-edit',
  templateUrl: './CuidadoPlantas-edit.component.html',
  styleUrls: ['./ManteniminetoPorAnimal-edit.component.scss'],
  providers: [MessageService, CuidadoPlantasService, ManteniminetoXAnimalService, TiposCuidadosService, AreaBotanicaService, TiposDeMantenimientoService, PlantasService]

})

export class CuidadoPlantasEditComponent {
  minDate: Date;

  desabilitado: boolean = true;

  AreaBotanica: string = "";
  PlantaASelecionad: string = "";
  CodigoPlanta: string = "";
  CuidadoSeleccionado: string = "";


  EsAdmin: any;
  Permiso: any;

  //Dialogs
  CuidadoPlantasDialog: boolean = false;

  deleteCuidadoPlantasDialog: boolean = false;
  //Dialogs

  public page_title!: string;
  submitted: boolean = false;

  DataAnimal: any = [];

  CuidadoPlantas: CuidadoPlantasViewModel[] = [];
  CuidadoPlanta: CuidadoPlantasViewModel = {};
  newParametros: CuidadoPlantasViewModel = {};

  tipoMantenimiento: TipoDeMatenimientoViewModel[] = [];
  Animal: AnimalViewModel[] = [];


  public formValid = false;
  CuidadoPlantasForm: any;

  datos: any = {};

  //Paginacion de el datatable
  selectedMantenimiento: CuidadoPlantasViewModel[] = [];
  rowsPerPageOptions = [5, 10, 20];
  //Paginacion de el datatable

  demoTable: CuidadoPlantasViewModel[] = [];

  cols: any[] = [];

  statuses: any[] = [];
  //validar espacio
  espacio: boolean = false;

  //Cuidado Plantas

  //TipoCuidado
  tipoCuidado: TiposCuidadosViewModel[] = []
  tipoCuidadoFind: TiposCuidadosViewModel[] = []

  //Plantas
  plantas: PlantasViewModel[] = []

  //Area Botanica
  Area: AreaBotanicaViewModel[] = []
  AreaFind: AreaBotanicaViewModel[] = []


  fechaSola!: Date;

  ocultarBoton: any = document.getElementById('p-panel-0-label');

  cambioValor!: number;
  noAbre!: number;

  acordeonAbierto: boolean = false;



  filtrar: [] = [];

  count: number = 0;

  isExpanded: boolean = false;

  mostrar: boolean = true

  expandDesplegable(): void {
    this.isExpanded = true;
  }

  yanoMas!: number;

  //scroll
  @ViewChild('animalDropdown', { static: false }) animalDropdown: ElementRef;
  panelCollapsed: boolean = false;

  abrirPanel() {
    console.log("abrir togle")
    this.panelCollapsed = false;
    this.togglePanel();
  }

  togglePanel() {

    if (this.animalDropdown && this.animalDropdown.nativeElement) {
      this.animalDropdown.nativeElement.focus();
    }
  }

  scrollIntoViewIfNeeded() {
    const panelElement = document.getElementById('hasta_Arriba');
    console.log("LLEGO")
    if (panelElement) {
      panelElement.scrollIntoView({ behavior: 'smooth', block: 'start' });

    }
  }

  //scroll




  constructor(private _router: Router,
    private localStorage: LocalStorageService,
    private ManteniminetoXAnimalService: ManteniminetoXAnimalService,
    private messageService: MessageService,
    private TiposDeMantenimientoService: TiposDeMantenimientoService,
    private AreaBotanicaService: AreaBotanicaService,
    private TiposCuidadosService: TiposCuidadosService,
    private CuidadoPlantasService: CuidadoPlantasService,
    private PlantasService: PlantasService,
    private _route: ActivatedRoute,


    private _rauter: Router) {
    this.page_title = "Editar cuidado de planta";
    this.minDate = new Date();
    this.EsAdmin = this.localStorage.getItem('EsAdmin')
    this.Permiso = this.localStorage.getItem('CuidadoDePlantas')
    this.animalDropdown = new ElementRef(null);
 

  }


  ngOnInit() {


    if (this.EsAdmin != null || this.EsAdmin != undefined) {

      if (this.EsAdmin == false) {

        if (this.Permiso == false) {
          this._router.navigate(['login']);
        }
      }

    } else {

      this._router.navigate(['login']);
    }


    //this.getPlanta();

    // this.GetMantenimientoInsert(1);
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

        this.Animal = response.map((item: { anim_Nombre: any; tipl_Id: any; anim_Codigo: any }) => ({ label: `${item.anim_Nombre}  Codigo:${item.anim_Codigo}`, value: item.tipl_Id }));
      },
      error => {
        // Manejo del error
      }
    );


    //Area Botanica
    this.AreaBotanicaService.getAreaBotanica().subscribe(
      response => {
        this.Area = response.map((item: { arbo_Descripcion: any; arbo_Id: any; }) => ({ label: item.arbo_Descripcion, value: item.arbo_Id }));
        this.AreaFind = response;
        console.log(this.AreaFind)
      },
      Error => {
        console.log(Error)
      }
    )


    //Tipo Cuidado
    this.TiposCuidadosService.getTiposCuidados().subscribe(
      response => {
        this.tipoCuidado = response.map((item: { ticu_Descripcion: any; ticu_Id: any }) => ({ label: item.ticu_Descripcion, value: item.ticu_Id }));
        this.tipoCuidadoFind = response;
      },
      error => {
        console.log(error)
      }
    )


    this.getMantenimientoPorAnimal();

    //Modelo de los datos de la tabla
    this.cols = [
      { field: 'cupl_Id', header: 'mant_Id' },
      { field: 'anim_Nombre', header: 'anim_Nombre' },
      { field: 'cupl_Fecha', header: 'cupl_Fecha' },
      { field: 'tima_Descripcion', header: 'tima_Descripcion' }

    ];
    //Modelo de los datos de la tabla

  }




  checkFormValidity() {
    this.formValid = this.CuidadoPlantasForm.valid && this.CuidadoPlanta.tipl_Id || this.CuidadoPlanta.cupl_Id;
  }
  //Toma el id del item
  deleteMantenimiento(Mantenimiento: CuidadoPlantasViewModel) {
    this.deleteCuidadoPlantasDialog = true;
    this.CuidadoPlanta = { ...Mantenimiento };
  }
  //Toma el id del item

  //Enviamos y editamos datos
  //Confirma el eliminar
  confirmDelete() {
    this.deleteCuidadoPlantasDialog = false;
    var params = {
      "cupl_Id": this.CuidadoPlanta.cupl_Id,
    }

    this.ManteniminetoXAnimalService.DeleteManteniminetoXAnimal(params).subscribe(
      Response => {
        this.datos = Response;
        console.log(this.datos)
        if (this.datos.code == 409) {

          this.messageService.add({ severity: 'info', summary: 'Atencion', detail: this.datos.message, life: 3000 });

        } else if (this.datos.code == 200) {
          this.DataAnimal = this.DataAnimal.filter((val: any) => val.cupl_Id !== this.CuidadoPlanta.cupl_Id);
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 3000 });
          this.CuidadoPlanta = {};


        } else {
          this.messageService.add({ severity: 'warn', summary: 'Error', detail: this.datos.message, life: 3000 });
        }
      },
      error => {
        console.log("manzana")
      }
    );

  }

  message() {

    if (this.yanoMas != 1) {
      this.messageService.add({ severity: 'info', summary: 'Informacion', detail: "Elige a un Animal al que quieras editar el manteniminetio", life: 2000 });
    }

  }

  // tomar valores
  FiltrarPlantas(arbo_Id: any) {

    var params = {
      "arbo_Id": arbo_Id,

    }

    this.CuidadoPlantasService.postBuscarPlantas(params).subscribe(
      response => {

        this.plantas = response.map((item: { tipl_NombreComun: any; plan_Id: any; plan_Codigo: any }) => ({ label: `${item.tipl_NombreComun}       - Codigo:${item.plan_Codigo}`, value: item.plan_Id }));
        if (this.plantas.length !== 0) {

          this.desabilitado = false;
        } else {
          this.messageService.add({ severity: 'info', summary: 'Error', detail: "El area botanica que as seleccionado aun no tiene plantas", life: 3000 });
          this.desabilitado = true;

        }

      },
      error => {
        console.log("Error")
      }
    )


  }


  onAreaBotanicaChange(event: any) {

    const selectedAnimal: any = this.AreaFind.find((animal: any) => animal.arbo_Id === this.CuidadoPlanta.arbo_Id);
    if (selectedAnimal) {
      // Aquí puedes acceder a la descripción del animal seleccionado
      console.log('area seleccionado:', selectedAnimal.arbo_Descripcion);
      this.AreaBotanica = selectedAnimal.arbo_Descripcion;
    }
  }

  onAnimalChange(event: any) {
    console.log(this.CuidadoPlantas)
    const selectedAnimal: any = this.CuidadoPlantas.find((animal: any) => animal.plan_Id === this.CuidadoPlanta.plan_Id);
    console.log(selectedAnimal)
    console.log(this.CuidadoPlanta.plan_Id)

    if (selectedAnimal) {
      // Aquí puedes acceder a la descripción del animal seleccionado
      console.log('planta seleccionado:', selectedAnimal.tipl_NombreComun);
      console.log('area seleccionado:', selectedAnimal.plan_Codigo);
      this.CodigoPlanta = selectedAnimal.plan_Codigo;
      this.PlantaASelecionad = selectedAnimal.tipl_NombreComun;
    }
  }



  onTipoMantenimientoChange(event: any) {
    const selectedTipoMantenimiento: any = this.tipoCuidadoFind.find((tipo: any) => tipo.ticu_Id === this.CuidadoPlanta.ticu_Id);
    console.log(selectedTipoMantenimiento);
    if (selectedTipoMantenimiento) {
      // Aquí puedes acceder a la descripción del tipo de mantenimiento seleccionado
      console.log('Tipo de Mantenimiento seleccionado:', selectedTipoMantenimiento.ticu_Descripcion);
    }
    this.CuidadoSeleccionado = selectedTipoMantenimiento.ticu_Descripcion;
  }

  // tomar valores

  formatearFecha(fecha: any) {
    const fechaOriginal = new Date(fecha);
    const fechaFormateada = fechaOriginal.toISOString();
  
    console.log("Se formateó la fecha:");
    console.log(fechaFormateada);
    this.fechaSola = new Date(fechaFormateada);
  }
  

  getInputsValues(id: any) {

    this.datos = this.DataAnimal;
    const mantenimiento = this.datos.find((item: any) => item.cupl_Id === id);

    try {


      var cambio = mantenimiento.cupl_Fecha;

      if (mantenimiento) {

        if (mantenimiento.cupl_Fecha != "") {
          
          this.newParametros.arbo_Id = mantenimiento.arbo_Id;
          if(mantenimiento.plan_Id != 0){
            this.FiltrarPlantas(mantenimiento.arbo_Id);
          }
          this.newParametros.plan_Id = mantenimiento.plan_Id;
          this.newParametros.ticu_Id = mantenimiento.ticu_Id;
          this.scrollIntoViewIfNeeded();
          this.abrirPanel();
          this.mostrar = false;
          
          console.log(cambio);
          this.formatearFecha(cambio);
 
          


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
  saveCuidadoPlantas() {



    this.submitted = true;
    var params = {
      "cupl_Id": 2,
      "plan_Id": this.CuidadoPlanta.plan_Id,
      "plan_Codigo": "",
      "tipl_NombreComun": "",
      "tipl_Id": 0,
      "arbo_Id": 0,
      "AreaBotanica": "",
      "ticu_Id": this.CuidadoPlanta.ticu_Id,
      "ticu_Descripcion": "",
      "cupl_Fecha": this.CuidadoPlanta.cupl_Fecha,
      "cupl_UserCreacion": 1
    }

    console.log(params)

    if (params.ticu_Id != 0 && params.ticu_Id != undefined && params.plan_Id != 0 && params.plan_Id != undefined && params.cupl_Fecha != "" && params.cupl_Fecha != undefined) {


      this.CuidadoPlantasService.postCuidadoPlantas(params).subscribe(Response => {
        this.datos = Response;
        if (this.datos.code == 409) {

          this.messageService.add({ severity: 'info', summary: 'Error', detail: "Error con el servidor", life: 3000 });

        } else if (this.datos.code = 200) {
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'El cuidado de la planta ha sido creado con éxito.', life: 1500 });

          var fechaFormateada = this.CuidadoPlanta.cupl_Fecha;
          var fechaFormateadaDDMMYYYY: any;
          if (fechaFormateada) {
            var fecha = new Date(fechaFormateada);
            var dia = fecha.getDate();
            var mes = fecha.getMonth() + 1;
            var anio = fecha.getFullYear();

            fechaFormateadaDDMMYYYY = dia.toString().padStart(2, '0') + '-' + mes.toString().padStart(2, '0') + '-' + anio.toString();

            console.log(fechaFormateadaDDMMYYYY);
          } else {
            console.log('La fecha es indefinida');
          }

          // tomar el valor de los labels de los ddls
          params.cupl_Id = this.datos.message;
          params.AreaBotanica = this.AreaBotanica;
          params.tipl_NombreComun = this.PlantaASelecionad;
          params.plan_Codigo = this.CodigoPlanta;
          params.cupl_Fecha = fechaFormateadaDDMMYYYY;
          params.ticu_Descripcion = this.CuidadoSeleccionado;



          this.DataAnimal.push(params)
          console.log(this.DataAnimal)
          console.log(params)

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
        "arbo_Id": maan_Id,

      }
      this.CuidadoPlantasService.postBuscarPlantas2(params).subscribe(Response => {
        this.DataAnimal = Response;
        console.log(Response)
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

