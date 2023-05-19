import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { PlantasViewModel } from '../Models/PlantasViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class PlantasService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getPlantas(): Observable<any> {
        return this.http.get(this.url + "Plantas/ListarCuidadosDePlantas");
    }

    postPlantas(PlantasViewModel: any): Observable<Response> {

        let params = JSON.stringify(PlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Plantas/InsertarPlanta', params, { headers: headers });

    }

    EditPlantas(PlantasViewModel:any):Observable<any>{
        let params = JSON.stringify(PlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Plantas/ActualizarPlanta", params, { headers: headers });
    }

    DeletePlantas(PlantasViewModel: any): Observable<Response> {
        let params = JSON.stringify(PlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Plantas/EliminarPlanta`, params, { headers: headers });
    }

   
}
