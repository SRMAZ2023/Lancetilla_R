import { Component, OnInit } from '@angular/core';
import { MenuItem } from 'primeng/api';
import { MessageService } from 'primeng/api';

import { TicketsViewModel } from 'src/app/demo/Models/TicketsViewModel';
import { pagoViewModel } from 'src/app/demo/Models/PagoViewModel';
import { VisitantesViewModel } from 'src/app/demo/Models/VisitantesViewModel';
import { LocalStorageService } from '../../../../local-storage.service';

import { TicketsService } from 'src/app/demo/service/Tickets.service';
import { Router, ActivatedRoute, Params } from '@angular/router';





@Component({
  templateUrl: './tickets.component.html',
  providers: [MessageService, TicketsService],
  styles: [`
      :host ::ng-deep .p-menubar-root-list {
          flex-wrap: wrap;
      }
  `]
})
export class ticketsComponent implements OnInit {

  
    EsAdmin: any;
    Permiso: any;

   

    TicketsDialog: boolean = false;

   tickets: TicketsViewModel[] = [];

   Precio: any ;

   TicketID: any ;
 
  constructor(
      private messageService: MessageService,
      private service: TicketsService,
      private _route: ActivatedRoute,
    private _router: Router ,
    private localStorage: LocalStorageService
  ) {
   
      this.EsAdmin = this.localStorage.getItem('EsAdmin')
      this.Permiso = this.localStorage.getItem('Facturas')
    
  }
   

    ngOnInit() {

      if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

        if (this.EsAdmin == false) {

            if (this.Permiso == false) {
                this._router.navigate(['/app']);
            }              
        }

    }else{

        this._router.navigate(['login']);
    }

       this. CargarTodo()


    } 

    CargarTodo(){

        this.service.ListaTickets().subscribe(
            response => {
                this.tickets = response
                console.log(this.tickets)

             
            },
            error => {
                
            }
        );
    }

    CerrarModal(){
 
        this.TicketsDialog = false;
  
     }
  

   CargarModal(Precio : any, ID : any){
 
      this.TicketsDialog = true;
      this.Precio = Precio
      this.TicketID = ID

   }

    EditarPrecio(){

      
      if (this.Precio > 0 &&  this.Precio != undefined ) {
        
    
        var params4 = {
            "tick_Id":  this.TicketID,
            "tick_Precio":  this.Precio ,
           
                       
             }
      
              console.log(params4)
      
        this.service.CambiarPrecio(params4).subscribe(
            response => {

                    

          
                      this.TicketsDialog = false;

                      this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: "Precio Cambiadob Exitosamente", life: 2000 });
                      this.CargarTodo()
       
                    },
            error => {
                
            }
        );
      }
      
    }

}

