import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { RolesViewModel } from '../Models/RolesPorPantallaViewModel';
import { RolesPorPantallaViewModel } from '../Models/RolesPorPantallaViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';


@Injectable()
export class RolesPorPantallaService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    Roles(): Observable<any> {
        return this.http.get(this.url + "Roles/ListarRoles");
    }

   
    PantallasPorRol(RolesPorPantallaViewModel: any): Observable<Response> {

        let params = JSON.stringify(RolesPorPantallaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'RolesPorPantalla/PantallasPorRol', params, { headers: headers });

    }

    PantallasSinRol(RolesPorPantallaViewModel: any): Observable<Response> {

        let params = JSON.stringify(RolesPorPantallaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'RolesPorPantalla/PantallasSinRol', params, { headers: headers });

    }


    CrearRoles(RolesViewModel:any):Observable<any>{
        let params = JSON.stringify(RolesViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Roles/InsertarRol", params, { headers: headers });
    }

    EditarRoles(RolesViewModel:any):Observable<any>{
        let params = JSON.stringify(RolesViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Roles/ActualizarRol", params, { headers: headers });
    }

    EliminarRoles(RolesViewModel:any):Observable<any>{
        let params = JSON.stringify(RolesViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Roles/EliminarRol", params, { headers: headers });
    }

    AgregarPantallas(RolesPorPantallaViewModel: any): Observable<Response> {
        let params = JSON.stringify(RolesPorPantallaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `RolesPorPantalla/InsertarRolPorPantalla`, params, { headers: headers });
    }

    EliminarPantallas(RolesPorPantallaViewModel: any): Observable<Response> {
        let params = JSON.stringify(RolesPorPantallaViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `RolesPorPantalla/EliminarRolPorPantalla`, params, { headers: headers });
    }

   
}
