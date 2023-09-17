import { Injectable } from '@angular/core';
import { SupabaseService } from 'app/shared/service';
import { BehaviorSubject, first, Observable, skipWhile } from 'rxjs';
import { User } from '@supabase/supabase-js';
import { Profile } from 'app/shared/models';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private _$user = new BehaviorSubject<User | null | undefined>(undefined);
  $user = this._$user.pipe(skipWhile(_ => typeof _ === 'undefined')) as Observable<User | null>;
  private user_id?: string;

  private _$profile = new BehaviorSubject<Profile | null | undefined>(undefined);
  $profile = this._$profile.pipe(skipWhile(_ => typeof _ === 'undefined')) as Observable<Profile | null>;

  constructor(private supabaseService: SupabaseService) {
    this._observeSupabaseAuth();
    this._subscribeToUser();
  }

  private _observeSupabaseAuth() {
    this.supabaseService.client.auth.getUser().then(({ data, error }) => {
      this._$user.next(data && data.user && !error ? data.user : null);

      this.supabaseService.client.auth.onAuthStateChange((event, session) => {
        this._$user.next(session?.user ?? null);
      });
    });
  }

  private _subscribeToUser() {
    this.$user.subscribe(user => {
      if (user) {
        if (user.id !== this.user_id) {
          const user_id = user.id;
          this.user_id = user_id;

          this.supabaseService
            .client
            .from('profiles')
            .select('*')
            .match({ user_id })
            .single()
            .then(res => {
              this._$profile.next(res.data ?? null);
            })
        }
      }
      else {
        this._$profile.next(null);
        delete this.user_id;
      }
    })
  }

  login(email: string, password: string) {
    return new Promise<void>((resolve, reject) => {
      this._$profile.next(undefined);

      this.supabaseService.client.auth.signInWithPassword({ email, password })
        .then(({ data, error }) => {
          if (error || !data) reject('Invalid email/password combination');

          this.$profile.pipe(first()).subscribe(() => {
            resolve();
          });
        })
    })
  }

  logout() {
    return this.supabaseService.client.auth.signOut()
  }
}
