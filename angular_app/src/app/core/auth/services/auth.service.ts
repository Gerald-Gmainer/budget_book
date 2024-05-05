import { Injectable } from '@angular/core';
import { BehaviorSubject, catchError, first, from, map, Observable, skipWhile, switchMap } from 'rxjs';
import { AuthError, AuthTokenResponsePassword, User } from '@supabase/supabase-js';
import { SupabaseService } from '@core/supabase/services/supabase.service';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private _$user = new BehaviorSubject<User | null | undefined>(undefined);
  $user = this._$user as Observable<User | null>;
  private previousUserId: string | null = null;

  constructor(private supabaseService: SupabaseService) {
    this.observeSupabaseAuth();
  }

  observeSupabaseAuth() {
    this.supabaseService.auth.getUser().then(({ data, error }) => this.updateUser(data && data.user && !error ? data.user : null));
    this.supabaseService.auth.onAuthStateChange((event, session) => this.updateUser(session?.user ?? null));
  }

  private updateUser(user: User | null): void {
    const currentUserId = user?.id ?? null;
    if (currentUserId !== this.previousUserId) {
      this._$user.next(user);
    }
    this.previousUserId = currentUserId;
  }

  login(email: string, password: string): Observable<User | null> {
    return from(this.supabaseService.client.auth.signInWithPassword({ email, password })).pipe(
      map((response: AuthTokenResponsePassword) => response.data.user),
      catchError((error) => {
        console.error(error);
        throw error;
      })
    );
  }

  logout(): Promise<{ error: AuthError | null }> {
    return this.supabaseService.auth.signOut();
  }
}
