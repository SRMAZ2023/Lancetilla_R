import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { CuidadosDePlantasService } from 'src/app/demo/service/CuidadoDePlantas';
import { error } from 'console';
import { PlantasCrud } from 'src/app/demo/Models/PlantasViewModel';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { CuidadoDePlantasViewModel } from 'src/app/demo/Models/CuidadoDePlantasViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';


@Component({
    templateUrl: './PlantasNew.component.html',
    providers: [MessageService, PlantasService, AreaBotanicaService, CuidadosDePlantasService]
})

export class PlantasNewComponent implements OnInit {

    public planta!: PlantasCrud;
    public page_title!: string;;
    submitted: boolean = false;

    cuidado: CuidadoDePlantasViewModel[] = [];
    areaBotanica: AreaBotanicaViewModel[] = [];

    public formValid = false;
    PlantasForm: any;

    datos: any = {};



    constructor(private PlantasService: PlantasService,
        private messageService: MessageService,
        private AreaBotanicaService: AreaBotanicaService,
        private CuidadosDePlantasService: CuidadosDePlantasService,
        private _route: ActivatedRoute,
        private _rauter: Router) {
        this.planta = new PlantasCrud(undefined, "", "", "", undefined, "", undefined, "", "", 1, 1)
        this.page_title = "Crear Planta"
    }

    ngOnInit() {

        this.AreaBotanicaService.getAreaBotanica().subscribe(
            response => {
                this.areaBotanica = response.map((item: { arbo_Descripcion: any; arbo_Id: any; }) => ({ label: item.arbo_Descripcion, value: item.arbo_Id }));
            },
            error => {
                // Manejo del error
            }
        );

        this.CuidadosDePlantasService.getCuidadosDePlantas().subscribe(
            Response => {

                this.cuidado = Response.map((item: { cuid_Descripcion: any; cuid_Id: any; }) => ({ label: item.cuid_Descripcion, value: item.cuid_Id }));
            },
            error => { }
        );



    }

    checkFormValidity() {
        this.formValid = this.PlantasForm.valid && this.planta.arbo_Id || this.planta.cuid_Id;
    }


    //Enviamos y editamos datos
    savePlantas() {
        // Verificar si todos los campos están llenos
        if (this.planta.plan_Nombre &&
            this.planta.plan_NombreCientifico &&
            this.planta.plan_Reino &&
            this.planta.arbo_Id &&
            this.planta.cuid_Id) {
            // Todos los campos están llenos, realizar acciones adicionales
            console.log("Todos los campos están llenos");

            this.PlantasService.postPlantas(this.planta).subscribe(Response => {
                this.datos = Response;
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'info', summary: 'Error', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code = 200) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades', detail: this.datos.message, life: 1500 });
                    setTimeout(() => {
                        this._rauter.navigate(['/uikit/Plantas']);
                    }, 1500);
                }


            }, error => {
                console.log(error)
            })

        }
    }

    //Enviamos y editamos datos
}
