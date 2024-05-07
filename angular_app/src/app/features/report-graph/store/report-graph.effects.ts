import { Injectable } from '@angular/core';
import { Actions, ofType, createEffect } from '@ngrx/effects';
import { of } from 'rxjs';
import { map, catchError, switchMap } from 'rxjs/operators';
import { loadReportGraph, loadReportGraphSuccess, loadReportGraphFailure } from './report-graph.actions';
import { loadDashboard, loadDashboardSuccess, loadDashboardFailure } from '@features/dashboard/store/dashboard.actions';
import { ReportGraphService } from '../services/report-graph.service';

@Injectable()
export class ReportGraphEffects {
  constructor(private actions$: Actions, private reportGraphService: ReportGraphService) {}

  // loadDashboardData$ = createEffect(() =>
  //   this.actions$.pipe(
  //     ofType(loadDashboard),
  //     switchMap(() =>
  //       this.reportGraphService.getDashboardData().pipe(
  //         map((data) => loadDashboardSuccess({ data })),
  //         catchError((error) => of(loadDashboardFailure({ error: error.toString() })))
  //       )
  //     )
  //   )
  // );
}
