import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { error } from 'console';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
//XAnimal
import { ManteniminetoXAnimalService } from 'src/app/demo/service/ManteniminetoXAnimal.service';
import { ManteniminetoXAnimalViewModel } from 'src/app/demo/Models/ManteniminetoXAnimalViewModel';
//Mantenimiento
import { MantenimintoService } from 'src/app/demo/service/Manteniminto.service copy';
import { MantenimintoViewModel } from 'src/app/demo/Models/MantenimintoViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
  selector: 'app-MantenimientoPorAnimal-edit',
   templateUrl: './ManteniminetoPorAnimal-edit.component.html',
  //templateUrl: './MantenimientoPorAnimal-new/MantenimientoPorAnimal-New.component.html',
  providers: [MessageService, ManteniminetoXAnimalService, AreaBotanicaService, MantenimintoService]

})
export class MantenimientoPorAnimalEditComponent {
  public MantenimientoXanimal!: ManteniminetoXAnimalViewModel;

  public page_title!: string;
  submitted: boolean = false;

  Mantenimiento: MantenimintoViewModel[] = [];

  public formValid = false;
  MantenimientoPorAnimalForm: any;

  datos:any = {};


  constructor(private ManteniminetoXAnimalService: ManteniminetoXAnimalService,
    private messageService: MessageService,
    private MantenimintoService: MantenimintoService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
    this.MantenimientoPorAnimalForm = new ManteniminetoXAnimalViewModel(undefined,undefined,"",undefined,undefined,undefined,undefined,"",undefined,undefined,undefined,undefined,undefined,undefined,undefined)
    this.page_title = "Editar Planta"

  }

  ngOnInit() {

    //this.getPlanta();

    this.MantenimintoService.getCatgos().subscribe(
      response => {
        this.Mantenimiento = response.map((item: { arbo_Descripcion: any; arbo_Id: any; }) => ({ label: item.arbo_Descripcion, value: item.arbo_Id }));
      },
      error => {
        // Manejo del error
      }
    );

 


  }

  checkFormValidity() {
    this.formValid = this.MantenimientoPorAnimalForm.valid && this.MantenimientoXanimal.anim_Id || this.MantenimientoXanimal.maan_Id ;
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
      console.log("Todos los campos están llenos");

      this.ManteniminetoXAnimalService.postManteniminetoXAnimal(this.MantenimientoXanimal).subscribe(Response => {
        this.datos = Response;
        if(this.datos.code == 409){

          this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

        }else if(this.datos.code = 200){
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 1500 });
          setTimeout(() => {
            this._rauter.navigate(['/uikit/MantenimientoPorAnimal']);
          }, 1500);
        }

      

      }, error => {
        console.log(error)
      })

    // }
  }

  //Enviamos y editamos datos

  getMantenimientoPorAnimal() {
    this._route.params.subscribe(Params => {
      let plan_Id = Params['id'];

      this.ManteniminetoXAnimalService.findManteniminetoXAnimal(plan_Id).subscribe(Response => {
        this.ManteniminetoXAnimalService = Response;
        console.log(Response);
      }, error => {
        console.log(error);
      })
    });
  }
}
