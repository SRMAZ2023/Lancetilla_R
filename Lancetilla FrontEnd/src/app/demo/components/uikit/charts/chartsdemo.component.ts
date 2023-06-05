import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { LayoutService } from 'src/app/layout/service/app.layout.service';
import { HttpClient } from '@angular/common/http';
import { Global } from 'src/app/demo/service/Global';


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
    this.initCharts();
  }


  

  initCharts() {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
    const surfaceBorder = documentStyle.getPropertyValue('--surface-border');

    // Obtener datos de la API para la gráfica de barras
    this.http.get<plantas[]>(this.url + "TiposCuidados/CuidadoPorPlanta").subscribe((data: plantas[]) => {
      const labels = data.map(item => item.tipl_NombreComun);
      const values = data.map(item => item.conteo);

      const colors = ['#c2ff9d', '#a3ff7e', '#66ff66', '#33ff33', '#00cc00'];  // Colores para cada rebanada

      this.barData = {
        labels: labels,
        datasets: [
          {
            label: 'Plantas',
            backgroundColor: colors.slice(0, values.length),
            borderColor: '#122341',
            data: values
          }
        ]
      };

      this.barOptions = {
        plugins: {
          legend: {
            labels: {
              fontColor: textColor
            }
          }
        },
        scales: {
          x: {
            ticks: {
              color: textColorSecondary,
              font: {
                weight: 500
              }
            },
            grid: {
              display: false,
              drawBorder: false
            }
          },
          y: {
            ticks: {
              color: textColorSecondary
            },
            grid: {
              color: surfaceBorder,
              drawBorder: false
            }
          }
        }
      };
    });


 // Obtener datos de la API para la gráfica de tarta
 this.http.get<anims[]>(this.url + "TiposCuidados/MantenimientosPorAnimal").subscribe((data: anims[]) => {
  const labels = data.map(item => item.anim_Nombre);
  const values = data.map(item => item.conteo);
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







    // Obtener datos de la API para la gráfica de línea
    this.http.get<visis[]>(this.url + "Visitantes/VisitantesSexo").subscribe((data: visis[]) => {
        const labels = data.map(item => item.visi_Sexo);
        const values = data.map(item => item.cantidad);
        const colors = ['#00FF00', '#00DD00', '#00BB00', '#009900', '#007700'];  // Colores para cada rebanada

        this.lineData = {
          labels: labels,
          datasets: [
            {
              label: 'Visitantes',
              data: values,
              fill: false,
              backgroundColor: colors,
              borderColor: colors,
              tension: 0.4
            }
          ]
        };

      this.lineOptions = {
        plugins: {
          legend: {
            labels: {
              fontColor: textColor
            }
          }
        },
        scales: {
          x: {
            ticks: {
              color: textColorSecondary
            },
            grid: {
              color: surfaceBorder,
              drawBorder: false
            }
          },
          y: {
            ticks: {
              color: textColorSecondary
            },
            grid: {
              color: surfaceBorder,
              drawBorder: false
            }
          },
        }
      };
    });




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
