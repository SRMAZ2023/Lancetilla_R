import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { MantenimientoPorAnimalService } from 'src/app/demo/service/MantenimientoPorAnimal.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { CuidadosDeMantenimientoPorAnimalService } from 'src/app/demo/service/CuidadoDeMantenimientoPorAnimal';
import { error } from 'console';
import { MantenimientoPorAnimalCrud } from 'src/app/demo/Models/MantenimientoPorAnimalViewModel';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { CuidadoDeMantenimientoPorAnimalViewModel } from 'src/app/demo/Models/CuidadoDeMantenimientoPorAnimalViewModel';
import { MantenimientoPorAnimalViewModel } from 'src/app/demo/Models/MantenimientoPorAnimalViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
  selector: 'app-MantenimientoPorAnimal-edit',
  // templateUrl: './MantenimientoPorAnimal-edit.component.html',
  templateUrl: '../MantenimientoPorAnimal-new/MantenimientoPorAnimalNew.component.html',
  styleUrls: ['./MantenimientoPorAnimal-edit.component.scss'],
  providers: [MessageService, MantenimientoPorAnimalService, AreaBotanicaService, CuidadosDeMantenimientoPorAnimalService]

})
export class MantenimientoPorAnimalEditComponent {
  public planta!: MantenimientoPorAnimalCrud;
  public page_title!: string;
  submitted: boolean = false;

  cuidado: CuidadoDeMantenimientoPorAnimalViewModel[] = [];
  areaBotanica: AreaBotanicaViewModel[] = [];

  public formValid = false;
  MantenimientoPorAnimalForm: any;

  datos:any = {};


  constructor(private MantenimientoPorAnimalService: MantenimientoPorAnimalService,
    private messageService: MessageService,
    private AreaBotanicaService: AreaBotanicaService,
    private CuidadosDeMantenimientoPorAnimalService: CuidadosDeMantenimientoPorAnimalService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
    this.planta = new MantenimientoPorAnimalCrud(undefined, "", "", "", undefined, "", undefined, "", "", 1, 1)
    this.page_title = "Editar Planta"

  }

  ngOnInit() {

    this.getPlanta();

    this.AreaBotanicaService.getAreaBotanica().subscribe(
      response => {
        this.areaBotanica = response.map((item: { arbo_Descripcion: any; arbo_Id: any; }) => ({ label: item.arbo_Descripcion, value: item.arbo_Id }));
      },
      error => {
        // Manejo del error
      }
    );

    this.CuidadosDeMantenimientoPorAnimalService.getCuidadosDeMantenimientoPorAnimal().subscribe(
      Response => {

        this.cuidado = Response.map((item: { cuid_Descripcion: any; cuid_Id: any; }) => ({ label: item.cuid_Descripcion, value: item.cuid_Id }));
      },
      error => { }
    );



  }

  checkFormValidity() {
    this.formValid = this.MantenimientoPorAnimalForm.valid && this.planta.arbo_Id || this.planta.cuid_Id;
  }


  //Enviamos y editamos datos
  saveMantenimientoPorAnimal() {
    // Verificar si todos los campos están llenos
    if (this.planta.plan_Nombre &&
      this.planta.plan_NombreCientifico &&
      this.planta.plan_Reino &&
      this.planta.arbo_Id &&
      this.planta.cuid_Id) {
      // Todos los campos están llenos, realizar acciones adicionales
      console.log("Todos los campos están llenos");

      this.MantenimientoPorAnimalService.EditMantenimientoPorAnimal(this.planta).subscribe(Response => {
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

    }
  }

  //Enviamos y editamos datos

  getPlanta() {
    this._route.params.subscribe(Params => {
      let plan_Id = Params['id'];

      this.MantenimientoPorAnimalService.findMantenimientoPorAnimal(plan_Id).subscribe(Response => {
        this.planta = Response;
        console.log(Response);
      }, error => {
        console.log(error);
      })
    });
  }
}
