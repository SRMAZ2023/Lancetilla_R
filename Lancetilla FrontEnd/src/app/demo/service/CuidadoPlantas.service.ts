import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CuidadoDePlantasViewModel } from '../Models/CuidadoDePlantasViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class CuidadoPlantasService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getCuidadoPlantas(): Observable<any> {
        return this.http.get(this.url + "CuidadoPlantas/List");
    }

    postCuidadoPlantas(CuidadoDePlantasViewModel: any): Observable<Response> {

        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'CuidadoPlantas/Inser', params, { headers: headers });

    }

    postBuscarPlantas(CuidadoDePlantasViewModel: any): Observable<any> {

        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'CuidadoPlantas/Buscar2', params, { headers: headers });
    }

    postBuscarPlantas2(CuidadoDePlantasViewModel: any): Observable<any> {

        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'CuidadoPlantas/Buscar', params, { headers: headers });
    }

    EditCuidadoPlantas(CuidadoDePlantasViewModel:any):Observable<any>{
        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "CuidadoPlantas/Update", params, { headers: headers });
    }

    DeleteCuidadoPlantas(CuidadoDePlantasViewModel: any): Observable<Response> {
        let params = JSON.stringify(CuidadoDePlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `CuidadoPlantas/Delete`, params, { headers: headers });
    }

   
}
