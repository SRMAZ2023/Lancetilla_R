import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { EstadoCivilViewModel } from '../Models/EstadoCivilViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class EstadoCivilesService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getEstadoCiviles(): Observable<any> {
        return this.http.get(this.url + "EstadoCiviles/ListarEstadoCiviles");
    }

    postEstadoCiviles(CargoViewModel: any): Observable<Response> {

        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'EstadoCiviles/InsertEstadoCivil', params, { headers: headers });

    }

    EditEstadoCiviles(CargoViewModel:any):Observable<any>{
        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "EstadoCiviles/ActualizarEstadoCivil", params, { headers: headers });
    }

    DeleteEstadoCiviles(CargoViewModel: any): Observable<Response> {
        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `EstadoCiviles/EliminarEstadoCivil`, params, { headers: headers });
    }

   
}
