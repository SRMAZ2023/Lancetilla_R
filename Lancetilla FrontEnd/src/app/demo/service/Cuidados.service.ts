import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
 import { Observable } from "rxjs"
import { Global } from './Global';
@Injectable()
export class CuidadosService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getCuidados(): Observable<any> {
        return this.http.get(this.url + "Cuidados/List");
    }

    postCuidados(CuidadosViewModel: any): Observable<Response> {

        let params = JSON.stringify(CuidadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Cuidados/Insert', params, { headers: headers });

    }

    EditCuidados(CuidadosViewModel:any):Observable<any>{
        let params = JSON.stringify(CuidadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Cuidados/Update", params, { headers: headers });
    }

    DeleteCuidados(CuidadosViewModel: any): Observable<Response> {
        let params = JSON.stringify(CuidadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Cuidados/Delte`, params, { headers: headers });
    }

   
}
