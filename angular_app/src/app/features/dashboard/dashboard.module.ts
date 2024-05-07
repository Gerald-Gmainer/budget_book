import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule, RouterLink } from '@angular/router';
import { DashboardComponent } from './containers/dashboard/dashboard.component';
import { EffectsModule } from '@ngrx/effects';
import { StoreModule } from '@ngrx/store';

import { DashboardEffects } from './store/dashboard.effects';
import { reducer } from './store/dashboard.reducer';
import {
  ButtonDirective,
  ButtonGroupComponent,
  CardBodyComponent,
  CardComponent,
  CardFooterComponent,
  CardHeaderComponent,
  ColComponent,
  DropdownComponent,
  DropdownDividerDirective,
  DropdownItemDirective,
  DropdownMenuDirective,
  DropdownToggleDirective,
  GutterDirective,
  ProgressBarDirective,
  ProgressComponent,
  RowComponent,
  TemplateIdDirective,
  ThemeDirective,
  WidgetStatAComponent,
} from '@coreui/angular';
import { ChartjsComponent } from '@coreui/angular-chartjs';
import { IconDirective } from '@coreui/icons-angular';
import { ReactiveFormsModule } from '@angular/forms';

const routes: Routes = [{ path: '', component: DashboardComponent }];

@NgModule({
  declarations: [DashboardComponent],
  imports: [
    CommonModule,
    //
    DropdownComponent,
    RowComponent,
    ColComponent,
    WidgetStatAComponent,
    ChartjsComponent,
    ButtonDirective,
    DropdownDividerDirective,
    DropdownItemDirective,
    DropdownToggleDirective,
    TemplateIdDirective,
    IconDirective,
    ThemeDirective,
    CardHeaderComponent,
    CardFooterComponent,
    CardBodyComponent,
    CardComponent,
    ProgressBarDirective,
    ProgressComponent,
    ButtonGroupComponent,
    GutterDirective,
    ReactiveFormsModule,
    //
    RouterModule.forChild(routes),
    StoreModule.forFeature('dashboard', reducer),
    EffectsModule.forFeature([DashboardEffects]),
  ],
})
export class DashboardModule {}
