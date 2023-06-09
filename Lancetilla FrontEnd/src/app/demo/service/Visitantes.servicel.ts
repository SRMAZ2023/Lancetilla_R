import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { VisitantesViewModel } from '../Models/VisitantesViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class VisitantesService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getVisitantes(): Observable<any> {
        return this.http.get(this.url + "Visitantes/ListarVisitantes");
    }

    FacturasPorVisitante(VisitantesViewModel: any): Observable<Response> {

        let params = JSON.stringify(VisitantesViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Visitantes/FacturasPorVisitante', params, { headers: headers });

    }

}
