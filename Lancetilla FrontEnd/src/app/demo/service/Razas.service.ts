import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from "rxjs"
import { Global } from './Global';

@Injectable()
export class RazasService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getRazas(): Observable<any> {
        return this.http.get(this.url + "Razas/ListarRazas");
    }

    postRazas(RazasViewModel: any): Observable<Response> {

        let params = JSON.stringify(RazasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Razas/InsertarRazas', params, { headers: headers });

    }

    GetAnimalesXRaza(RazasViewModel: any): Observable<Response> {
        let params = JSON.stringify(RazasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Animales/BuscarAnimal`, params, { headers: headers });
    }

    EditRazas(RazasViewModel:any):Observable<any>{
        let params = JSON.stringify(RazasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Razas/ActualizarRazas", params, { headers: headers });
    }

    DeleteRazas(RazasViewModel: any): Observable<Response> {
        let params = JSON.stringify(RazasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Razas/EliminarRazas`, params, { headers: headers });
    }

   
}
