import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ROUTES } from '@constants/routes';
import { AuthGuard } from '@core/guards/auth.guard';
import { MainLayoutComponent } from '@core/layouts/main/main-layout.component';
import { UnauthorizedLayoutComponent } from '@core/layouts/unauthorized/unauthorized-layout.component';

const routes: Routes = [
  {
    path: '',
    component: MainLayoutComponent,
    canActivate: [AuthGuard],
    children: [{ path: ROUTES.dashboard, loadChildren: () => import('./features/dashboard/dashboard.module').then((m) => m.DashboardModule) }],
  },
  {
    path: 'auth',
    component: UnauthorizedLayoutComponent,
    children: [{ path: 'login', loadChildren: () => import('./features/login/login.module').then((m) => m.LoginModule) }],
  },
  // { path: '**', redirectTo: ROUTES.dashboard },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
