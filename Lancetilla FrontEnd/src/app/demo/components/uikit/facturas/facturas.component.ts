import { Component, OnInit } from '@angular/core';
import { MenuItem } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { FacturasViewModel } from 'src/app/demo/Models/FacturasViewModel';
import { TicketsViewModel } from 'src/app/demo/Models/TicketsViewModel';
import { pagoViewModel } from 'src/app/demo/Models/PagoViewModel';
import { VisitantesViewModel } from 'src/app/demo/Models/VisitantesViewModel';
import { LocalStorageService } from '../../../../local-storage.service';

import { FacturaService } from 'src/app/demo/service/facturas.service';
import { Router, ActivatedRoute, Params } from '@angular/router';





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

  
  EsAdmin: any;
    Permiso2: any;

    EmpleadoID: any;

  // Class properties and variables
  public visitante!: VisitantesViewModel;
   tickets: TicketsViewModel[] = [];
   MetodosDePagos: pagoViewModel[] = [];
   public MetodoaSelect: pagoViewModel = {};

   VisitantesTodos: VisitantesViewModel[] = [];

   

   MetododePagoDialog: boolean = false;


  public page_title!: string;
  submitted: boolean = false;

  EditaroOCrear: boolean = false;
  
  public Editar: boolean = false;
  
  routeItems: MenuItem[] = [];
  selectedOption: number = 1;
  
  public formValid = false;

       // Variables para los contadores
public zooCounter = 0;
public botanicaCounter = 0;

public IDFACTURA = 0;

public TotalZoologico = 0;
public TotalBotanica = 0;

// Variable para el total
public total = 0;

  visitantesForm: any;
  datos: any = {};

  factura: any = {};

  Genero : string = ""



  camposDesactivados = true;
   
  Permiso = true;
  Select = true;

  refreshClasses = false;

  constructor(
      private messageService: MessageService,
      private service: FacturaService,
      private _route: ActivatedRoute,
    private _router: Router ,
    private localStorage: LocalStorageService
  ) {
      this.visitante = new VisitantesViewModel(undefined, "","", "", "","", undefined, undefined)
      this.page_title = "Venta Tickets"

      this.EsAdmin = this.localStorage.getItem('EsAdmin')
      this.Permiso2 = this.localStorage.getItem('Facturas')
      this.EmpleadoID = this.localStorage.getItem('EmpleadoID')
  }
   

    ngOnInit() {

      if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

        if (this.EsAdmin == false) {

            if (this.Permiso2 == false) {
                this._router.navigate(['login']);
            }              
        }

    }else{

        this._router.navigate(['login']);
    }

       

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

        this.service.TodosLosTickets().subscribe(
          response => {
             
              this.tickets = response;
          },
          error => {
              // Manejo del error
          }
      );


    }
    
    public incrementZooCounter() {
      this.zooCounter++;
      this.updateTotal();
    }
    
    public decrementZooCounter() {
      if (this.zooCounter > 0) {
        this.zooCounter--;
        this.updateTotal();
      }
    }
    
    public incrementBotanicaCounter() {
      this.botanicaCounter++;
      this.updateTotal();
    }
    
    public decrementBotanicaCounter() {
      if (this.botanicaCounter > 0) {
        this.botanicaCounter--;
        this.updateTotal();
      }
    }
    
    updateTotal() {
      this.TotalZoologico = 0;
      this.TotalBotanica = 0;
    
      if (this.zooCounter > 0 && this.tickets[0].tick_Precio !== undefined) {
        this.TotalZoologico = this.zooCounter * parseFloat(this.tickets[0].tick_Precio.toString());
      }
    
      if (this.botanicaCounter > 0 && this.tickets[1].tick_Precio !== undefined) {
        this.TotalBotanica = this.botanicaCounter * parseFloat(this.tickets[1].tick_Precio.toString());
      }
    
      this.total = this.TotalZoologico + this.TotalBotanica;
    }

    hideDialog() {
      this.MetododePagoDialog = false;
      
      this.submitted = false;
  }

  AbrirDialogo() {
     
    if (this.total != 0) {
       
      this.service.MetodosDePago().subscribe(
        response => {
           
            this.MetodosDePagos = response;
            this.MetodosDePagos = response.map((item: { meto_Descripcion: any; meto_Id: any; }) => ({ label: item.meto_Descripcion, value: item.meto_Id }));
            this.MetododePagoDialog = true;
        },
        error => {
            // Manejo del error
        }
    );
      
    }
    else{

      this.messageService.add({ severity: 'warn', summary: 'Alerta', detail: "Ningun ticket por vender.", life: 3000 });
    }


   
   
  }

  RecargarVisitantes(){
 
    this.service.TodosLosVisitantes().subscribe(
      response => {
          this.VisitantesTodos = response.map((item: { visi_NombreCompleto: any; visi_Id: any; }) => ({ label: item.visi_NombreCompleto, value: item.visi_Id }));
      },
      error => {
          // Manejo del error
      }
    )
  }
  
  
  CompletarValores() {
    
      
      this.EditaroOCrear = false;
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
        
        this.EditaroOCrear = true;
        this.RecargarVisitantes()
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

            this.RecargarVisitantes()
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
         
      if (option == 2) {
        this.refreshClasses = true;

        if (this.visitante.visi_Nombres && this.visitante.visi_Apellido && this.visitante.visi_RTN && this.visitante.visi_Sexo != undefined) {
          this.selectedOption = option;
         
        } 
    
      } else {
        this.refreshClasses = false;
        this.EditaroOCrear = false;

        this.selectedOption = option;
      }
        
      
      }
    
      onSiguienteClick() {
      
          this.submitted = true;
          
           this.messageService.add({ severity: 'warn', summary: 'Alerta', detail: "Faltan campos por llenar.", life: 3000 });
       
           if (this.visitante.visi_Nombres?.trim() != "" &&
           this.visitante.visi_Apellido?.trim() != "" &&
           this.visitante.visi_Sexo?.trim() != ""        
            ) {
          this.selectOption(2);
          this.submitted = false;
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
             
        if (this.EditaroOCrear === true) {
            
                      this.submitted = true
                    //Verificar si todos los campos están llenos
                    if (this.visitante.visi_Nombres?.trim() != "" &&
                        this.visitante.visi_Apellido?.trim() != "" &&
                        this.visitante.visi_Sexo?.trim() != "" &&
                        this.visitante.visi_RTN != undefined 
                      
                        ) {

                          var params = {

                            "visi_Nombres": this.visitante.visi_Nombres,
                            "visi_Apellido": this.visitante.visi_Apellido,
                            "visi_RTN": this.visitante.visi_RTN,
                            "visi_Sexo": this.visitante.visi_Sexo,                        
                            "visi_UserCreacion": 1,
                            
                        }
                
                        this.service.InsertarVisitante(params).subscribe(Response => {
                            this.datos = Response;        
                           
                        
                            if ( this.visitante.visi_Id == 1 ) {

                              this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: "Todo Perfecto", life: 1500 });
                                                      
                              setTimeout(() => {
                                this.onSiguienteClick()
                              }, 1500);

                          }
                          else if (this.datos.code == 409 ) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.data.visi_UserCreacion = 200 ) {
                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.data.visi_Apellido, life: 1500 });
                                this.visitante.visi_Id = this.datos.data.visi_Id
                                
                             
                               
                                setTimeout(() => {
                                  this.onSiguienteClick()
                                }, 1500);
                            }


                        }, error => {
                            console.log(error)
                        })

                    }

        }else{
        this.submitted = true
        //Verificar si todos los campos están llenos
        if (this.visitante.visi_Nombres?.trim() != "" &&
            this.visitante.visi_Apellido?.trim() != "" &&
            this.visitante.visi_Sexo?.trim() != "" &&
            this.visitante.visi_RTN != undefined 
           
            ) {

          
              var params2 = {
                            "visi_Id": this.visitante.visi_Id,
                            "visi_Nombres": this.visitante.visi_Nombres,
                            "visi_Apellido": this.visitante.visi_Apellido,
                            "visi_RTN": this.visitante.visi_RTN,
                            "visi_Sexo": this.visitante.visi_Sexo,                        
                            "visi_UserModificacion": 1,
              }
          
            this.service.EditarVisitantes(params2).subscribe(Response => {
                this.datos = Response;
                if (this.datos.code == 409) {

                    this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code = 200) {
                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: "Todo Perfecto", life: 1500 });
                    setTimeout(() => {
                      this.onSiguienteClick()
                    }, 1500);
                }


            }, error => {
                console.log(error)
            })

        }else{
           

        }
        }
        
        
        
        
    }

    FinalizarTodo() {
      this.submitted = true
      //Verificar si todos los campos están llenos
      if (this.MetodoaSelect.meto_Id != undefined && this.MetodoaSelect.meto_Id != 0)         
          {

            var params1 = {
               "empl_Id": this.EmpleadoID,
               "visi_Id": this.visitante.visi_Id,
               "fact_UserCreacion": 1,
               
               }
          
            this.service.InsertarFactura(params1).subscribe(Response => {
              this.factura = Response;
             
             console.log(Response)
              if (this.factura.data.fact_Id !=undefined) {

                console.log(this.factura.data.fact_Id)
                this.IDFACTURA = this.factura.data.fact_Id
                
                var params2 = {
                  "fact_Id": this.IDFACTURA ,
                  "meto_Id": this.MetodoaSelect.meto_Id,
                             
                   }
              
                this.service.InsertarMetodoPagoFactura(params2).subscribe(Response => {
                  this.datos = Response;
                  console.log(Response)
                 
                 
                  if (this.zooCounter != 0) {
                      
                  console.log( this.IDFACTURA )
                    var params3 = {
                    "fact_Id": this.IDFACTURA ,
                    "tick_Id": 1,
                    "fade_Cantidad": this.zooCounter,
                    "fade_UserCreacion": 1,
                               
                     }
                
                  this.service.InsertarFacturaDetalle(params3).subscribe(Response => {
                    this.datos = Response;
                    console.log("Inserto zoologico")
                     })

                  }

                  if (this.botanicaCounter != 0) {
                  
                    var params4 = {
                      "fact_Id": this.IDFACTURA ,
                      "tick_Id": 2,
                      "fade_Cantidad": this.botanicaCounter,
                      "fade_UserCreacion": 1,
                                 
                       }
                  
                    this.service.InsertarFacturaDetalle(params4).subscribe(Response => {
                      this.datos = Response;
                      console.log("Inserto botanica")
                       
                  })
                  }
   
                  this.localStorage.setItem('VisitanteID', this.visitante.visi_Id);

                  this.localStorage.setItem('FacturaID', this.IDFACTURA);

                  
                  
                  setTimeout(() => {
                   
                    this._router.navigate(['/app/uikit/Reporte Factura']);
               
                  }, 1500);
                    
              })
                

              } 
              

          })

      }
  }

}
