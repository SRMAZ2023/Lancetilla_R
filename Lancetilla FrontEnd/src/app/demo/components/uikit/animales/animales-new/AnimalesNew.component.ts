import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { CuidadosDePlantasService } from 'src/app/demo/service/CuidadoDePlantas';
import { ProductService } from 'src/app/demo/service/product.service';
import { PlantasCrud } from 'src/app/demo/Models/PlantasViewModel';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { AnimalService } from 'src/app/demo/service/Animales.service';
import { HabitatService } from 'src/app/demo/service/Habitat.service';
import { AreasZoologicasService } from 'src/app/demo/service/AreasZoologicas.service';
import { AlimentacionService } from 'src/app/demo/service/Alimentacion.service';
import { HabitatViewModel } from 'src/app/demo/Models/HabitatViewModel';
import { AreasZoologicasViewModel } from 'src/app/demo/Models/AreasZoologicasViewModel';
import { Especies } from 'src/app/demo/api/product';
import { AlimentacionViewModel } from 'src/app/demo/Models/AlimentacionViewModel';
import { AnimalCrud } from 'src/app/demo/Models/AnimalViewModel';
import { ReinosViewModel } from 'src/app/demo/Models/ReinosViewModel';
import { ReinosService } from 'src/app/demo/service/Reinos.service';


@Component({
    templateUrl: './AnimalesNewcomponent.html',
    providers: [MessageService, AnimalService, HabitatService, AreasZoologicasService, ProductService, AlimentacionService, ReinosService]
})

export class AnimalNewComponent implements OnInit {

    public animal!: AnimalCrud;
    public page_title!: string;;
    submitted: boolean = false;

    habitat: HabitatViewModel[] = [];
    areazoo: AreasZoologicasViewModel[] = [];
    especies: Especies[] = [];
    alimentacion: AlimentacionViewModel[] = [];
    reinos: ReinosViewModel[] = [];

    public formValid = false;
    AnimalForm: any;

    datos: any = {};



    constructor(private Animal: AnimalService,
        private messageService: MessageService,
        private HabitatService: HabitatService,
        private arzos: AreasZoologicasService,
        private alimentacionsservice: AlimentacionService,
        private especiesservices: ProductService,
        private reinoserviii: ReinosService,
        private _route: ActivatedRoute,
        private _rauter: Router) {
        this.animal = new AnimalCrud(undefined,  "",  undefined, undefined, "")
        this.page_title = "Crear Animal"
    }

    ngOnInit() {

        this.HabitatService.getHabitat().subscribe(
            response => {
                this.habitat = response.map((item: { habi_Descripcion: any; habi_Id: any; }) => ({ label: item.habi_Descripcion, value: item.habi_Id }));
            },
            error => {
                // Manejo del error
            }
        );

        this.arzos.getAreasZoologicas().subscribe(
            Response => {

                this.areazoo = Response.map((item: { arzo_Descripcion: any; arzo_Id: any; }) => ({ label: item.arzo_Descripcion, value: item.arzo_Id }));
            },
            error => { }
        );
        this.alimentacionsservice.getAlimentacion().subscribe(
            response => {
                this.alimentacion = response.map((item: { alim_Descripcion: any; alim_Id: any; }) => ({ label: item.alim_Descripcion, value: item.alim_Id }));
            },
            error => {
                // Manejo del error
            }
        );

        this.especiesservices.getEspecies().subscribe(
            Response => {

                this.especies = Response.map((item: { espe_Descripcion: any; espe_Id: any; }) => ({ label: item.espe_Descripcion, value: item.espe_Id }));
            },
            error => { }
        );

        this.reinoserviii.getReinos().subscribe(
            Response => {

                this.reinos = Response.map((item: { rein_Descripcion: any; rein_Id: any; }) => ({ label: item.rein_Descripcion, value: item.rein_Id }));
            },
            error => { }
        );




    }

    checkFormValidity() {
        this.formValid = this.AnimalForm.valid && this.animal.habi_Id || this.animal.espe_Id || this.animal.alim_Id || this.animal.rein_Id ;
    }


    //Enviamos y editamos datos
    saveAnimal() {
        // Verificar si todos los campos están llenos
        if (this.animal.anim_Nombre &&
            this.animal.anim_Codigo &&
            this.animal.anim_NombreCientifico &&
            this.animal.rein_Id &&
            this.animal.habi_Id &&
            this.animal.alim_Id &&
            this.animal.espe_Id &&
            this.animal.arzo_Id){
            // Todos los campos están llenos, realizar acciones adicionales
            console.log("Todos los campos están llenos");

            this.Animal.postAnimales(this.animal).subscribe(Response => {
                this.datos = Response;
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'warn', summary: 'Atención:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code = 200) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 1500 });
                    setTimeout(() => {
                        this._rauter.navigate(['/app/uikit/animales']);
                    }, 1500);
                }


            }, error => {
                console.log(error)
            })

        }
    }

    //Enviamos y editamos datos
}
