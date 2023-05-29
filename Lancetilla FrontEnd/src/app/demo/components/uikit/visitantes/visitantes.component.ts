import { Component, OnInit } from '@angular/core';
import { pagoViewModel } from 'src/app/demo/Models/PagoViewModel';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { MetodosPagoService } from 'src/app/demo/service/Pago.service';
import { error } from 'console';
import { VisitantesService } from 'src/app/demo/service/Visitantes.servicel';
import { VisitantesViewModel } from 'src/app/demo/Models/VisitantesViewModel';
//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';

@Component({
    templateUrl: './visitantes.component.html',
    providers: [MessageService, VisitantesService]
})
export class visitantesComponent implements OnInit {

    //Dialogs
    visitanteDialog: boolean = false;

    deletevisitanteDialog: boolean = false;

    deletevisitantesDialog: boolean = false;
    //Dialogs

    //datos
    datos:any = {};

    public Editar: boolean = false;
    visitantes: VisitantesViewModel[] = [];
    visitante: VisitantesViewModel = {};

    //validar espacio
    espacio: boolean = false;

    //Paginacion de el datatable
    selectedVisitante: VisitantesViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;

    first: number = 0;
    rows: number = 10;

    cols: any[] = []; // Aquí debes definir las columnas de tu tabla

    onPageChange(event: any) {
        this.first = event.first;
        this.rows = event.rows;
    }

    onRowsPerPageChange() {
        this.first = 0; 
      }
  



    statuses: any[] = [];


    constructor(private VisitanteService: VisitantesService, private messageService: MessageService) {
    }

    ngOnInit() {

        this.VisitanteService.getVisitantes().subscribe(
            Response => {
                console.log(Response);
                this.visitantes = Response
            },
            error => (
                console.log(error)
            )
        );

        this.cols = [
            { field: 'visi_Id',          header: 'visi_Id' },
            { field: 'visi_Nombre', header: 'visi_Nombre' },
            { field: 'visi_RTN', header: 'visi_RTN' },
            { field: 'visi_Sexos',          header: 'visi_Sexos' },

        ];

    }



   



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
