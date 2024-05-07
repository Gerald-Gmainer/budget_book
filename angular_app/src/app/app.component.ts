import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { Router, NavigationStart, NavigationEnd, NavigationError } from '@angular/router';
import { iconSubset } from '@core/icons/icon-subset';
import { IconSetService } from '@coreui/icons-angular';

@Component({
  selector: 'app-root',
  template: `<supabase-container> <router-outlet></router-outlet> </supabase-container>`,
  styleUrl: './app.component.scss',
})
export class AppComponent {
  title = 'CoreUI Angular Admin Template';

  constructor(
    private router: Router,
    private titleService: Title,
    private iconSetService: IconSetService
  ) {
    this.titleService.setTitle(this.title);
    this.iconSetService.icons = { ...iconSubset };
  }

  ngOnInit(): void {
    this.router.events.subscribe((evt) => {
      if (!(evt instanceof NavigationEnd)) {
        return;
      }
    });
  }
}
