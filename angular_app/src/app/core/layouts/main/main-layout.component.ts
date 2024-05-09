import { Component } from '@angular/core';
import { selectProfileLoading } from '@core/profile/store/profile.selectors';
import { ProfileState } from '@core/profile/store/profile.state';
import { Store } from '@ngrx/store';
import { Observable, tap } from 'rxjs';
import { AuthService } from '@core/auth/services/auth.service';

@Component({
  selector: 'app-main-layout',
  template: `
    <!--sidebar-->
    <c-sidebar #sidebar1="cSidebar" class="d-print-none sidebar sidebar-fixed border-end" colorScheme="dark" id="sidebar1" visible>
      <c-sidebar-header class="border-bottom">
        <c-sidebar-brand [routerLink]="[]">
          <svg [class]="{ icon: false }" cIcon class="sidebar-brand-full" height="32" name="logo" title="CoreUI Logo"></svg>
          <svg cIcon class="sidebar-brand-narrow" height="32" name="signet" title="CoreUI Logo"></svg>
        </c-sidebar-brand>
      </c-sidebar-header>

      <ng-scrollbar #scrollbar="ngScrollbar" class="overflow" pointerEventsMethod="scrollbar" visibility="hover">
        <main-sidebar />
      </ng-scrollbar>
      
      @if (!sidebar1.narrow) {
      <c-sidebar-footer cSidebarToggle="sidebar1" class="border-top d-none d-lg-flex" toggle="unfoldable" style="cursor: pointer;">
        <button cSidebarToggler></button>
      </c-sidebar-footer>
      }
    </c-sidebar>

    <!--main-->
    <div class="wrapper d-flex flex-column min-vh-100">
      <!--main-header-->
      <main-header [cShadowOnScroll]="'sm'" class="mb-4 d-print-none header header-sticky p-0 shadow-sm" position="sticky" sidebarId="sidebar1" />

      <!--app-body-->
      <div class="body flex-grow-1">
        <!-- <c-container breakpoint="lg" class="h-auto px-4"> -->
        <c-container class="h-auto px-4" fluid>
          <ng-container *ngIf="!(profileLoading$ | async)">
            <router-outlet></router-outlet>
          </ng-container>

          <div class="loading" *ngIf="profileLoading$ | async">
            <mat-progress-spinner diameter="50" mode="indeterminate"></mat-progress-spinner>
          </div>
        </c-container>
      </div>

      <!--main footer-->
      <main-footer />
    </div>
  `,
  styleUrl: 'main-layout.component.scss',
})
export class MainLayoutComponent {
  profileLoading$: Observable<boolean>;

  constructor(private store: Store<ProfileState>, private authService: AuthService) {
    this.profileLoading$ = this.store.select(selectProfileLoading);
  }
}
