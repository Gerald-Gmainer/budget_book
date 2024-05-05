import { createReducer, on, Action } from '@ngrx/store';
import { initialState, DashboardState } from './dashboard.state';
import { loadDashboard, loadDashboardSuccess, loadDashboardFailure } from './dashboard.actions';


const dashboardReducer = createReducer(
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

export function reducer(state: DashboardState | undefined, action: Action) {
  return dashboardReducer(state, action);
}
