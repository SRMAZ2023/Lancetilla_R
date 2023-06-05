import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { EmpleadosService } from 'src/app/demo/service/Empleados.service';
import { EmpleadosViewModel } from 'src/app/demo/Models/EmpleadaoViewModel';
import { Municipios } from 'src/app/demo/Models/EmpleadaoViewModel';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { error } from 'console';
import { EstadoCivilesService } from 'src/app/demo/service/EstadoCivil.service';
import { EstadoCivilViewModel } from 'src/app/demo/Models/EstadoCivilViewModel';
import { CargosService } from 'src/app/demo/service/cargo.service';
import { CargoViewModel } from 'src/app/demo/Models/CargoViewModel';
import { DepartamentosService } from 'src/app/demo/service/departamento.service';
import { DepartamentoViewModel } from 'src/app/demo/Models/DepartamentoViewModel';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { LocalStorageService } from '../../../../../local-storage.service';



@Component({
    templateUrl: './empleadosNew.component.html',
    providers: [MessageService, EmpleadosService, EstadoCivilesService, CargosService, DepartamentosService]
})

export class empleadosNewComponent implements OnInit {

    EsAdmin: any;
    Permiso: any;

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
        private _router: Router,
        private localStorage: LocalStorageService,
        private messageService: MessageService,
        private EstadoCivilesService: EstadoCivilesService,
        private CargosService: CargosService,
        private DepartamentosService: DepartamentosService,
        private _route: ActivatedRoute,
        private _rauter: Router) {
        this.empleado = new EmpleadosViewModel(undefined, "", "", "", undefined, "", "", "", "", undefined, "", undefined, "", undefined, "", undefined, "", "", 1, "", 1,)
        this.page_title = "https://i.ibb.co/PjpGtjQ/13.png"
        this.EsAdmin = this.localStorage.getItem('EsAdmin')
        this.Permiso = this.localStorage.getItem('Empleados')
    }

    ngOnInit() {

        if (this.EsAdmin != null || this.EsAdmin != undefined) {

            if (this.EsAdmin == false) {

                if (this.Permiso == false) {
                    this._router.navigate(['/app']);
                }
            }

        } else {

            this._router.navigate(['login']);
        }


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
        var depa_id: string = selectedDepartamento;

        var params = {
            "dept_Id": depa_id,

        }

        console.log(params);

        //Carga los Municipios
        this.EmpleadosService.findMunicipios(params).subscribe(
            Response => {
                console.log(Response)

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
        this.submitted = true
        //Verificar si todos los campos están llenos
        if (this.empleado.empl_Nombre?.trim() != "" &&
            this.empleado.empl_Apellido?.trim() != "" &&
            this.empleado.empl_Sexo?.trim() != "" &&
            this.empleado.empl_FechaNacimiento != undefined &&
            this.empleado.muni_Id != undefined &&
            this.empleado.dept_Id != undefined
        ) {

            console.log("Todos los campos están llenos");

            console.log(this.empleado)

            this.EmpleadosService.postEmpleados(this.empleado).subscribe(Response => {
                this.datos = Response;
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code = 200) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 1500 });
                    setTimeout(() => {
                        this._rauter.navigate(['/app/uikit/Empleados']);
                    }, 1500);
                }


            }, error => {
                console.log(error)
            })

        } else {
            console.log(this.empleado.empl_Sexo);
            console.log(this.empleado)

        }
    }

    //Enviamos y editamos datos
}
