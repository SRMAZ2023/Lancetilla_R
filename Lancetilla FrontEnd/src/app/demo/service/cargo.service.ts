import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CargoViewModel } from '../Models/CargoViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class CargosService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getCatgos(): Observable<any> {
        return this.http.get(this.url + "Cargos/ListarCargos");
    }

    postCargos(CargoViewModel: any): Observable<Response> {

        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Cargos/InsertarCargo', params, { headers: headers });

    }

    EditCargos(CargoViewModel:any):Observable<any>{
        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Cargos/ActualizarCargo", params, { headers: headers });
    }

    DeleteCargos(CargoViewModel: any): Observable<Response> {
        let params = JSON.stringify(CargoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Cargos/EliminarCargo`, params, { headers: headers });
    }

   
}
