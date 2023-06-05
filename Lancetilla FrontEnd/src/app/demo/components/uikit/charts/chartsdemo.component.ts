import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { LayoutService } from 'src/app/layout/service/app.layout.service';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Global } from 'src/app/demo/service/Global';
import { CuidadoDePlantasViewModel } from 'src/app/demo/Models/CuidadoDePlantasViewModel';
import { FechaSS } from 'src/app/demo/Models/CuidadoDePlantasViewModel';

import * as moment from 'moment';

interface data {
  arzo_Descripcion: string;
  cantidad: number;
}

interface habitat {
  habi_Descripcion: string;
  cantidad: number;
}
interface plantas {
  tipl_NombreComun: string;
  conteo: number;
  plan_Is: number;
}

interface visis {
  visi_Sexo: string;
  cantidad: number;
}
interface anims {
  conteo: number;
  anim_Nombre: string;
  anim_Id: number;
}

interface fechas {
  fechaInicio: string;
  fechaFinal: string;
  
}


@Component({
  templateUrl: './chartsdemo.component.html'
})
export class ChartsDemoComponent implements OnInit, OnDestroy {
  lineData: any;
  barData: any;
  pieData: any;
  radarData: any;

  lineOptions: any;
  barOptions: any;
  pieOptions: any;
  radarOptions: any;

  fecha:FechaSS = {}

   
  fechainicio: any = {};
  fechafinal:  any = {};



  subscription: Subscription;
  public url: string;
  constructor(

    public layoutService: LayoutService,
    private http: HttpClient
  ) {
    this.subscription = this.layoutService.configUpdate$.subscribe(config => {
      this.initCharts();

    });
    this.url = Global.url;
  }

  ngOnInit() {
    this.filt();
    this.initCharts();
  }


  
filt(){

  const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
    const surfaceBorder = documentStyle.getPropertyValue('--surface-border');

console.log(this.fecha)

const fechaCreacion1 = moment(this.fecha.fechaInicio).format('YYYY/MM/DD').toString();

const fechaCreacion2 = moment(this.fecha.fechafinal).format('YYYY/MM/DD').toString();

  var params = {

    "fechaInicio": fechaCreacion1,
    "fechafinal": fechaCreacion2

  }
  console.log(params)
  // Obtener datos de la API para la gráfica de tarta
  this.http.post<anims[]>('https://localhost:44305/api/Plantas/MantenimientosPorAnimal', params).subscribe((data: anims[]) => {
    const labels = data.map(item => item.anim_Nombre);
    const values = data.map(item => item.conteo);
    console.log(data);
    const colors = ['#c2ff9d', '#a3ff7e', '#66ff66', '#33ff33', '#00cc00'];  // Colores para cada rebanada

    this.pieData = {
      labels: labels,
      datasets: [
        {
          data: values,
          backgroundColor: colors.slice(0, values.length),
          hoverBackgroundColor: colors.slice(0, values.length).map(color => `${color}1A`) // Color de resaltado al pasar el cursor
        }
      ]
    };
    this.pieOptions = {
      plugins: {
        legend: {
          labels: {
            usePointStyle: true,
            color: textColor
          }
        }
      }
    };
  });
}

  initCharts() {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
    const surfaceBorder = documentStyle.getPropertyValue('--surface-border');






    








    /*
    
        // Obtener datos de la API para la gráfica de radar
        this.http.get<plantas[]>(this.url + "Plantas/PlantasPorArea").subscribe((data: plantas[]) => {
            const labels = data.map(item => item.arbo_Descripcion);
            const values = data.map(item => item.cantidad);
            const colors = ['#00FF00', '#00DD00', '#00BB00', '#009900', '#007700'];  // Colores para cada rebanada
    
            this.radarData = {
              labels: labels,
              datasets: [
                {
                  label: '',
                  borderColor: colors,
                  pointBackgroundColor: colors,
                  pointBorderColor: colors,
                  pointHoverBackgroundColor: textColor,
                  pointHoverBorderColor: colors,
                  data: values
                }
              ]
            };
    
          this.radarOptions = {
            plugins: {
              legend: {
                labels: {
                  fontColor: textColor
                }
              }
            },
            scales: {
              r: {
                grid: {
                  color: textColorSecondary
                }
              }
            }
          };
        });
    
    */
  }

  ngOnDestroy() {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }
}
function filtro() {
  throw new Error('Function not implemented.');
}

