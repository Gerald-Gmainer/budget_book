import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { DashboardComponent } from './containers/dashboard/dashboard.component';
import { EffectsModule } from '@ngrx/effects';
import { StoreModule } from '@ngrx/store';

import { DashboardEffects } from './store/dashboard.effects';
import { reducer } from './store/dashboard.reducer';

const routes: Routes = [{ path: '', component: DashboardComponent }];

@NgModule({
  declarations: [DashboardComponent],
  imports: [CommonModule, RouterModule.forChild(routes), StoreModule.forFeature('dashboard', reducer), EffectsModule.forFeature([DashboardEffects])],
})
export class DashboardModule {}
