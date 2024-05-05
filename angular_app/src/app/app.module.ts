import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { StoreModule } from '@ngrx/store';
import { StoreDevtoolsModule } from '@ngrx/store-devtools';
import { HttpClientModule } from '@angular/common/http';
import { EffectsModule } from '@ngrx/effects';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { SupabaseService } from '@core/supabase/services/supabase.service';
import { SharedModule } from '@shared/shared.module';
import { reducer as profileReducer } from '@core/profile/store/profile.reducer';
import { ProfileEffects } from '@core/profile/store/profile.effects';
import { CoreModule } from '@core/core.module';

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    CoreModule,

    BrowserAnimationsModule,
    SharedModule,
    StoreModule.forRoot({ profile: profileReducer }),
    EffectsModule.forRoot([ProfileEffects]),
    StoreDevtoolsModule.instrument({
      maxAge: 25,
      logOnly: false,
    }),
  ],
  providers: [SupabaseService, provideAnimationsAsync()],
  bootstrap: [AppComponent],
})
export class AppModule {}
