import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { EmpleadosViewModel } from 'src/app/demo/Models/EmpleadaoViewModel';
import { EmpleadosService } from 'src/app/demo/service/Empleados.service';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';


@Component({
  templateUrl: './ReporteFactura.component.html',
  providers: [MessageService],
})
export class ReporteFacturaComponent implements OnInit {
  pdfDataUri: SafeResourceUrl | null = null;

  errorMessage: string = '';

  constructor(
    private messageService: MessageService,
    private service: EmpleadosService,
    private sanitizer: DomSanitizer
  ) {}

  ngOnInit(): void {
    this.generatePDF();
  }

  generatePDF(): void {
    const doc = new jsPDF();
    const header = ['Id', 'Nombre Completo', 'Sexo', 'Estado Civil'];
    const tableData: any[] = [];
  
    this.service.getEmpleados().subscribe(
      (response: any) => {
        console.log(response); // Verificar la respuesta en la consola
        const data = response; // Obtener los datos de los empleados
        data.forEach((empleado: EmpleadosViewModel) => {
          const rowData: any[] = [
            empleado.empl_Id,
            empleado.empl_Nombre,
            empleado.empl_Sexo,
            empleado.empl_Telefono
          ];
  
          tableData.push(rowData);
        });
  
        // Agregar el título "Listado de Empleados"
        doc.setFontSize(18);
        doc.text('Listado de Empleados', 14, 22);
  
        // Generar la tabla usando autoTable
        (doc as any).autoTable({
          head: [header],
          body: tableData,
          margin: { top: 30, bottom: 20 }
        });
  
        // Obtener los datos del PDF en formato de URI
        const pdfDataUri = doc.output('datauristring');
        this.pdfDataUri = this.sanitizer.bypassSecurityTrustResourceUrl(pdfDataUri) as SafeResourceUrl;
      },
      (error: any) => {
        this.errorMessage = 'Se produjo un error al obtener los datos de los empleados.';
        console.error(error);
      }
    );
  }
}
