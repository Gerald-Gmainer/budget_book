import { createAction, props } from '@ngrx/store';

export const loadDashboard = createAction('[Dashboard] Load Dashboard');
export const loadDashboardSuccess = createAction('[Dashboard] Dashboard Success', props<{ data: any }>());
export const loadDashboardFailure = createAction('[Dashboard] Dashboard Failure', props<{ error: string }>());
