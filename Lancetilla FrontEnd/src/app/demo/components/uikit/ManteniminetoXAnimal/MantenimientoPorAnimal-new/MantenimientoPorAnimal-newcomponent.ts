import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { error } from 'console';
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


@Component({
  templateUrl: './MantenimientoPorAnimal-New.component.html',
  providers: [MessageService, ManteniminetoXAnimalService, AreaBotanicaService, TiposDeMantenimientoService]
})

export class MantenimientoPorAnimalNewComponent implements OnInit {

  public MantenimientoXanimal!: ManteniminetoXAnimalViewModel;
  public page_title!: string;
  submitted: boolean = false;

  tipoMantenimiento: TipoDeMatenimientoViewModel[] = [];
  Animal: AnimalViewModel[] = [];


  public formValid = false;
  MantenimientoPorAnimalForm: any;

  datos: any = {};


  constructor(private ManteniminetoXAnimalService: ManteniminetoXAnimalService,
    private messageService: MessageService,
    private TiposDeMantenimientoService: TiposDeMantenimientoService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
    this.MantenimientoXanimal = new ManteniminetoXAnimalViewModel(undefined, undefined, "", undefined, undefined, undefined, undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined)
    this.page_title = "Editar Planta"

  }

  ngOnInit() {

    //this.getPlanta();

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




  }

  checkFormValidity() {
    this.formValid = this.MantenimientoPorAnimalForm.valid && this.MantenimientoXanimal.anim_Id || this.MantenimientoXanimal.maan_Id;
  }


  //Enviamos y editamos datos
  saveMantenimientoPorAnimal() {
    // Verificar si todos los campos están llenos
    // if (this.planta.plan_Nombre &&
    //   this.planta.plan_NombreCientifico &&
    //   this.planta.plan_Reino &&
    //   this.planta.arbo_Id &&
    //   this.planta.cuid_Id) {
    // Todos los campos están llenos, realizar acciones adicionales
    // console.log("Todos los campos están llenos");

    // this.ManteniminetoXAnimalService.postManteniminetoXAnimal(this.MantenimientoXanimal).subscribe(Response => {
    //   this.datos = Response;
    //   if (this.datos.code == 409) {

    //     this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

    //   } else if (this.datos.code = 200) {
    //     this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 1500 });
    //     setTimeout(() => {
    //       this._rauter.navigate(['/uikit/MantenimientoPorAnimal']);
    //     }, 1500);
    //   }



    // }, error => {
    //   console.log(error)
    // })

    console.log(this.MantenimientoXanimal);

    // }
  }

  //Enviamos y editamos datos
}
