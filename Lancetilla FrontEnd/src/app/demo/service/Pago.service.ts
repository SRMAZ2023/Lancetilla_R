import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CargoViewModel } from '../Models/CargoViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class MetodosPagoService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getMetodosDePago(): Observable<any> {
        return this.http.get(this.url + "MetodosDePago/ListarMetodosDePago");
    }

    postMetodosDePago(CargoViewModel: any): Observable<Response> {

        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'MetodosDePago/InsertarMetodoDePago', params, { headers: headers });

    }

    EditMetodosDePago(CargoViewModel:any):Observable<any>{
        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "MetodosDePago/ActualizarMetodoDePago", params, { headers: headers });
    }

    DeleteMetodosDePago(CargoViewModel: any): Observable<Response> {
        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `MetodosDePago/EliminarMetodoDePago`, params, { headers: headers });
    }

   
}
