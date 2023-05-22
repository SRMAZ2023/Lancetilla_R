import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { DepartamentoViewModel } from '../Models/DepartamentoViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class DepartamentosService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getCatgos(): Observable<any> {
        return this.http.get(this.url + "Departamento/ListarDepartamentos");
    }

    postDepartamentos(DepartamentoViewModel: any): Observable<Response> {

        let params = JSON.stringify(DepartamentoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Departamento/InsertarDedepartamento', params, { headers: headers });

    }

    EditDepartamentos(DepartamentoViewModel:any):Observable<any>{
        let params = JSON.stringify(DepartamentoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Departamento/ActualizarDepartamento", params, { headers: headers });
    }

    DeleteDepartamentos(DepartamentoViewModel: any): Observable<Response> {
        let params = JSON.stringify(DepartamentoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Departamento/EliminarDepartamento`, params, { headers: headers });
    }

   
}
