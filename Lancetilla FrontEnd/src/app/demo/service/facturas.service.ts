import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FacturasViewModel } from '../Models/FacturasViewModel';
import { FacturasDetalleViewModel } from '../Models/FacturasDetalleViewModel';

import { VisitantesViewModel } from '../Models/VisitantesViewModel';

import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class FacturaService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getFacs(): Observable<any> {
        return this.http.get(this.url + "Facturas/ListarFacturas");

        
    }
    TodosLosVisitantes(): Observable<any> {
        return this.http.get(this.url + "Visitantes/ListarVisitantes");
    }

    TodosLosTickets(): Observable<any> {
        return this.http.get(this.url + "Tickets/ListarTickets");
    }

    MetodosDePago(): Observable<any> {
        return this.http.get(this.url + "MetodosDePago/ListarMetodosDePago");
    }

    InsertarFactura(FacturasViewModel: any): Observable<Response> {

        let params = JSON.stringify(FacturasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Facturas/InsertFactura', params, { headers: headers });

    }

    InsertarMetodoPagoFactura(FacturasViewModel: any): Observable<Response> {

        let params = JSON.stringify(FacturasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Facturas/InsertFacturaMetodoPago', params, { headers: headers });

    }

    InsertarFacturaDetalle(FacturasDetalleViewModel: any): Observable<Response> {

        let params = JSON.stringify(FacturasDetalleViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'FacturaDetalle/InsertarFacturaDetalle', params, { headers: headers });

    }


    InsertarVisitante(VisitantesViewModel: any): Observable<Response> {

        let params = JSON.stringify(VisitantesViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Visitantes/InsertVisitantes', params, { headers: headers });

    }

    EditarVisitantes(VisitantesViewModel: any): Observable<Response> {

        let params = JSON.stringify(VisitantesViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Visitantes/ActualizarVisitantes', params, { headers: headers });

    }
    
    
    EncabezadoFactura(FacturasViewModel: any): Observable<Response> {

        let params = JSON.stringify(FacturasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Facturas/EncabezadoFactura', params, { headers: headers });

    }

    TablaFactura(FacturasViewModel: any): Observable<Response> {

        let params = JSON.stringify(FacturasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Facturas/TablaFactura', params, { headers: headers });

    }

   
   
}
