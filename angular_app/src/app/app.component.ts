import { Component } from '@angular/core';
import { Router, NavigationStart, NavigationEnd, NavigationError } from '@angular/router';

@Component({
  selector: 'app-root',
  template: `<supabase-container> <router-outlet></router-outlet> </supabase-container>`,
  styleUrl: './app.component.scss',
})
export class AppComponent {
  // constructor(private router: Router) {
  //   this.router.events.subscribe((event) => {
  //     if (event instanceof NavigationStart) {
  //       console.log('Navigation started:', event.url);
  //     } else if (event instanceof NavigationEnd) {
  //       console.log('Navigation ended:', event.url);
  //     } else if (event instanceof NavigationError) {
  //       console.error('Navigation error:', event.error);
  //     }
  //   });
  // }
}
