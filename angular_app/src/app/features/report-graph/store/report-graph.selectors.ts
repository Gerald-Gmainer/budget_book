import { createFeatureSelector, createSelector } from '@ngrx/store';
import { ReportGraphState } from './report-graph.state';

export const selectDashboardState = createFeatureSelector<ReportGraphState>('report-graph');

export const selectDashboardData = createSelector(selectDashboardState, (state: ReportGraphState) => state.data);
