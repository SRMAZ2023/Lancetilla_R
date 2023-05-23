import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from "rxjs"
import { Global } from './Global';

@Injectable()
export class AreasZoologicasService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getAreasZoologicas(): Observable<any> {
        return this.http.get(this.url + "AreasDeZoologico/ListarAreasDeZoologico");
    }

    postAreasZoologicas(AreasZoologicasViewModel: any): Observable<Response> {

        let params = JSON.stringify(AreasZoologicasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'AreasDeZoologico/InsertarAreasDeZoologico', params, { headers: headers });

    }

    EditAreasZoologicas(AreasZoologicasViewModel:any):Observable<any>{
        let params = JSON.stringify(AreasZoologicasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "AreasDeZoologico/ActualizarAreasDeZoologico", params, { headers: headers });
    }

    DeleteAreasZoologicas(AreasZoologicasViewModel: any): Observable<Response> {
        let params = JSON.stringify(AreasZoologicasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `AreasDeZoologico/EliminarAreasDeZoologico`, params, { headers: headers });
    }

   
}
