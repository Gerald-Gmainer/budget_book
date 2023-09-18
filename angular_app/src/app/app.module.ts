import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './core/app-routing.module';
import { AppComponent } from './core/app.component';

import { SupabaseService } from './shared/service';

import { DashboardComponent } from './features/dashboard/';
import { LoginComponent } from './features/login/';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

@NgModule({
  declarations: [
    AppComponent,
    DashboardComponent,
    LoginComponent
  ],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    BrowserModule,
    AppRoutingModule,
    NgbModule
  ],
  providers: [SupabaseService],
  bootstrap: [AppComponent]
})
export class AppModule { }
