import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AreaBotanicaViewModel } from '../Models/AreaBotanicaViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class AreaBotanicaService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getAreaBotanica(): Observable<any> {
        return this.http.get(this.url + "AreasBotanicas/ListarAreasBotanicas");
    }

    postAreaBotanica(AreaBotanicaViewModel: any): Observable<Response> {

        let params = JSON.stringify(AreaBotanicaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'AreaBotanica/InsertarCargo', params, { headers: headers });

    }

    EditAreaBotanica(AreaBotanicaViewModel:any):Observable<any>{
        let params = JSON.stringify(AreaBotanicaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "AreaBotanica/ActualizarCargo", params, { headers: headers });
    }

    DeleteAreaBotanica(AreaBotanicaViewModel: any): Observable<Response> {
        let params = JSON.stringify(AreaBotanicaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `AreaBotanica/EliminarCargo`, params, { headers: headers });
    }

   
}
