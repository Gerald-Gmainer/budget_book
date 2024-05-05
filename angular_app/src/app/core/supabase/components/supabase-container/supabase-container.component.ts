import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthService } from '@core/auth/services/auth.service';
import { ProfileState } from '@core/profile/store/profile.state';
import { Store } from '@ngrx/store';
import { Subscription, filter, first, startWith, tap, withLatestFrom } from 'rxjs';
import * as ProfileActions from '@core/profile/store/profile.actions';
import { NavigationEnd, Router } from '@angular/router';

@Component({
  selector: 'supabase-container',
  template: ` <ng-content /> `,
  styleUrl: './supabase-container.component.scss',
})
export class SupabaseContainerComponent implements OnInit, OnDestroy {
  private sub: Subscription | undefined;

  constructor(private authService: AuthService, private store: Store<ProfileState>, private router: Router) {}

  ngOnInit(): void {
    this.router.events
      .pipe(
        filter((event) => event instanceof NavigationEnd),
        tap(() => this.checkAuthUrl())
      )
      .subscribe();
  }

  private async checkAuthUrl(): Promise<void> {
    const currentUrl = this.router.url;

    if (currentUrl.includes('auth')) {
      await this.authService.logout();
    }
    if (this.sub === undefined) {
      this.observeUser();
    }
  }

  private observeUser(): void {
    this.sub = this.authService.$user
      .pipe(
        tap((user) => {
          if (user) {
            this.store.dispatch(ProfileActions.loadProfile());
          } else {
            this.store.dispatch(ProfileActions.removeProfile());
          }
        })
      )
      .subscribe();
  }

  ngOnDestroy(): void {
    this.sub?.unsubscribe();
  }
}
