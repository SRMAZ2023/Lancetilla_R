import { Component, ViewChild,ElementRef ,OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';
import { FacturaService } from 'src/app/demo/service/facturas.service';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Console } from 'console';
import * as moment from 'moment';


@Component({
  templateUrl: './ReporteFactura.component.html',
  providers: [MessageService],
})
export class ReporteFacturaComponent implements OnInit {
  @ViewChild('pdfViewer') pdfViewer!: ElementRef;

  pdfDataUri: SafeResourceUrl | null = null;
  errorMessage: string = '';

  constructor(
    private messageService: MessageService,
    private service: FacturaService,
    private sanitizer: DomSanitizer
  ) {}

  visi_Id : string = "1"

  facturaID : any = 0

  TotalTotal : any = 0

  public empleado!: FacturasViewModel;
  submitted: boolean = false;
 
  Encabezado: any = {};
  Tabla: any = {};

  dataForTable = [];

  ngOnInit(): void {
    
  
    var params = {
      "visi_Id": 1,
    };
  
    this.service.EncabezadoFactura(params).subscribe(
      Response => {
        this.Encabezado = Response;
        console.log(this.Encabezado[0].fact_Id.toString());
  
        var params2 = {
          fact_Id: this.Encabezado[0].fact_Id,
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
           
        
            // La primera petición se ha completado aquí
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
    const doc = new jsPDF();
    const header = function (doc: any) {
      doc.setFontSize(18);
      const pageWidth = doc.internal.pageSize.width;
      doc.setTextColor(40);
      
      // Agregar imagen
      doc.addImage(
        'data:image/png;base64,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',
        'PNG', // Asegúrate de especificar el formato de imagen correcto
        pageWidth - 70,  -10,  65,   55,

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
    margin: { top: 10 },
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
          this.pdfViewer.nativeElement.src = pdfDataUri;
        }
       
      
  }

