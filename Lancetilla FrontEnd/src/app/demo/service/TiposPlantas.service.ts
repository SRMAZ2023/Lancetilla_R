import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from "rxjs"
import { Global } from './Global';
import { TiposPlantasViewModel } from '../Models/TiposPlantasViewModel';

@Injectable()
export class TiposPlantasService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getTiposPlantas(): Observable<any> {
        return this.http.get(this.url + "TiposdePlantas/ListarTiposPlantas");
    }

    postTiposPlantas(TiposPlantasViewModel: any): Observable<Response> {

        let params = JSON.stringify(TiposPlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'TiposdePlantas/InsertarTiposPlantas', params, { headers: headers });

    }

    GetPlantasPorTipo(PlantasViewModel: any): Observable<Response> {
        let params = JSON.stringify(PlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `TiposdePlantas/BuscarPlantasPorTipo`, params, { headers: headers });
    }

    EditTiposPlantas(TiposPlantasViewModel:any):Observable<any>{
        let params = JSON.stringify(TiposPlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "TiposdePlantas/ActualizarTiposPlantas", params, { headers: headers });
    }

    DeleteTiposPlantas(TiposPlantasViewModel: any): Observable<Response> {
        let params = JSON.stringify(TiposPlantasViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `TiposdePlantas/EliminarTiposPlantas`, params, { headers: headers });
    }

   
}
