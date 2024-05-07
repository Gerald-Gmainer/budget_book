export interface ReportGraphState {
  data: any;
  loading: boolean;
  error?: string;
}

export const initialState: ReportGraphState = {
  data: null,
  loading: false,
  error: undefined,
};
