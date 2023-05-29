import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { EstadoCivilViewModel } from '../Models/EstadoCivilViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class FacturaService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getFacs(): Observable<any> {
        return this.http.get(this.url + "Facturas/ListarFacturas");
    }

  
   
}
