export interface DashboardState {
  data: any;
  loading: boolean;
  error?: string;
}

export const initialState: DashboardState = {
  data: null,
  loading: false,
  error: undefined,
};
