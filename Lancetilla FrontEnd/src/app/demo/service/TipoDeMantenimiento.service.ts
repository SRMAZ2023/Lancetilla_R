import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { TipoDeMatenimientoViewModel } from '../Models/TipoDeManteniminetoViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class TiposDeMantenimientoService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getTiposDeMantenimientos(): Observable<any> {
        return this.http.get(this.url + "TiposDeMantenimientos/ListarTiposDeMantenimientos");
    }

    postTiposDeMantenimientos(TiposDeMantenimientosViewModel: any): Observable<Response> {

        let params = JSON.stringify(TiposDeMantenimientosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'TiposDeMantenimientos/InsertTipoDeMantenimiento', params, { headers: headers });

    }

    EditTiposDeMantenimientos(TiposDeMantenimientosViewModel:any):Observable<any>{
        let params = JSON.stringify(TiposDeMantenimientosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "TiposDeMantenimientos/ActualizarTipoDeMantenimiento", params, { headers: headers });
    }

    DeleteTiposDeMantenimientos(TiposDeMantenimientosViewModel: any): Observable<Response> {
        let params = JSON.stringify(TiposDeMantenimientosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `TiposDeMantenimientos/EliminarTipoDeMantenimiento`, params, { headers: headers });
    }

   
}
