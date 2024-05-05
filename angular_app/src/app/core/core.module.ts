import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MainLayoutComponent } from './layouts/main-layout.component';
import { UnauthorizedLayoutComponent } from './layouts/unauthorized-layout.component';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { SupabaseContainerComponent } from './supabase/components/supabase-container/supabase-container.component';

@NgModule({
  declarations: [MainLayoutComponent, UnauthorizedLayoutComponent, SupabaseContainerComponent],
  imports: [CommonModule, RouterModule, MatProgressSpinnerModule],
  exports: [MainLayoutComponent, UnauthorizedLayoutComponent, SupabaseContainerComponent],
})
export class CoreModule {}
