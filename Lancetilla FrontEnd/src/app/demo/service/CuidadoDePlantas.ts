import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CuidadoDePlantasViewModel } from '../Models/CuidadoDePlantasViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class CuidadosDePlantasService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getCuidadosDePlantas(): Observable<any> {
        return this.http.get(this.url + "CuidadosDePlantas/ListarCuidadosDePlantas");
    }

    postCuidadosDePlantas(CuidadoDePlantasViewModel: any): Observable<Response> {

        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'CuidadosDePlantas/InsertarCargo', params, { headers: headers });

    }

    EditCuidadosDePlantas(CuidadoDePlantasViewModel:any):Observable<any>{
        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "CuidadosDePlantas/ActualizarCargo", params, { headers: headers });
    }

    DeleteCuidadosDePlantas(CuidadoDePlantasViewModel: any): Observable<Response> {
        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `CuidadosDePlantas/EliminarCargo`, params, { headers: headers });
    }

   
}
