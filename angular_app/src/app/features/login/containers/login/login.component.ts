import { Component, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { ROUTES } from '@constants/routes';
import { take } from 'rxjs';
import { AuthService } from 'src/app/core/auth/services/auth.service';

@Component({
  selector: 'app-login',
  template: ` <app-login-view (formSubmit)="onFormSubmit($event)"></app-login-view> `,
  styleUrl: './login.component.scss',
})
export class LoginComponent {
  constructor(private authService: AuthService, private router: Router) {}

  onFormSubmit(credentials: { username: string; password: string }): void {
    this.authService
      .login(credentials.username, credentials.password)
      .pipe(take(1))
      .subscribe((user) => {
        if (user) {
          this.router.navigate([ROUTES.dashboard]);
        } else {
          console.error('Login failed.');
        }
      });
  }
}
