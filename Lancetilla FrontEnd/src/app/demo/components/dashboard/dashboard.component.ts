import { Component, OnInit, OnDestroy } from '@angular/core';
import { MenuItem } from 'primeng/api';
import { Product } from '../../api/product';
import { ProductService } from '../../service/product.service';
import { Subscription } from 'rxjs';
import { LayoutService } from 'src/app/layout/service/app.layout.service';
import { LocalStorageService } from '../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AnimalService } from '../../service/Animales.service';
import { AnimalViewModel } from '../../Models/AnimalViewModel';
import { Table } from 'primeng/table';
@Component({
    templateUrl: './dashboard.component.html',
    providers: [ AnimalService]

})
export class DashboardComponent implements OnInit, OnDestroy {
    
    items!: MenuItem[];
    conteo: number | undefined;
    products!: Product[];
    resultadoAPI: any;
    chartData: any;

    first: number = 0;
    rows: number = 10;

    cols: any[] = []; // Aquí debes definir las columnas de tu tabla
    rowsPerPageOptions = [5, 10, 20];

    onPageChange(event: any) {
        this.first = event.first;
        this.rows = event.rows;
    }
    onRowsPerPageChange() {
        this.first = 0; 
      }
  
    chartOptions: any;

    subscription!: Subscription;

    usuarioID: any;
    valorVariable: any;
    conteoBotanica: any;
    mantsanims: any;
    arzos: any;
    Animales: AnimalViewModel[] = [];
    animal: AnimalViewModel = {};
    selectedanimals: AnimalViewModel[] = [];

    private loadData() {
        this.animalservice.getAnimales().subscribe(
            Response => {
                console.log(Response);
                this.Animales = Response
            },
            error => (
                console.log(error)
            )
        );
    }


    constructor(private _router: Router, private http: HttpClient, private animalservice: AnimalService, private localStorage: LocalStorageService, private productService: ProductService, public layoutService: LayoutService) {
        this.subscription = this.layoutService.configUpdate$.subscribe(() => {
            this.initChart();
        });
    }

    ngOnInit() {
        this.obtenerValorVariable();
        this.obtenerValorVariableBotanica();
        this.obtenerValorVariablemants();
        this.obtenerValorVariableareas();
        this.loadData()
        this.usuarioID = this.localStorage.getItem('UsuarioID')

        if (this.usuarioID == null || this.usuarioID == undefined) {

            this._router.navigate(['login']);

        }


        this.initChart();

    
        this.cols = [
            { field: 'anim_Id', header: 'plan_Id' },
            { field: 'anim_Codigo', header: 'plan_Codigo' },
            { field: 'anim_Nombre', header: 'anim_Nombre' },
            { field: 'raza_Descripcion', header: 'raza_Descripcion' },
        ];
    }

    initChart() {
        const documentStyle = getComputedStyle(document.documentElement);
        const textColor = documentStyle.getPropertyValue('--text-color');
        const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
        const surfaceBorder = documentStyle.getPropertyValue('--surface-border');


    }

    obtenerValorVariable() {
        const url = 'https://localhost:44305/api/Plantas/ConteoZoologico';

        this.http.get(url)
            .subscribe(
                response => {
                    this.valorVariable = response;
                    console.log(this.valorVariable)

                },
                error => {
                    console.error(error);
                }
            );
    }
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }

    obtenerValorVariableBotanica() {
        const url = 'https://localhost:44305/api/Plantas/ConteoBotanica';

        this.http.get(url)
            .subscribe(
                response => {
                    this.conteoBotanica = response;
                    console.log(this.conteoBotanica)

                },
                error => {
                    console.error(error);
                }
            );
    }

    obtenerValorVariablemants() {
        const url = 'https://localhost:44305/api/Plantas/qntienemasmantenimientos';

        this.http.get(url)
            .subscribe(
                response => {
                    this.mantsanims = response;
                    console.log(this.mantsanims)

                },
                error => {
                    console.error(error);
                }
            );
    }
    obtenerValorVariableareas() {
        const url = 'https://localhost:44305/api/Plantas/AnimalesPorAreas';

        this.http.get(url)
            .subscribe(
                response => {
                    this.arzos = response;
                    console.log(this.arzos)

                },
                error => {
                    console.error(error);
                }
            );
    }

    ngOnDestroy() {
        if (this.subscription) {
            this.subscription.unsubscribe();
        }
    }
}
