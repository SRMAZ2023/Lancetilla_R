import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { EmpleadosService } from 'src/app/demo/service/Empleados.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { error } from 'console';
import { Municipios } from 'src/app/demo/Models/EmpleadaoViewModel';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { EstadoCivilesService } from 'src/app/demo/service/EstadoCivil.service';
import { EstadoCivilViewModel } from 'src/app/demo/Models/EstadoCivilViewModel';
import { CargosService } from 'src/app/demo/service/cargo.service';
import { CargoViewModel } from 'src/app/demo/Models/CargoViewModel';
import { DepartamentosService } from 'src/app/demo/service/departamento.service';
import { DepartamentoViewModel } from 'src/app/demo/Models/DepartamentoViewModel';
import { EmpleadosViewModel } from 'src/app/demo/Models/EmpleadaoViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
  selector: 'app-empleados-edit',
  // templateUrl: './empleados-edit.component.html',
  templateUrl: '../empleados-new/empleadosNew.component.html',
  providers: [MessageService, EmpleadosService, EstadoCivilesService, CargosService, DepartamentosService]

})
export class empleadosEditComponent {

  public empleado!: EmpleadosViewModel;
  public page_title!: string;;
  submitted: boolean = false;

  estadoCivil: EstadoCivilViewModel[] = [];
  cargo: CargoViewModel[] = [];
  departamento: DepartamentoViewModel[] = [];
  municipios: Municipios[] = [];
  areaBotanica: AreaBotanicaViewModel[] = [];

  public formValid = false;
  empleadosForm: any;

  datos: any = {};

  municipioDisabled = true;


  constructor(private EmpleadosService: EmpleadosService,
    private messageService: MessageService,
    private EstadoCivilesService: EstadoCivilesService,
    private CargosService: CargosService,
    private DepartamentosService: DepartamentosService,
    private _route: ActivatedRoute,
    private _rauter: Router) {
    this.empleado = new EmpleadosViewModel(undefined, "", "", "", undefined, "", "", "", "", undefined, "", undefined, "", undefined, "", undefined, "", "", undefined, "", undefined,)
    this.page_title = "Editar empleado"
  }

  ngOnInit() {

    this.getEmpleado();




    this.EstadoCivilesService.getEstadoCiviles().subscribe(
      response => {
        this.estadoCivil = response.map((item: { estc_Descripcion: any; estc_Id: any; }) => ({ label: item.estc_Descripcion, value: item.estc_Id }));
      },
      error => {
        // Manejo del error
      }
    );

    this.CargosService.getCatgos().subscribe(
      response => {
        this.cargo = response.map((item: { carg_Descripcion: any; carg_Id: any; }) => ({ label: item.carg_Descripcion, value: item.carg_Id }));
      },
      error => {
        // Manejo del error
      }
    );
    this.DepartamentosService.getCatgos().subscribe(
      response => {
        this.departamento = response.map((item: { dept_Descripcion: any; dept_Id: any; }) => ({ label: item.dept_Descripcion, value: item.dept_Id }));
      },
      error => {
        // Manejo del error
      }
    );



  }

  checkFormValidity() {
    this.formValid = this.empleadosForm.valid && this.empleado.estc_Id || this.empleado.carg_Id || this.empleado.dept_Id || this.empleado.muni_Id;
  }


  onDepartamentoChange(event: any) {
    const selectedDepartamento = event.value;
    console.log(selectedDepartamento);


    this.takeMunicipio(selectedDepartamento);



  }

  takeMunicipio(selectedDepartamento: any) {

    var params = {
      "dept_Id": selectedDepartamento,

    }

    //Carga los Municipios
    this.EmpleadosService.findMunicipios(params).subscribe(
      Response => {
        console.log(Response)
        this.datos = Response;

        this.municipios = Response.map((item: { muni_Descripcion: any; muni_Id: any; }) => ({ label: item.muni_Descripcion, value: item.muni_Id }));

        // Activa el otro dropdown
        this.municipioDisabled = false;

      },
      error => {
        console.log(error)
        this.municipioDisabled = true;

      }
    );
  }

  //Enviamos y editamos datos
  saveEmpleados() {
    // Verificar si todos los campos están llenos
    if (this.empleado.empl_Nombre?.trim() != "" &&
      this.empleado.empl_Apellido?.trim() != "" &&
      this.empleado.empl_Sexo?.trim() != "" &&
      this.empleado.empl_FechaNacimiento != undefined &&
      this.empleado.muni_Id != "" &&
      this.empleado.dept_Id != "") {
      console.log("Todos los campos están llenos");

      this.EmpleadosService.EditEmpleados(this.empleado).subscribe(Response => {
        this.datos = Response;
        if (this.datos.code == 409) {

          this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

        } else if (this.datos.code = 200) {
          this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 1500 });
          console.log( this.datos.message)
          setTimeout(() => {
            this._rauter.navigate(['/app/uikit/Empleados']);
          }, 1500);
        }



      }, error => {
        console.log(error)
      })

    }
  }

  //Enviamos y editamos datos

  getEmpleado() {
    this._route.params.subscribe(Params => {
      let plan_Id = Params['id'];

      this.EmpleadosService.findEmpleados(plan_Id).subscribe(Response => {
        this.empleado = Response;

        console.log(this.empleado)

        var fecha = new Date(this.empleado.empl_FechaNacimiento!);
        console.log("Fecha = " + fecha)

        this.empleado.empl_FechaNacimiento = fecha;

        if (this.empleado.dept_Id !== "" || this.empleado.muni_Id !== "") {
          console.log(Response);

          this.municipioDisabled = true;
          console.log("dentro " + this.empleado.dept_Id);
          console.log("dentro M " + this.empleado.muni_Id);
          this.takeMunicipio(this.empleado.dept_Id);
          // Buscar el objeto municipio que coincide con this.empleado.muni_Id
          const municipioSeleccionado = this.municipios.find(municipio => municipio.muni_Id === this.empleado.muni_Id);

          if (municipioSeleccionado) {
            // Establecer el objeto municipio como valor seleccionado en el dropdown
            this.empleado.muni_Id = municipioSeleccionado.muni_Id;
            console.log(this.empleado.muni_Id);
          }


        }
      }, error => {
        console.log(error);
      });
    });
  }

}
