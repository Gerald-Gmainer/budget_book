import { Injectable } from '@angular/core';
import { Actions, ofType, createEffect } from '@ngrx/effects';
import { of } from 'rxjs';
import { catchError, map, switchMap } from 'rxjs/operators';
import * as ProfileActions from './profile.actions';
import { ProfileService } from '../services/profile.service';

@Injectable()
export class ProfileEffects {
  loadProfile$ = createEffect(() =>
    this.actions$.pipe(
      ofType(ProfileActions.loadProfile),
      switchMap(() =>
        this.profileService.loadProfile().pipe(
          map((profile) => {
            if (!profile) {
              throw 'Profile not found';
            }
            return ProfileActions.loadProfileSuccess({ profile });
          }),
          catchError((error) => of(ProfileActions.loadProfileFailure({ error })))
        )
      )
    )
  );

  constructor(private actions$: Actions, private profileService: ProfileService) {}
}
