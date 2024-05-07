import { createAction, props } from '@ngrx/store';

export const loadReportGraph = createAction('[ReportGraph] Load Report Graph');
export const loadReportGraphSuccess = createAction('[ReportGraph] Report Graph Success', props<{ data: any }>());
export const loadReportGraphFailure = createAction('[ReportGraph] Report Graph Failure', props<{ error: string }>());
