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

  ngOnInit(): void {
    this.generatePDF();
  }

  visi_Id : string = "1"

  facturaID : any = 0

 
  Encabezado: any = {};
  Tabla:any = {};

  
 


  generatePDF(): void {
    const doc = new jsPDF();
    const header = function (doc: any) {
      doc.setFontSize(18);
      const pageWidth = doc.internal.pageSize.width;
      doc.setTextColor(40);
      
      // Agregar imagen
      doc.addImage(
        'eso.png',
      
        pageWidth - 70,
        -10,
        65,
        65
      );
    
      // Agregar texto
      doc.setFontSize(30);
      doc.setFont('Pacifico', 'normal');
      doc.text('FACTURA', 10, 30);
    };
    
  
    const footer = function (doc: any) {
      // Obtener las dimensiones del footer
      const footerHeight = 65; // Altura del footer en mm
    
      // Agregar imagen en el footer
      const imageUrl = 'https://i.ibb.co/jzbQb6B/14064375-5439134.jpg';
      const imageWidth = doc.internal.pageSize.getWidth();
      const imageHeight = footerHeight;
    
      doc.addImage(imageUrl, 'JPEG', 0, doc.internal.pageSize.getHeight() - footerHeight, imageWidth, imageHeight);
    
      // Agregar textos en el footer
      doc.setFontSize(16);
      doc.setFont('Helvetica', 'bold');
      doc.setTextColor(0, 0, 0);  // Establecer color de texto en negro
    
      doc.text(
        '¡Gracias por preferirnos para sus actividades playeras!',
        35,
        doc.internal.pageSize.getHeight() - footerHeight + 25
      );
    
      doc.text(
        '¡Playa mágica les desea lo mejor en sus actividades playeras aventureros!',
        5,
        doc.internal.pageSize.getHeight() - footerHeight + 35
      );
    };
  
    console.log(this.visi_Id);
      
   
   
    var params = {
      
      "visi_Id": 1,
     
    };
    
   
    this.service.EncabezadoFactura(params).subscribe(
      Response => {
        console.log(Response)
        this.Encabezado = Response;
          console.log(this.Encabezado[0].empl_Nombre)
        
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
          doc.text("Información de la factura", 10, 54);

          doc.setFontSize(13); 
          doc.setFont("Pacifico", "normal");
          doc.text("Factura Nº: " + data[0].fact_Id, 10, 58);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("Empleado: "+ data[0].empl_Nombre , 100, 58);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("El Jardín Botánico Lancetilla se localiza a 1 kilómetro al sur de la ciudad de Tela, departamento de Atlántida, en Honduras.", 10, 62);

          doc.setFontSize(12);
          const fechaCreacion = moment(data[0].fact_Fecha).format('DD/MM/YYYY HH:mm:ss');
  
          doc.text(`Fecha : ${fechaCreacion}`, 10, 66);
          
          doc.setLineWidth(1); // Establecer el grosor de la línea en 1 (puedes ajustar este valor según tus necesidades)
          doc.setDrawColor(0, 0, 0); // Establecer el color de la línea en negro (valores RGB: 0, 0, 0)
          doc.line(10, 73, doc.internal.pageSize.getWidth() - 10, 73);

          doc.setFontSize(16); 
          doc.setFont("Pacifico", "normal");
          doc.text("Informacion de Cliente", 10, 80);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("Cliente: "+ data[0].visi_Nombres , 10, 84);

          doc.setFontSize(12); 
          doc.setFont("Pacifico", "normal");
          doc.text("RTN:"+data[0].visi_RTN , 100, 84);
         
          doc.setFontSize(12);

          doc.setLineWidth(1); // Establecer el grosor de la línea en 1 (puedes ajustar este valor según tus necesidades)
          doc.setDrawColor(0, 0, 0); // Establecer el color de la línea en negro (valores RGB: 0, 0, 0)
          doc.line(10, 99, doc.internal.pageSize.getWidth() - 10, 99);
          // Agregar más datos según sea necesario
  
          // Llamar a las funciones de encabezado y pie de página
          header(doc);
          footer(doc);
          const headerColor = '#F49334';
          

          var params2 = {
            fact_Id: 1,
            
          };
          
         
          this.service.TablaFactura(params2).subscribe(
            (Response: any) => { // O (value: any) en lugar de (response: any)
              console.log(Response)
              this.Tabla = Response;
             
              // Crear el array de datos para la tabla en el PDF
              const dataForTable = this.Tabla.map((item: any) => [
                item.tick_Descripcion,
                item.tick_Precio,
                item.fade_Cantidad,
                item.fade_Total
              ]);
            
              // Agregar la tabla al PDF
              (doc as any).autoTable({
                head: [['Descripción', 'Precio', 'Cantidad', 'Total']],
                body: dataForTable,
                startY: 112,
                margin: { top: 10 },
                theme: 'grid',
                styles: {
                  headStyles: {
                    fillColor: headerColor,
                    textColor: '#F49334',
                  },
                },
              });
            },
            error => {
              console.log(error);
            }
          );
          

          (doc as any).autoTable({
            body: [
              ['SubTotal:', data.fuct_Subtotal],
              ['IVA:', data.fuct_Isv],
              ['TOTAL:', data.fuct_Total]
            ],
            startY: (doc as any).autoTable.previous.finalY + 1,
            margin: { top: 150, right: 15, bottom: 20, left: 115 },
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
         
          doc.text('Participantes de la actividad: ', 14, 106); 
  
          // Mostrar el PDF en el visor
          const pdfDataUri = doc.output('datauristring');
          this.pdfViewer.nativeElement.src = pdfDataUri;
        },
        (error: any) => {
          this.errorMessage = 'Se produjo un error al obtener los datos de los empleados.';
          console.error(error);
        }
      );
  }
}
