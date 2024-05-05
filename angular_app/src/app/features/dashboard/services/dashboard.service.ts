import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class DashboardService {
  constructor(private http: HttpClient) {}

  getDashboardData(): Observable<any> {
    // return this.http.get<any>('api/dashboard');
    return of("it works asdf");
  }
}
