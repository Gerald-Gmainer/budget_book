import { Component } from '@angular/core';
import { ROUTES } from '@constants/routes';
import { INavData } from '@coreui/angular';

@Component({
  selector: 'main-sidebar',
  template: ` <c-sidebar-nav #overflow [navItems]="navItems" dropdownMode="close" compact /> `,
  styleUrl: './main-sidebar.component.scss',
})
export class MainSidebarComponent {
  navItems: INavData[] = [
    {
      name: 'Dashboard',
      url: ROUTES.dashboard,
      iconComponent: { name: 'cil-speedometer' },
    },
    {
      name: 'Bookings',
      title: true
    },
    {
      name: 'Bulk Create',
      url: 'bulk-create',
      iconComponent: { name: 'cil-pencil' }
    },

    {
      name: 'Reports',
      title: true
    },
    {
      name: 'Graph',
      url: ROUTES.reportGraph,
      iconComponent: { name: 'cil-chart-pie' }
    },
    {
      name: 'Calendar',
      url: 'calendar',
      iconComponent: { name: 'cil-calendar' }
    },
    {
      name: 'List',
      url: 'list',
      iconComponent: { name: 'cil-list' }
    },
  ];
}
