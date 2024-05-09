import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule, RouterLink } from '@angular/router';
import { EffectsModule } from '@ngrx/effects';
import { StoreModule } from '@ngrx/store';

import { ReportGraphEffects } from './store/report-graph.effects';
import { reducer } from './store/report-graph.reducer';
import { ReactiveFormsModule } from '@angular/forms';
import { ReportGraphComponent } from './containers/report-graph/report-graph.component';
import {
  CardHeaderComponent,
  CardFooterComponent,
  CardBodyComponent,
  CardComponent,
  ColComponent,
  RowComponent,
  ContainerComponent,
  DropdownComponent,
  DropdownDividerDirective,
  DropdownHeaderDirective,
  DropdownItemDirective,
  DropdownMenuDirective,
  DropdownToggleDirective,
  ButtonDirective,
  ButtonGroupComponent,
  ButtonToolbarComponent,
} from '@coreui/angular';
import { ChartjsComponent } from '@coreui/angular-chartjs';
import { IconDirective } from '@coreui/icons-angular';

const routes: Routes = [{ path: '', component: ReportGraphComponent }];

@NgModule({
  declarations: [ReportGraphComponent],
  imports: [
    CommonModule,
    //
    RowComponent,
    ColComponent,
    CardHeaderComponent,
    CardFooterComponent,
    CardBodyComponent,
    CardComponent,
    ChartjsComponent,
    ContainerComponent,
    ButtonDirective,
    ButtonGroupComponent,
    ButtonToolbarComponent,
    DropdownComponent,
    DropdownDividerDirective,
    DropdownHeaderDirective,
    DropdownItemDirective,
    DropdownMenuDirective,
    DropdownToggleDirective,
    IconDirective,
    //
    RouterModule.forChild(routes),
    StoreModule.forFeature('report-graph', reducer),
    EffectsModule.forFeature([ReportGraphEffects]),
  ],
})
export class ReportGraphModule {}
