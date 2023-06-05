import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
 import { Observable } from "rxjs"
import { Global } from './Global';
import { TiposCuidadosViewModel } from '../Models/TiposCuidadosViewModel';

@Injectable()
export class TiposCuidadosService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getTiposCuidados(): Observable<any> {
        return this.http.get(this.url + "TiposCuidados/List");
    }

    postTiposCuidados(TiposCuidadosViewModel: any): Observable<Response> {

        let params = JSON.stringify(TiposCuidadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'TiposCuidados/Insert', params, { headers: headers });

    }

    EditTiposCuidados(TiposCuidadosViewModel:any):Observable<any>{
        let params = JSON.stringify(TiposCuidadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "TiposCuidados/Update", params, { headers: headers });
    }

    DeleteTiposCuidados(TiposCuidadosViewModel: any): Observable<Response> {
        let params = JSON.stringify(TiposCuidadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `TiposCuidados/Delete`, params, { headers: headers });
    }

   
}
