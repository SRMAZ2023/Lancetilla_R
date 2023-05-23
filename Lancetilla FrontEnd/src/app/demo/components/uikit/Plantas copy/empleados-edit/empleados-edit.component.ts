import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { EmpleadosService } from 'src/app/demo/service/Empleados.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
 import { error } from 'console';
 import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { EmpleadosViewModel } from 'src/app/demo/Models/EmpleadaoViewModel';
 import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
  selector: 'app-empleados-edit',
  // templateUrl: './empleados-edit.component.html',
  templateUrl: '../empleados-new/empleadosNew.component.html',
  providers: [MessageService, EmpleadosService, AreaBotanicaService]

})
export class empleadosEditComponent {
  public empleado!: EmpleadosViewModel;
  public page_title!: string;
  submitted: boolean = false;

   areaBotanica: AreaBotanicaViewModel[] = [];

  public formValid = false;
  empleadosForm: any;

  datos:any = {};


  constructor(private EmpleadosService: EmpleadosService,
    private messageService: MessageService,
    private AreaBotanicaService: AreaBotanicaService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
      this.empleado = new EmpleadosViewModel(undefined,"","","","","","","","",undefined,"",undefined,"",undefined,"",undefined,"","",undefined,"",undefined,)
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

     



  }

  checkFormValidity() {
    this.formValid = this.empleadosForm.valid && this.empleado.estc_Id || this.empleado.carg_Id || this.empleado.dept_Id || this.empleado.muni_Id;
  }


  //Enviamos y editamos datos
  saveEmpleados() {
    // Verificar si todos los campos están llenos
    // if (this.planta.plan_Nombre &&
    //   this.planta.plan_NombreCientifico &&
    //   this.planta.plan_Reino &&
    //   this.planta.arbo_Id &&
    //   this.planta.cuid_Id) {
      // Todos los campos están llenos, realizar acciones adicionales
      console.log("Todos los campos están llenos");

      this.EmpleadosService.EditEmpleados(this.empleado).subscribe(Response => {
        this.datos = Response;
        if(this.datos.code == 409){

          this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

        }else if(this.datos.code = 200){
          this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 1500 });
          setTimeout(() => {
            this._rauter.navigate(['/uikit/empleados']);
          }, 1500);
        }

      

      }, error => {
        console.log(error)
      })

    //}
  }

  //Enviamos y editamos datos

  getPlanta() {
    this._route.params.subscribe(Params => {
      let plan_Id = Params['id'];

      this.EmpleadosService.findEmpleados(plan_Id).subscribe(Response => {
        this.empleado = Response;
        console.log(Response);
      }, error => {
        console.log(error);
      })
    });
  }
}
