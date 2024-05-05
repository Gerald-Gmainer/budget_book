import { Profile } from '../models/profile.interface';
import { createAction, props } from '@ngrx/store';

export const loadProfile = createAction('[Profile] Load Profile');
export const loadProfileSuccess = createAction('[Profile] Load Profile Success', props<{ profile: Profile }>());
export const loadProfileFailure = createAction('[Profile] Load Profile Failure', props<{ error: Error }>());
export const removeProfile = createAction('[Profile] Remove Profile');

