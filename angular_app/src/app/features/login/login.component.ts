import { Component } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../auth';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  login_form = new FormGroup({
    email: new FormControl('', [Validators.required, Validators.email]),
    password: new FormControl('', [Validators.required])
  });

  error?: string;

  constructor(
    private router: Router,
    private authService: AuthService) { }

  onSubmit() {
    if (!this.login_form.valid) {
      return;
    }

    delete this.error;

    const { email, password } = this.login_form.value;
    this.authService.login(email!, password!)
      .then(() => {
        this.router.navigate(['/']);
      })
      .catch(err => {
        this.error = err;
      })
  }

}
