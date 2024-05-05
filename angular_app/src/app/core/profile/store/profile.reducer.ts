import { createReducer, on, Action } from '@ngrx/store';
import * as ProfileActions from './profile.actions';
import { ProfileState, initialState } from './profile.state';

const profileReducer = createReducer(
  initialState,
  on(ProfileActions.loadProfile, (state) => ({
    ...state,
    loading: true,
    error: null,
  })),
  on(ProfileActions.loadProfileSuccess, (state, { profile }) => ({
    ...state,
    profile,
    loading: false,
    error: null,
  })),
  on(ProfileActions.loadProfileFailure, (state, { error }) => ({
    ...state,
    loading: false,
    error,
  })),
  on(ProfileActions.removeProfile, (state) => ({
    ...state,
    profile: null,
    loading: false,
    error: null,
  }))
);

export function reducer(state: ProfileState | undefined, action: Action): ProfileState {
  return profileReducer(state, action);
}
