import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class AlimentacionService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getAlimentacion(): Observable<any> {
        return this.http.get(this.url + "Alimentacion/ListarAlimentacion");
    }

    postAlimentacion(AlimentacionViewModel: any): Observable<Response> {

        let params = JSON.stringify(AlimentacionViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Alimentacion/InsertarAlimentos', params, { headers: headers });

    }

    EditAlimentacion(AlimentacionViewModel:any):Observable<any>{
        let params = JSON.stringify(AlimentacionViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Alimentacion/ActualizarAlimentos", params, { headers: headers });
    }

    DeleteAlimentacion(AlimentacionViewModel: any): Observable<Response> {
        let params = JSON.stringify(AlimentacionViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Alimentacion/EliminarAlimentos`, params, { headers: headers });
    }

   
}
