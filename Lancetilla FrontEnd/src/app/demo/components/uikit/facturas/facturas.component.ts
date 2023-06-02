import { Component, OnInit } from '@angular/core';
import { MegaMenuItem, MenuItem } from 'primeng/api';

import { MessageService } from 'primeng/api';
import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';
import { VisitantesViewModel } from 'src/app/demo/Models/VisitantesViewModel';
import { FacturaService } from 'src/app/demo/service/facturas.service';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Console } from 'console';
import * as moment from 'moment';


@Component({
    templateUrl: './facturas.component.html',
    providers: [MessageService, FacturaService],
    styles: [`
        :host ::ng-deep .p-menubar-root-list {
            flex-wrap: wrap;
        }
    `]
})
export class facturasComponent implements OnInit { 

    public visitante!: VisitantesViewModel;
    public page_title!: string;;
    submitted: boolean = false;
    
    routeItems: MenuItem[] = [];
    selectedOption: number = 2; // Declarar la propiedad selectedOption

    public formValid = false;

    visitantesForm: any;
    datos: any = {};

    VisitantesTodos: VisitantesViewModel[] = [];

    camposDesactivados = true;
     
     Permiso = true;
     Select = true;


    constructor(
        private messageService: MessageService,
        private service: FacturaService,
      
     
       
        ) {  this.visitante = new VisitantesViewModel(undefined, "", "", "","", undefined, undefined)
        this.page_title = "Venta Tickets"}
   

    ngOnInit() {
       

        this.Select = false
        this.visitante.visi_Id = 1
        this.visitante.visi_Nombre = "Cliente"
        this.visitante.visi_Apellido = "Preferido"
        this.visitante.visi_RTN = "0"
        this.visitante.visi_Sexo = "M"

        this.service.TodosLosVisitantes().subscribe(
            response => {
                this.VisitantesTodos = response.map((item: { visi_NombreCompleto: any; visi_Id: any; }) => ({ label: item.visi_NombreCompleto, value: item.visi_Id }));
            },
            error => {
                // Manejo del error
            }
        );


        this.routeItems = [
            { label: 'Personal', routerLink: 'personal' },
            { label: 'Seat', routerLink: 'seat' },
          
        ];

     
    }


    CompletarValores() {
        console.log(this.visitante.visi_Id);
      
        this.service.TodosLosVisitantes().subscribe(
          response => {
            // Almacenar los datos en una variable
            const todosLosVisitantes = response;
      
            // Filtrar los datos compatibles con this.visitante.visi_Id
            const datosCompatibles = todosLosVisitantes.filter((visitante: { visi_Id: number }) => visitante.visi_Id === this.visitante.visi_Id);

            console.log(datosCompatibles)

            this.visitante.visi_Id = datosCompatibles[0].visi_Id
            this.visitante.visi_Nombre = datosCompatibles[0].visi_Nombres
            this.visitante.visi_Apellido = datosCompatibles[0].visi_Apellido
            this.visitante.visi_RTN = datosCompatibles[0].visi_RTN
            this.visitante.visi_Sexo = datosCompatibles[0].visi_Sexo
          },
          error => {
            // Manejo del error
          }
        );
      }

    onCheckboxChange() {
       
    console.log(this.Permiso)
        if (this.Permiso == true) {
        
     

        
        this.Select = true
        this.visitante.visi_Id = 0
        this.visitante.visi_Nombre = ""
        this.visitante.visi_Apellido = ""
        this.visitante.visi_RTN = ""
        this.visitante.visi_Sexo = ""
        

        this.Permiso = false
        this.camposDesactivados = false

        this.Select = true
      }
      else{


        this.visitante.visi_Id = 1
        this.visitante.visi_Nombre = "Cliente"
        this.visitante.visi_Apellido = "Preferido"
        this.visitante.visi_RTN = "000000000000"
        this.visitante.visi_Sexo = "M"

        this.Permiso = true
        this.Select = false

        this.camposDesactivados = false
     
      }
      
      
      }
    
      // Resto de tu código
    
 
    selectOption(option: number) {
        // Aquí puedes agregar tu lógica para validar si se llenaron todos los campos
        // Si todos los campos están llenos, puedes habilitar la siguiente opción y permitir cambiar de página
        // Por ejemplo:
        if (this.visitante.visi_Nombre && this.visitante.visi_Apellido && this.visitante.visi_RTN && this.visitante.visi_Sexo) {
          this.selectedOption = option;
          this.camposDesactivados = false;
        } else {
       
          this.messageService.add({ severity: 'info', summary: 'Error', detail: "Faltan campos por llenar.", life: 3000 });
          alert("nO FUNCIONA EL TOAST")
        }
      }
    
      isCamposLlenos(): boolean {
        return (
          this.visitante.visi_Nombre !== undefined  || this.visitante.visi_Nombre != "" &&
          this.visitante.visi_Apellido !== undefined  || this.visitante.visi_Apellido != "" &&
          this.visitante.visi_RTN !== undefined || this.visitante.visi_RTN != "" &&
          this.visitante.visi_Sexo !== undefined || this.visitante.visi_Sexo != ""
        );
      }

      decrement(): void {
        // Lógica para disminuir el número
      }
    
      increment(): void {
        // Lógica para aumentar el número
      }
      

      saveEmpleados() {
        this.submitted = true
        //Verificar si todos los campos están llenos
        if (this.visitante.visi_Nombre?.trim() != "" &&
            this.visitante.visi_Nombre?.trim() != "" &&
            this.visitante.visi_Sexo?.trim() != "" &&
            this.visitante.visi_RTN != undefined 
           
            ) {

            console.log("Todos los campos están llenos");

          
            this.service.TablaFactura(this.visitante).subscribe(Response => {
                this.datos = Response;
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code = 200) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 1500 });
                    setTimeout(() => {
                     
                    }, 1500);
                }


            }, error => {
                console.log(error)
            })

        }else{
           

        }
    }

}
