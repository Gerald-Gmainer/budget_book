import { Injectable } from '@angular/core';
import { Actions, ofType, createEffect } from '@ngrx/effects';
import { of } from 'rxjs';
import { map, catchError, switchMap } from 'rxjs/operators';
import { DashboardService } from '../services/dashboard.service';
import { loadDashboard, loadDashboardSuccess, loadDashboardFailure } from './dashboard.actions';

@Injectable()
export class DashboardEffects {
  constructor(private actions$: Actions, private dashboardService: DashboardService) {}

  loadDashboardData$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadDashboard),
      switchMap(() =>
        this.dashboardService.getDashboardData().pipe(
          map((data) => loadDashboardSuccess({ data })),
          catchError((error) => of(loadDashboardFailure({ error: error.toString() })))
        )
      )
    )
  );
}
