import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { EmpleadosViewModel } from '../Models/EmpleadosViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class EmpleadosService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getEmpleados(): Observable<any> {
        return this.http.get(this.url + "Empleados/ListarEmpleados");
    }

    findEmpleados(empl_Id:any): Observable<any> {
        return this.http.get(this.url + `Empleados/BuscarEmpleados/${empl_Id}`);

    }

    postEmpleados(EmpleadosViewModel: any): Observable<Response> {

        let params = JSON.stringify(EmpleadosViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Empleados/InsertEmpleados', params, { headers: headers });

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
