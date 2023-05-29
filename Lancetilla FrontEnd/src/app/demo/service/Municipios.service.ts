import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { MunicipiosViewModel } from '../Models/MunicipiosViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class MunicipiosService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }
 
    ListarMunicipios(): Observable<any> {
        return this.http.get(this.url + "Municipios/ListarMunicipios");
    }

    ListarDepartamentos(): Observable<any> {
        return this.http.get(this.url + "Departamento/ListarDepartamentos");
    }

  
  
    
    CrearMunicipio(MunicipiosViewModel: any): Observable<Response> {

        console.log(MunicipiosViewModel);
        let params = JSON.stringify(MunicipiosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Municipios/InsertMunicipio', params, { headers: headers });

    }

    EditarMunicipio(MunicipiosViewModel:any):Observable<any>{
        let params = JSON.stringify(MunicipiosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Municipios/ActualizarMunicipio", params, { headers: headers });
    }

    EliminarMunicipio(MunicipiosViewModel: any): Observable<Response> {
        let params = JSON.stringify(MunicipiosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Municipios/EliminarMunicipio`, params, { headers: headers });
    }

   
   

   
}
