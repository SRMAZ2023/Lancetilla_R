import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { PlantasViewModel } from '../Models/PlantasViewModel';
import { Observable } from "rxjs"
import { Global } from './Global';
import { observableToBeFn } from 'rxjs/internal/testing/TestScheduler';

@Injectable()
export class VisitantesService {

    public url: string;

    constructor(private http: HttpClient) {
        this.url = Global.url;
    }

    getVisitantes(): Observable<any> {
        return this.http.get(this.url + "Visitantes/ListarVisitantes");
    }

}
