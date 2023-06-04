import { Component, ViewChild,ElementRef ,OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';
import { FacturaService } from 'src/app/demo/service/facturas.service';
import { jsPDF } from "jspdf";
import 'jspdf-autotable';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Console } from 'console';
import * as moment from 'moment';
import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
import {  AfterViewInit } from '@angular/core';


@Component({
  templateUrl: './ReporteFactura.component.html',
  providers: [MessageService],
})
export class ReporteFacturaComponent implements OnInit {
  @ViewChild('pdfViewer') pdfViewer!: ElementRef;

  pdfDataUri: SafeResourceUrl | null = null;
  errorMessage: string = '';

  facturaID : any 
  VisitanteID: any;


  constructor(
    private messageService: MessageService,
    private service: FacturaService,
    private sanitizer: DomSanitizer,
    private _route: ActivatedRoute,
    private _router: Router ,
    private localStorage: LocalStorageService
  ) {
    this.facturaID = this.localStorage.getItem('FacturaID')
    this.VisitanteID = this.localStorage.getItem('VisitanteID')}

  visi_Id : string = "1"



  TotalTotal : any = 0

  public empleado!: FacturasViewModel;
  submitted: boolean = false;
 
  Encabezado: any = {};
  Tabla: any = {};

  dataForTable = [];

  ngOnInit(): void {
    
    


   
    
  }

  ngAfterViewInit(): void {
    var params = {
      "visi_Id":  this.VisitanteID,
    };
  
    this.service.EncabezadoFactura(params).subscribe(
      Response => {
        this.Encabezado = Response;
        console.log(this.Encabezado[0].fact_Id.toString());
  
        var params2 = {
          fact_Id: this.facturaID,
        };
      
        this.service.TablaFactura(params2).subscribe(
          (response2: any) => {
            console.log(response2);
            this.Tabla = response2;
            console.log(this.Tabla);
        
            // Sumar los valores de fade_Total y guardar el resultado en una variable
            const sumaFadeTotal = response2.reduce((total: number, item: any) => {
              const fadeTotal = parseFloat(item.fade_Total.replace(/,/g, ''));
              return isNaN(fadeTotal) ? total : total + fadeTotal;
            }, 0);
            console.log('Suma de fade_Total:', sumaFadeTotal);
        
            // Formatear la suma con dos decimales
            this.TotalTotal = isNaN(sumaFadeTotal) ? '0.00' : sumaFadeTotal.toFixed(2);
           
            this.generatePDF();

          },
          error => {
            console.log(error);
          }
        );
        
        
     
      }
    );

  
  }

  
 

  generatePDF(): void {
   
    const pageSize = {
      width: 200, // Anchura de la página en unidades (por defecto en puntos)
      height: 200 // Altura de la página en unidades (por defecto en puntos)
    };
    
    const orientation = pageSize.width > pageSize.height ? 'l' : 'p';
    
    const doc = new jsPDF({
      format: [pageSize.width, pageSize.height],
      orientation: orientation,
      
    });
    
    
  


   const header = function (doc: any) {
      doc.setFontSize(18);
      const pageWidth = doc.internal.pageSize.width;
      doc.setTextColor(40);
      
      // Agregar imagen
      doc.addImage(
        'https://i.postimg.cc/s2XGcSRt/eso.jpg',
        'PNG', // Asegúrate de especificar el formato de imagen correcto
        pageWidth - 95,  -10,  90,   55,

        doc.setFontSize(30),
        doc.setFont('Pacifico', 'normal'),
        doc.text('FACTURA', 10, 30)
      );


    };


    
  
    const footer = function (doc: any) {
      // Obtener las dimensiones del footer
      const footerHeight = 65; // Altura del footer en mm
    
      // Agregar imagen en el footer
      //const imageUrl = 'https://i.ibb.co/jzbQb6B/14064375-5439134.jpg';
      const imageWidth = doc.internal.pageSize.getWidth();
      const imageHeight = footerHeight;
    
  //    doc.addImage(imageUrl, 'JPEG', 0, doc.internal.pageSize.getHeight() - footerHeight, imageWidth, imageHeight);
    
      // Agregar textos en el footer
      doc.setFontSize(16);
      doc.setFont('Helvetica', 'bold');
      doc.setTextColor(0, 0, 0);  // Establecer color de texto en negro
    
      doc.text(
        'La factura es beneficio de todos, Exijala!!!!',
        35,
        doc.internal.pageSize.getHeight() - footerHeight + 25
      );
    
      doc.text(
        'Derechos recervados Lancetilla (R)',
        43,
        doc.internal.pageSize.getHeight() - footerHeight + 35
      );
    };
  
  

          doc.setLineWidth(1); // Establecer el grosor de la línea en 1 (puedes ajustar este valor según tus necesidades)
          doc.setDrawColor(0, 0, 0); // Establecer el color de la línea en negro (valores RGB: 0, 0, 0)
          doc.line(10, 47, doc.internal.pageSize.getWidth() - 10, 47);
          const data = this.Encabezado 
          doc.setFontSize(18);
          const pageWidth = doc.internal.pageSize.width;
          doc.setTextColor(40);
          doc.setTextColor(40);
          doc.setDrawColor(0, 0, 0);
          doc.setLineWidth(0.5);
          // Agregar datos de la factura
          doc.setFontSize(12);
          doc.setFontSize(16); 
          doc.setFont("Pacifico", "normal");
          doc.text("Información de la factura:", 10, 55);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("Factura Nº: " + data[0].fact_Id, 10, 59);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("Empleado: "+ data[0].empl_Nombre , 10, 63);

          const fechaCreacion = moment(data[0].fact_Fecha).format('DD/MM/YYYY HH:mm:ss');
          doc.setFontSize(12);
          doc.setFont("Pacifico", "normal"); 
          doc.text(`Fecha : ${fechaCreacion}`, 10, 68);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("El Jardín Botánico Lancetilla se localiza ", 101, 54);
          doc.text(" a 1 kilómetro alsur de la ciudad de Tela,", 100, 58);
          doc.text(" departamento de Atlántida, en Honduras.", 100, 62);

          doc.setFontSize(11); 
          doc.setFont("Pacifico", "normal");
          doc.text("Tel: +504 9625-5484 / Cel: +504 9665-5432", 101, 69);
          
         

          doc.setLineWidth(1); // Establecer el grosor de la línea en 1 (puedes ajustar este valor según tus necesidades)
          doc.setDrawColor(0, 0, 0); // Establecer el color de la línea en negro (valores RGB: 0, 0, 0)
          doc.line(10, 73, doc.internal.pageSize.getWidth() - 10, 73);

          doc.setFontSize(16); 
          doc.setFont("Pacifico", "normal");
          doc.text("Informacion de Cliente:", 10, 80);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("Cliente: "+ data[0].visi_Nombres , 10, 86);

          doc.setFontSize(11); 
          doc.setFont("Pacifico", "normal");
          doc.text("RTN: "+data[0].visi_RTN , 10, 91);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("Metodo de pago: "+data[0].meto_Descripcion , 10, 95);
         


          doc.setFontSize(12);

          doc.setLineWidth(1); // Establecer el grosor de la línea en 1 (puedes ajustar este valor según tus necesidades)
          doc.setDrawColor(0, 0, 0); // Establecer el color de la línea en negro (valores RGB: 0, 0, 0)
          doc.line(10, 99, doc.internal.pageSize.getWidth() - 10, 99);
          // Agregar más datos según sea necesario
  
          // Llamar a las funciones de encabezado y pie de página
          header(doc);
          footer(doc);
          const headerColor = '#F49334';
          

         
          
       
this.dataForTable = []; // Inicializar el arreglo


if (Array.isArray(this.Tabla)) {
  const tablaTransformada = this.Tabla.map((item: any) => [
    item.tick_Descripcion,
    item.tick_Precio,
    item.fade_Cantidad,
    item.fade_Total
  ]);
  
  (doc as any).autoTable({
    
    head: [['Descripción', 'Precio', 'Cantidad', 'Total']],
    body: tablaTransformada,
    startY: 112,
    margin: { top: 5 },
    theme: 'grid',
    styles: {
      headStyles: {
        fillColor: '#00B894', // Cambiar el color de relleno del encabezado a un verde más agradable
        textColor: '#F49334',
      },
    },
  });
  
  
} else {
  console.error('this.Tabla no es un arreglo válido');
}





          (doc as any).autoTable({
            body: [            
              ['TOTAL:',  this.TotalTotal]
            ],
            startY: (doc as any).autoTable.previous.finalY + 1,
            margin: { top: 150, right: 14, bottom: 20, left: 117 },
            theme: 'grid',
            styles: {
              cellWidth: 'wrap',
              cellPadding: 2,
              fontSize: 10
            },
            columnStyles: {
              1: { cellWidth: 25 } // Elige el valor que necesites
            },
            headStyles: {
              fillColor: headerColor, // Cambia el color de relleno de la barra de encabezado
              textColor: '#F49334', // Cambia el color del texto de la barra de encabezado
            },
          });
         
      
  
          // Mostrar el PDF en el visor
          const pdfDataUri = doc.output('datauristring');

          if (this.pdfViewer) {
            this.pdfViewer.nativeElement.src = pdfDataUri;
          }
        }
       
      
  }

