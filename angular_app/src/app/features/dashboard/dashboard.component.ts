import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../auth';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent {
  constructor(
    public authService: AuthService,
    private router: Router) { }

  logout() {
    this.authService.logout().then(() => {
      this.router.navigate(['/login']);
    })
  }

}
