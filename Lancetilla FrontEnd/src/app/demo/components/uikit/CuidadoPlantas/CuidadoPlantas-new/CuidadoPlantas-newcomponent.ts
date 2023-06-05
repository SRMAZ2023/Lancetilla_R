import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
//XAnimal
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
 //Mantenimiento
import { TiposDeMantenimientoService } from 'src/app/demo/service/TipoDeMantenimiento.service';
import { TipoDeMatenimientoViewModel } from 'src/app/demo/Models/TipoDeManteniminetoViewModel';
//Animal
import { AnimalViewModel } from 'src/app/demo/Models/AnimalViewModel';
import { MantenimintoViewModel } from 'src/app/demo/Models/MantenimintoViewModel';
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


@Component({
  templateUrl: './CuidadoPlantas-New.component.html',
  providers: [MessageService, CuidadoPlantasService, ManteniminetoXAnimalService, TiposCuidadosService, AreaBotanicaService, TiposDeMantenimientoService, PlantasService]
})

export class CuidadoPlantasNewComponent implements OnInit {

  minDate: Date;


  animNombre: string = ""; // Variable para almacenar el valor del label del ddl Animal
  timaDescripcion: string = ""; // Variable para almacenar el valor del label del ddl Tipo de Mantenimiento


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

  tipoMantenimiento: TipoDeMatenimientoViewModel[] = [];
  Animal: AnimalViewModel[] = [];


  public formValid = false;
  CuidadoPlantasForm: any;

  datos: any = {};

  //Paginacion de el datatable
  selectedMantenimiento: MantenimintoViewModel[] = [];
  rowsPerPageOptions = [5, 10, 20];
  //Paginacion de el datatable

  demoTable: MantenimintoViewModel[] = [];

  cols: any[] = [];

  statuses: any[] = [];
  //validar espacio
  espacio: boolean = false;

  //Cuidado Plantas

  //TipoCuidado
  tipoCuidado: TiposCuidadosViewModel[] = []

  //Plantas
  plantas: PlantasViewModel[] = []

  //Area Botanica
  Area: AreaBotanicaViewModel[] = []




  constructor( private _router: Router ,
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
    this.page_title = "Editar Mantenimiento A Animal";
    this.minDate = new Date();
    this.EsAdmin = this.localStorage.getItem('EsAdmin')
    this.Permiso = this.localStorage.getItem('CuidadoDePlantas')
         

  }

  ngOnInit() {

        
    if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

      if (this.EsAdmin == false) {

          if (this.Permiso == false) {
              this._router.navigate(['login']);
          }              
      }

  }else{

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
        console.log(response)

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
      },
      Error => {
        console.log(Error)
      }
    )


    //Tipo Cuidado
    this.TiposCuidadosService.getTiposCuidados().subscribe(
      response => {
        this.tipoCuidado = response.map((item: { ticu_Descripcion: any; ticu_Id: any }) => ({ label: item.ticu_Descripcion, value: item.ticu_Id }));

      },
      error => {
        console.log(error)
      }
    )

    //Modelo de los datos de la tabla
    this.cols = [
      { field: 'cupl_Id', header: 'mant_Id' },
      { field: 'anim_Nombre', header: 'anim_Nombre' },
      { field: 'cupl_Fecha', header: 'cupl_Fecha' },
      { field: 'tima_Descripcion', header: 'tima_Descripcion' }

    ];
    //Modelo de los datos de la tabla

  }


  GetMantenimientoInsert(usuario_Id: any) {

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
    this.formValid = this.CuidadoPlantasForm.valid && this.CuidadoPlanta.tipl_Id || this.CuidadoPlanta.cupl_Id;
  }

  //Toma el id del item
  deleteMantenimiento(Mantenimiento: CuidadoPlantasViewModel) {
    this.deleteCuidadoPlantasDialog = true;
    this.CuidadoPlanta = { ...Mantenimiento };
  }
  //Toma el id del item

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

  FiltrarPlantas(arbo_Id: any) {

    var params = {
      "arbo_Id": arbo_Id,

    }

    this.CuidadoPlantasService.postBuscarPlantas(params).subscribe(
      response => {

        console.log(response)
        this.plantas = response.map((item: { tipl_NombreComun: any; plan_Id: any; plan_Codigo: any }) => ({ label: `${item.tipl_NombreComun}       - Codigo:${item.plan_Codigo}`, value: item.plan_Id }));

      },
      error => {
        console.log("Error")
      }
    )

    
  }

  onAnimalChange(event: any) {

    console.log(this.Animal)
    const selectedAnimal: any = this.Animal.find((animal: any) => animal.value === this.CuidadoPlanta.tipl_Id);
    if (selectedAnimal) {
      // Aquí puedes acceder a la descripción del animal seleccionado
      console.log('Animal seleccionado:', selectedAnimal.label);
      this.animNombre = selectedAnimal.label;
    }
  }



  onTipoMantenimientoChange(event: any) {
    const selectedTipoMantenimiento: any = this.tipoMantenimiento.find((tipo: any) => tipo.value === this.CuidadoPlanta.tipl_Id);
    if (selectedTipoMantenimiento) {
      // Aquí puedes acceder a la descripción del tipo de mantenimiento seleccionado
      console.log('Tipo de Mantenimiento seleccionado:', selectedTipoMantenimiento.label);
    }
    this.timaDescripcion = selectedTipoMantenimiento.label;
  }


  //Enviamos y editamos datos
  saveCuidadoPlantas() {
    
    this.submitted = true;
    var params = {
      "cupl_Id": 0,
      "tipl_Id": this.CuidadoPlanta.tipl_Id,
      "anim_Nombre": "",
      "cupl_Fecha": this.CuidadoPlanta.cupl_Fecha,
      "plan_Id": this.CuidadoPlanta.plan_Id,
      "tima_Descripcion": "",
      "maan_UserCreacion": 1
    }

    console.log(params)

    if (params.tipl_Id != 0 && params.tipl_Id != undefined && params.plan_Id != 0 && params.plan_Id != undefined && params.cupl_Fecha != "" && params.cupl_Fecha != undefined) {


      this.ManteniminetoXAnimalService.postManteniminetoXAnimal(params).subscribe(Response => {
        this.datos = Response;
        if (this.datos.code == 409) {

          this.messageService.add({ severity: 'info', summary: 'Error', detail: "Error con el servidor", life: 3000 });

        } else if (this.datos.code = 200) {
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: 'El mantenimiento por animal ha sido creado con éxito.', life: 1500 });

          var fechaFormateada = this.CuidadoPlanta.cupl_Id;
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
          params.anim_Nombre = this.animNombre;
          params.cupl_Fecha = fechaFormateadaDDMMYYYY;
          params.tima_Descripcion = this.timaDescripcion;
          this.DataAnimal.push(params)
          console.log(params)

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