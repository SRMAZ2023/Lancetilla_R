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

    EditEmpleados(EmpleadosViewModel:any):Observable<any>{
        let params = JSON.stringify(EmpleadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Empleados/ActualizarEmpleados", params, { headers: headers });
    }

    DeleteEmpleados(EmpleadosViewModel: any): Observable<Response> {
        let params = JSON.stringify(EmpleadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Empleados/EliminarEmpleados`, params, { headers: headers });
    }

   
}
