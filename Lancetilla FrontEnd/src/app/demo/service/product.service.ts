import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Product, Especies } from '../api/product';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class ProductService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getEspecies(): Observable<any> {
        return this.http.get(this.url + "Especies/ListarEspecies");
    }

    postEspecies(Especies: any): Observable<Response> {

        let params = JSON.stringify(Especies);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + 'Especies/InsertarEspecie', params, { headers: headers });
    }

    EditEspecies(Especies: any): Observable<any> {
        let params = JSON.stringify(Especies);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + "Especies/ActualizarEspecie", params, { headers: headers });
    }

    DeleteEspecies(Especies: any): Observable<Response> {
        let params = JSON.stringify(Especies);
        let headers = new HttpHeaders().set('Content-Type', 'application/json');

        return this.http.post<Response>(this.url + `Especies/EliminarEspecie`, params, { headers: headers });
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    getProductsSmall() {
        return this.http.get<any>('assets/demo/data/products-small.json')
            .toPromise()
            .then(res => res.data as Product[])
            .then(data => data);
    }

    getProducts() {
        return this.http.get<any>('assets/demo/data/products.json')
            .toPromise()
            .then(res => res.data as Product[])
            .then(data => data);
    }

    getProductsMixed() {
        return this.http.get<any>('assets/demo/data/products-mixed.json')
            .toPromise()
            .then(res => res.data as Product[])
            .then(data => data);
    }

    getProductsWithOrdersSmall() {
        return this.http.get<any>('assets/demo/data/products-orders-small.json')
            .toPromise()
            .then(res => res.data as Product[])
            .then(data => data);
    }
}
