import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { first, map, Observable } from 'rxjs';
import { AuthService } from '../auth/services/auth.service';
import { ROUTES } from '@constants/routes';

@Injectable({
  providedIn: 'root',
})
export class AuthGuard {
  constructor(private router: Router, private authService: AuthService) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    return this.authService.$user.pipe(
      first(),
      map((user) => {
        if (user) return true;
        else {
          console.log('AuthGuard: not logged in -> forward to login');
          this.router.navigate([ROUTES.login], {
            queryParams: { redirect_url: state.url },
          });
          return false;
        }
      })
    );
  }
}
