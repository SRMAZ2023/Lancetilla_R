import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { UsuarioViewModel } from '../Models/UsuarioViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class UsuarioService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }
 

    Login(UsuarioViewModel: any): Observable<Response> {

        let params = JSON.stringify(UsuarioViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Usuarios/ValidarLogin', params, { headers: headers });

    }

    ListarUsuario(): Observable<any> {
        return this.http.get(this.url + "Usuarios/ListarUsuarios");
    }


    ListarEmpleados(): Observable<any> {
        return this.http.get(this.url + "Usuarios/ListarEmpleadoNoTieneUser");
    }

    ListarRoles(): Observable<any> {
        return this.http.get(this.url + "Usuarios/ListarEmpleadoNoTieneUser");
    }
    
    CrearUsuario(UsuarioViewModel: any): Observable<Response> {

        let params = JSON.stringify(UsuarioViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Usuarios/InsertarUsuario', params, { headers: headers });

    }

    EditarUsuario(UsuarioViewModel:any):Observable<any>{
        let params = JSON.stringify(UsuarioViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Usuarios/ActualizarUsuario", params, { headers: headers });
    }

    EliminarUsuario(UsuarioViewModel: any): Observable<Response> {
        let params = JSON.stringify(UsuarioViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Usuarios/EliminarUsuario`, params, { headers: headers });
    }

   
   

   
}
