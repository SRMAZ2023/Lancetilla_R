import { Component, OnInit } from '@angular/core';
import { MenuItem } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';
import { VisitantesViewModel } from 'src/app/demo/Models/VisitantesViewModel';
import { FacturaService } from 'src/app/demo/service/facturas.service';






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
  // Class properties and variables
  public visitante!: VisitantesViewModel;
  public page_title!: string;
  submitted: boolean = false;
  
  routeItems: MenuItem[] = [];
  selectedOption: number = 1;
  
  public formValid = false;

  visitantesForm: any;
  datos: any = {};

  Genero : string = ""

  VisitantesTodos: VisitantesViewModel[] = [];

  camposDesactivados = true;
   
  Permiso = true;
  Select = true;

  refreshClasses = false;

  constructor(
      private messageService: MessageService,
      private service: FacturaService,
  ) {
      this.visitante = new VisitantesViewModel(undefined, "","", "", "","", undefined, undefined)
      this.page_title = "Venta Tickets"
  }
   

    ngOnInit() {
       

        this.Select = false
        this.visitante.visi_Id = 1
        this.visitante.visi_Nombres = "Cliente"
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
   
            const todosLosVisitantes = response;       
            const datosCompatibles = todosLosVisitantes.filter((visitante: { visi_Id: number }) => visitante.visi_Id === this.visitante.visi_Id);
     
            this.visitante.visi_Id = datosCompatibles[0].visi_Id
            this.visitante.visi_Nombres = datosCompatibles[0].visi_Nombres
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
        
        if (this.Permiso == true) {
        
        this.Select = true
        this.visitante.visi_Id = 0
        this.visitante.visi_Nombres = ""
        this.visitante.visi_Apellido = ""
        this.visitante.visi_RTN = ""
        this.visitante.visi_Sexo = ""
        
        this.submitted = false
        
        this.Permiso = false
        this.camposDesactivados = false

        this.Select = true
      }
      else{


        this.visitante.visi_Id = 1
        this.visitante.visi_Nombres = "Cliente"
        this.visitante.visi_Apellido = "Preferido"
        this.visitante.visi_RTN = "000000000000"
        this.visitante.visi_Sexo = "M"

        this.Permiso = true
        this.Select = false

        this.camposDesactivados = true
     
        }
          
      }
    
      // Resto de tu código
    
 
    selectOption(option: number) {
     
      console.log(option)
      if (option == 2) {
        this.refreshClasses = true;
        console.log("hOLA")
      } else {
        this.refreshClasses = false;
      }
        
      if (this.visitante.visi_Nombres && this.visitante.visi_Apellido && this.visitante.visi_RTN && this.visitante.visi_Sexo != undefined) {
          this.selectedOption = option;
         
        } else {
   
        }
      }
    
      onSiguienteClick() {
      
          this.submitted = true;
          
           this.messageService.add({ severity: 'info', summary: 'Error', detail: "Faltan campos por llenar.", life: 3000 });
       
           if (this.visitante.visi_Nombres?.trim() != "" &&
           this.visitante.visi_Apellido?.trim() != "" &&
           this.visitante.visi_Sexo?.trim() != ""        
            ) {
          this.selectOption(2);
        }
      }
      
      isCamposLlenos(): boolean {
        return (
          !!this.visitante.visi_Id &&
          !!this.visitante.visi_Nombres &&
          !!this.visitante.visi_Apellido &&
          !!this.visitante.visi_RTN &&
          this.visitante.visi_Sexo != undefined
        );
      }
      

      decrement(): void {
        // Lógica para disminuir el número
      }
    
      increment(): void {
        // Lógica para aumentar el número
      }
      

      GuardarVisitante() {
        this.submitted = true
        //Verificar si todos los campos están llenos
        if (this.visitante.visi_Nombres?.trim() != "" &&
            this.visitante.visi_Apellido?.trim() != "" &&
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
