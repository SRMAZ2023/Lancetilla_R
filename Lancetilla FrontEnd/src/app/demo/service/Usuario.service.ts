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

   
   

   
}
