import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { MantenimintoViewModel } from '../Models/MantenimintoViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class MantenimintoService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getCatgos(): Observable<any> {
        return this.http.get(this.url + "Mantenimientos/ListarMantenimientos");
    }

    postManteniminto(MantenimintoViewModel: any): Observable<Response> {

        let params = JSON.stringify(MantenimintoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Mantenimientos/InsertMantenimiento', params, { headers: headers });

    }

    EditManteniminto(MantenimintoViewModel:any):Observable<any>{
        let params = JSON.stringify(MantenimintoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Mantenimientos/ActualizarMantenimiento", params, { headers: headers });
    }

    DeleteManteniminto(MantenimintoViewModel: any): Observable<Response> {
        let params = JSON.stringify(MantenimintoViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Mantenimientos/EliminarMantenimiento`, params, { headers: headers });
    }

   
}
