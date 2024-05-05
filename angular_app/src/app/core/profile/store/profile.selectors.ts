import { createSelector, createFeatureSelector } from '@ngrx/store';
import { ProfileState } from './profile.state';

export const selectProfileState = createFeatureSelector<ProfileState>('profile');

export const selectProfile = createSelector(selectProfileState, (state: ProfileState) => state.profile);
export const selectProfileLoading = createSelector(selectProfileState, (state: ProfileState) => state.loading);
export const selectProfileError = createSelector(selectProfileState, (state: ProfileState) => state.error);
