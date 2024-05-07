import { Component } from '@angular/core';

@Component({
  selector: 'main-footer',
  template: `
    <div class="ms-auto">
      Powered by
      <a href="https://coreui.io/angular" target="_blank">
        <span> CoreUI for Angular</span>
      </a>
    </div>
  `,
  styleUrl: './main-footer.component.scss',
})
export class MainFooterComponent {}
