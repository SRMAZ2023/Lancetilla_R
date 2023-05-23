import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from "rxjs"
import { Global } from './Global';

@Injectable()
export class HabitatService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getHabitat(): Observable<any> {
        return this.http.get(this.url + "Habitat/ListarHabitat");
    }

    postHabitat(HabitatViewModel: any): Observable<Response> {

        let params = JSON.stringify(HabitatViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Habitat/InsertarHabitat', params, { headers: headers });

    }

    EditHabitat(HabitatViewModel:any):Observable<any>{
        let params = JSON.stringify(HabitatViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Habitat/ActualizarHabitat", params, { headers: headers });
    }

    DeleteHabitat(HabitatViewModel: any): Observable<Response> {
        let params = JSON.stringify(HabitatViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Habitat/EliminarHabitat`, params, { headers: headers });
    }

   
}
