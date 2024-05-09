import { NgModule } from '@angular/core';
import { CommonModule, NgStyle, NgTemplateOutlet } from '@angular/common';
import { RouterLink, RouterLinkActive, RouterModule } from '@angular/router';
import { MainLayoutComponent } from './layouts/main/main-layout.component';
import { UnauthorizedLayoutComponent } from './layouts/unauthorized/unauthorized-layout.component';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { SupabaseContainerComponent } from './supabase/components/supabase-container/supabase-container.component';
import {
  AvatarComponent,
  BadgeComponent,
  BreadcrumbModule,
  BreadcrumbRouterComponent,
  ContainerComponent,
  DropdownComponent,
  DropdownDividerDirective,
  DropdownHeaderDirective,
  DropdownItemDirective,
  DropdownMenuDirective,
  DropdownToggleDirective,
  HeaderNavComponent,
  HeaderTogglerDirective,
  NavItemComponent,
  NavLinkDirective,
  ProgressBarDirective,
  ProgressComponent,
  ShadowOnScrollDirective,
  SidebarBrandComponent,
  SidebarComponent,
  SidebarFooterComponent,
  SidebarHeaderComponent,
  SidebarNavComponent,
  SidebarToggleDirective,
  SidebarTogglerDirective,
  TextColorDirective,
  ThemeDirective,
} from '@coreui/angular';
import { NgScrollbar } from 'ngx-scrollbar';
import { MainFooterComponent } from './layouts/main/main-footer/main-footer.component';
import { MainSidebarComponent } from './layouts/main/main-sidebar/main-sidebar.component';
import { MainHeaderComponent } from './layouts/main/main-header/main-header.component';
import { IconDirective } from '@coreui/icons-angular';

@NgModule({
  declarations: [MainLayoutComponent, UnauthorizedLayoutComponent, SupabaseContainerComponent, MainFooterComponent, MainSidebarComponent, MainHeaderComponent],
  imports: [
    CommonModule,
    RouterModule,
    MatProgressSpinnerModule,
    SidebarComponent,
    SidebarHeaderComponent,
    SidebarBrandComponent,
    NgScrollbar,
    SidebarNavComponent,
    SidebarFooterComponent,
    SidebarToggleDirective,
    SidebarTogglerDirective,
    ShadowOnScrollDirective,
    ContainerComponent,
    HeaderTogglerDirective,
    SidebarToggleDirective,
    IconDirective,
    HeaderNavComponent,
    NavItemComponent,
    NavLinkDirective,
    RouterLink,
    RouterLinkActive,
    NgTemplateOutlet,
    BreadcrumbModule,
    BreadcrumbRouterComponent,
    ThemeDirective,
    DropdownComponent,
    DropdownToggleDirective,
    TextColorDirective,
    AvatarComponent,
    DropdownMenuDirective,
    DropdownHeaderDirective,
    DropdownItemDirective,
    BadgeComponent,
    DropdownDividerDirective,
    ProgressBarDirective,
    ProgressComponent,
    NgStyle,
  ],
  exports: [MainLayoutComponent, UnauthorizedLayoutComponent, SupabaseContainerComponent],
})
export class CoreModule {}
