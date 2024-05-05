import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { Observable } from 'rxjs';
import { loadDashboard } from '../../store/dashboard.actions';
import { selectDashboardData } from '../../store/dashboard.selectors';
import { DashboardState } from '../../store/dashboard.state';
import { AuthService } from '@core/auth/services/auth.service';
import { Router } from '@angular/router';
import { ROUTES } from '@constants/routes';

@Component({
  selector: 'app-dashboard',
  template: `
    <div>hallo</div>
    <div>{{ data$ | async }}</div>
    <button (click)="onClick()">logout</button>
  `,
  styleUrl: './dashboard.component.scss',
})
export class DashboardComponent {
  data$: Observable<any>;

  constructor(private store: Store<DashboardState>, private authService: AuthService, private router: Router) {
    this.data$ = store.pipe(select(selectDashboardData));
  }

  ngOnInit(): void {
    this.store.dispatch(loadDashboard());
  }

  onClick() {
    this.router.navigate([ROUTES.login]);
  }
}
