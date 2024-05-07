import { createReducer, on, Action } from '@ngrx/store';
import { initialState, ReportGraphState } from './report-graph.state';
import { loadDashboard, loadDashboardSuccess, loadDashboardFailure } from '@features/dashboard/store/dashboard.actions';

const reportGraphReducer = createReducer(
  initialState,
  on(loadDashboard, (state) => ({
    ...state,
    loading: true,
    error: undefined,
  })),
  on(loadDashboardSuccess, (state, { data }) => ({
    ...state,
    data,
    loading: false,
    error: undefined,
  })),
  on(loadDashboardFailure, (state, { error }) => ({
    ...state,
    loading: false,
    error: error
  }))
);

export function reducer(state: ReportGraphState | undefined, action: Action) {
  return reportGraphReducer(state, action);
}
