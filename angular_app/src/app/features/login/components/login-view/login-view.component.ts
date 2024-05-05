import { Component, EventEmitter, Output } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-login-view',
  template: `
    <div class="login-container">
      <mat-card>
        <mat-card-header>
          <mat-card-title>Login</mat-card-title>
        </mat-card-header>

        <mat-card-content>
          <form [formGroup]="loginForm" (ngSubmit)="onSubmit()">
            <mat-form-field appearance="fill">
              <mat-label>Username</mat-label>
              <input matInput formControlName="username" placeholder="Enter your username" required />
            </mat-form-field>

            <mat-form-field appearance="fill">
              <mat-label>Password</mat-label>
              <input matInput formControlName="password" type="password" placeholder="Enter your password" required />
            </mat-form-field>

            <button mat-raised-button color="primary" type="submit" [disabled]="loginForm.invalid">Login</button>
          </form>
        </mat-card-content>
      </mat-card>
    </div>
  `,
  styleUrl: './login-view.component.scss',
})
export class LoginViewComponent {
  @Output() formSubmit: EventEmitter<{ username: string; password: string }> = new EventEmitter();

  loginForm: FormGroup;

  constructor(private formBuilder: FormBuilder) {
    this.loginForm = this.formBuilder.group({
      username: ['gerald_gmainer@designium.jp', Validators.required],
      password: ['aaaaaaA1', Validators.required],
    });
  }

  onSubmit(): void {
    if (this.loginForm.invalid) {
      return;
    }

    const { username, password } = this.loginForm.value;
    this.formSubmit.emit({ username, password });
  }
}
