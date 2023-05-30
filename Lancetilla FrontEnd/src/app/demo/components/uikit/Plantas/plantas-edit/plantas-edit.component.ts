import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { CuidadosDePlantasService } from 'src/app/demo/service/CuidadoDePlantas';
import { error } from 'console';
import { PlantasCrud } from 'src/app/demo/Models/PlantasViewModel';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { CuidadoDePlantasViewModel } from 'src/app/demo/Models/CuidadoDePlantasViewModel';
import { PlantasViewModel } from 'src/app/demo/Models/PlantasViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { ReinosViewModel } from 'src/app/demo/Models/ReinosViewModel';
import { ReinosService } from 'src/app/demo/service/Reinos.service';

@Component({
  selector: 'app-plantas-edit',
  // templateUrl: './plantas-edit.component.html',
  templateUrl: '../plantas-new/PlantasNew.component.html',
  styleUrls: ['./plantas-edit.component.scss'],
  providers: [MessageService, PlantasService, AreaBotanicaService, CuidadosDePlantasService, ReinosService]

})
export class PlantasEditComponent {
  public planta!: PlantasCrud;
  public page_title!: string;
  submitted: boolean = false;

  reino: ReinosViewModel[] = [];
  areaBotanica: AreaBotanicaViewModel[] = [];

  public formValid = false;
  PlantasForm: any;

  datos:any = {};


  constructor(private PlantasService: PlantasService,
    private messageService: MessageService,
    private AreaBotanicaService: AreaBotanicaService,
    private reinoserv: ReinosService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
    this.planta = new PlantasCrud(undefined, "", "", "", undefined,  undefined)
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

    this.reinoserv.getReinos().subscribe(
      Response => {

        this.reino = Response.map((item: { rein_Descripcion: any; rein_Id: any; }) => ({ label: item.rein_Descripcion, value: item.rein_Id }));
      },
      error => { }
    );



  }

  checkFormValidity() {
    this.formValid = this.PlantasForm.valid && this.planta.arbo_Id || this.planta.rein_Id;
  }


  //Enviamos y editamos datos
  savePlantas() {
    // Verificar si todos los campos están llenos
    if (this.planta.plan_Nombre &&
      this.planta.plan_Codigo &&
      this.planta.plan_NombreCientifico &&
      this.planta.rein_Id &&
      this.planta.arbo_Id) {
      // Todos los campos están llenos, realizar acciones adicionales
      console.log("Todos los campos están llenos");

      this.PlantasService.EditPlantas(this.planta).subscribe(Response => {
        this.datos = Response;
        if(this.datos.code == 409){

          this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

        }else if(this.datos.code = 200){
          this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 1500 });
          setTimeout(() => {
            this._rauter.navigate(['/app/uikit/Plantas']);
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

      this.PlantasService.findPlantas(plan_Id).subscribe(Response => {
        this.planta = Response;
        console.log(Response);
      }, error => {
        console.log(error);
      })
    });
  }
}
