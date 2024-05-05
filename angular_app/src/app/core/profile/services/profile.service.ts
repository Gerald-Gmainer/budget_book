import { Injectable } from '@angular/core';
import { SupabaseService } from '@core/supabase/services/supabase.service';
import { Observable, delay, from } from 'rxjs';
import { Profile } from '../models/profile.interface';

@Injectable({
  providedIn: 'root',
})
export class ProfileService {
  constructor(private supabaseService: SupabaseService) {}

  loadProfile(): Observable<Profile | null> {
    return from(
      this.supabaseService.client
        .from('view_profiles')
        .select('id, name, email, avatar_url, currency_id, currency')
        .limit(1)
        .single()
        .then((res) => this.mapProfile(res))
    ).pipe(delay(200));
  }

  private mapProfile(data: any): Profile {
    return {
      name: data.name,
      avatarUrl: data.avatar_url,
    } as Profile;
  }
}
