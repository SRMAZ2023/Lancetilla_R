import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AnimalViewModel } from '../Models/AnimalViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';

@Injectable()
export class AnimalService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getAnimales(): Observable<any> {
        return this.http.get(this.url + "Animales/ListarAnimales");
    }

    findAnimales(anim_Id:any): Observable<any> {
        return this.http.get(this.url + `Animales/BuscarAnimales/${anim_Id}`);

    }

    postAnimales(AnimalViewModel: any): Observable<Response> {

        let params = JSON.stringify(AnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Animales/InsertarAnimales', params, { headers: headers });

    }

    EditAnimales(AnimalViewModel:any):Observable<any>{
        let params = JSON.stringify(AnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Animales/ActualizarAnimales", params, { headers: headers });
    }

    DeleteAnimales(AnimalViewModel: any): Observable<Response> {
        let params = JSON.stringify(AnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Animales/EliminarAnimales`, params, { headers: headers });
    }

   
}
