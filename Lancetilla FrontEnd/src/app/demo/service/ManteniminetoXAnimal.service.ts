import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ManteniminetoXAnimalViewModel } from '../Models/ManteniminetoXAnimalViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class ManteniminetoXAnimalService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getManteniminetoXAnimal(): Observable<any> {
        return this.http.get(this.url + "MantenimientoPorAnimal/ListarMantenimientosAnimal");
    }

    getAnimal(): Observable<any> {
        return this.http.get(this.url + "Animales/ListarAnimales");
    }

    
    GetMantenimientoInsert(ManteniminetoXAnimalViewModel: any): Observable<Response> {
        let params = JSON.stringify(ManteniminetoXAnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `MantenimientoPorAnimal/ListarMantenimientosAnimalInsetar`, params, { headers: headers });
    }

    GetAnimalesXMantenimineto(ManteniminetoXAnimalViewModel: any): Observable<Response> {
        let params = JSON.stringify(ManteniminetoXAnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `MantenimientoPorAnimal/Buscar`, params, { headers: headers });
    }

    findManteniminetoXAnimal(plan_id:any): Observable<any> {
        return this.http.get(this.url + `MantenimientoPorAnimal/BuscarPlanta/${plan_id}`);

    }

    postManteniminetoXAnimal(ManteniminetoXAnimalViewModel: any): Observable<Response> {

        let params = JSON.stringify(ManteniminetoXAnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'MantenimientoPorAnimal/InsertMantenimientoAnimal', params, { headers: headers });

    }

    EditManteniminetoXAnimal(ManteniminetoXAnimalViewModel:any):Observable<any>{
        let params = JSON.stringify(ManteniminetoXAnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "MantenimientoPorAnimal/ActualizarPlanta", params, { headers: headers });
    }

    DeleteManteniminetoXAnimal(ManteniminetoXAnimalViewModel: any): Observable<Response> {
        let params = JSON.stringify(ManteniminetoXAnimalViewModel);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `MantenimientoPorAnimal/EliminarMantenimientoAnimal`, params, { headers: headers });
    }

   
}
