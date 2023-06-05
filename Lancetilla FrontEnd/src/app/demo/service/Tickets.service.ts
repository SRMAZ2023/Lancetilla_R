import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { TicketsViewModel } from '../Models/TicketsViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class TicketsService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }
 

    ListaTickets(): Observable<any> {
        return this.http.get(this.url + "Tickets/ListarTickets");
    }


    CambiarPrecio(TicketsViewModel: any): Observable<Response> {
        let params = JSON.stringify(TicketsViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Tickets/ActualizarPrecio`, params, { headers: headers });
    }

   
   

   
}
