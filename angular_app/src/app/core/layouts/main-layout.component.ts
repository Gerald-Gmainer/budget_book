import { Component } from '@angular/core';
import { selectProfileLoading } from '@core/profile/store/profile.selectors';
import { ProfileState } from '@core/profile/store/profile.state';
import { Store } from '@ngrx/store';
import { Observable, tap } from 'rxjs';
import * as ProfileActions from '../profile/store/profile.actions';
import { AuthService } from '@core/auth/services/auth.service';

@Component({
  selector: 'app-main-layout',
  template: `
    <ng-container *ngIf="!(profileLoading$ | async)">
      <router-outlet></router-outlet>
    </ng-container>

    <div class="loading" *ngIf="profileLoading$ | async">
      <mat-progress-spinner diameter="50" mode="indeterminate"></mat-progress-spinner>
    </div>
  `,
})
export class MainLayoutComponent {
  profileLoading$: Observable<boolean>;

  constructor(private store: Store<ProfileState>, private authService: AuthService) {
    this.profileLoading$ = this.store.select(selectProfileLoading);
  }
}
