import { Component, DestroyRef, Input, computed, inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ColorModeService, HeaderComponent } from '@coreui/angular';
import { delay, map, filter, tap } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { ROUTES } from '@constants/routes';

@Component({
  selector: 'main-header',
  template: `
    <ng-container>
      <c-container [fluid]="true" class="border-bottom px-4">
        <button [cSidebarToggle]="sidebarId" cHeaderToggler class="btn" toggle="visible" style="margin-inline-start: -14px;">
          <svg cIcon name="cilMenu" size="lg"></svg>
        </button>

        <c-header-nav class="d-none d-md-flex">
          <c-nav-item>
            <a cNavLink routerLink="/dashboard" routerLinkActive="active">Dashboard</a>
          </c-nav-item>
          <c-nav-item>
            <a cNavLink routerLink="/accounts" routerLinkActive="active">Accounts</a>
          </c-nav-item>
          <c-nav-item>
            <a cNavLink routerLink="/settings" routerLinkActive="active">Settings</a>
          </c-nav-item>
        </c-header-nav>

        <div class="ms-auto"></div>

        <c-header-nav class="ms-md-0">
          <div class="nav-item py-1">
            <div class="h-100 mx-2 text-body text-opacity-75"></div>
          </div>
          <ng-container *ngTemplateOutlet="themeDropdown" />
          <div class="nav-item py-1">
            <div class="vr h-100 mx-2 text-body text-opacity-75"></div>
          </div>
        </c-header-nav>

        <c-header-nav class="mx-0">
          <ng-container *ngTemplateOutlet="userDropdown" />
        </c-header-nav>
      </c-container>
      <c-container [fluid]="true" class="px-4">
        <c-breadcrumb-router />
      </c-container>
    </ng-container>

    <ng-template #userDropdown>
      <c-dropdown [popperOptions]="{ placement: 'bottom-start' }" variant="nav-item">
        <button [caret]="false" cDropdownToggle class="py-0 pe-0">
          <c-avatar shape="rounded-1" [size]="'sm'" src="./assets/images/avatar_default.png" status="success" textColor="primary" />
        </button>
        <ul cDropdownMenu class="pt-0 w-auto">
          <li>
            <h6 cDropdownHeader class="bg-body-secondary text-body-secondary fw-semibold py-2 rounded-top">Budget Book</h6>
          </li>
          <li>
            <a cDropdownItem routerLink="">
              <svg cIcon class="me-2" name="cilAccountLogout"></svg>
              Categories
            </a>
          </li>
          <li>
            <a cDropdownItem routerLink="">
              <svg cIcon class="me-2" name="cilAccountLogout"></svg>
              Accounts
            </a>
          </li>

          <li>
            <h6 cDropdownHeader class="bg-body-secondary text-body-secondary fw-semibold py-2 rounded-top">Account</h6>
          </li>
          <li>
            <a cDropdownItem routerLink="">
              <svg cIcon class="me-2" name="cilUser"></svg>
              Profile
            </a>
          </li>
          <li>
            <a cDropdownItem routerLink="">
              <svg cIcon class="me-2" name="cilSettings"></svg>
              Settings
            </a>
          </li>

          <li>
            <hr cDropdownDivider />
          </li>
          <li>
            <a cDropdownItem [routerLink]="ROUTES.login">
              <svg cIcon class="me-2" name="cilAccountLogout"></svg>
              Logout
            </a>
          </li>
        </ul>
      </c-dropdown>
    </ng-template>

    <ng-template #themeDropdown>
      <c-dropdown alignment="end" variant="nav-item">
        <button [caret]="false" cDropdownToggle>
          <svg cIcon [name]="icons()" size="lg"></svg>
        </button>
        <div cDropdownMenu>
          @for (mode of colorModes; track mode.name) {
          <button (click)="colorMode.set(mode.name)" [active]="colorMode() === mode.name" [routerLink]="[]" cDropdownItem class="d-flex align-items-center">
            <svg cIcon class="me-2" [name]="mode.icon" size="lg"></svg>
            {{ mode.text }}
          </button>
          }
        </div>
      </c-dropdown>
    </ng-template>
  `,
  styleUrl: './main-header.component.scss',
})
export class MainHeaderComponent extends HeaderComponent {
  readonly #activatedRoute: ActivatedRoute = inject(ActivatedRoute);
  readonly #colorModeService = inject(ColorModeService);
  readonly colorMode = this.#colorModeService.colorMode;
  readonly #destroyRef: DestroyRef = inject(DestroyRef);
  readonly ROUTES = ROUTES;

  readonly colorModes = [
    { name: 'light', text: 'Light', icon: 'cilSun' },
    { name: 'dark', text: 'Dark', icon: 'cilMoon' },
    { name: 'auto', text: 'Auto', icon: 'cilContrast' },
  ];

  readonly icons = computed(() => {
    const currentMode = this.colorMode();
    return this.colorModes.find((mode) => mode.name === currentMode)?.icon ?? 'cilSun';
  });

  constructor() {
    super();
    this.#colorModeService.localStorageItemName.set('coreui-free-angular-admin-template-theme-default');
    this.#colorModeService.eventName.set('ColorSchemeChange');

    this.#activatedRoute.queryParams
      .pipe(
        delay(1),
        map((params) => <string>params['theme']?.match(/^[A-Za-z0-9\s]+/)?.[0]),
        filter((theme) => ['dark', 'light', 'auto'].includes(theme)),
        tap((theme) => {
          this.colorMode.set(theme);
        }),
        takeUntilDestroyed(this.#destroyRef)
      )
      .subscribe();
  }

  @Input() sidebarId: string = 'sidebar1';
}
