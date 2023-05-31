import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FacturasViewModel } from '../Models/FacturasViewModel';
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
