import { Component, OnInit } from '@angular/core';
import { loadReportGraph } from '@features/report-graph/store/report-graph.actions';
import { Store } from '@ngrx/store';
import { ChartOptions } from 'chart.js';

// TODO data laden von app abschauen

@Component({
  selector: 'app-report-graph',
  template: `
    <c-button-toolbar class="toolbar">
      <c-dropdown>
        <button cButton cDropdownToggle color="secondary" variant="outline">All Accounts</button>
        <ul cDropdownMenu>
          <li><a [routerLink]="[]" cDropdownItem>All Acounts</a></li>
          <li><a [routerLink]="[]" cDropdownItem>Cash</a></li>
        </ul>
      </c-dropdown>

      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" />
        <label class="btn btn-outline-secondary" for="btnradio1">Day</label>

        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" checked />
        <label class="btn btn-outline-secondary" for="btnradio2">Month</label>

        <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off" />
        <label class="btn btn-outline-secondary" for="btnradio3">Year</label>

        <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off" />
        <label class="btn btn-outline-secondary" for="btnradio4">All</label>
      </div>

      <div class="spacer"></div>

      <button type="button" class="btn btn-primary">
        <!-- <span class="cil-contrast"></span> -->
        <svg cIcon name="cilPlus"></svg>
        Create
      </button>
    </c-button-toolbar>

    <c-row class="g-4">
      <c-col sm="12" xl="4" class="chart">
        <!-- <c-card>
          <c-card-body> -->
        <c-chart [data]="data" type="doughnut" [options]="options" height="350" />
        <!-- </c-card-body>
        </c-card> -->
      </c-col>

      <c-col sm="12" xl="4">
        <c-card>
          <c-card-header>Incomes</c-card-header>
          <c-card-body>
            <p>Incomes</p>
          </c-card-body>
        </c-card>
      </c-col>

      <c-col sm="12" xl="4">
        <c-card>
          <c-card-header>Outcomes</c-card-header>
          <c-card-body>
            <p>Outcomes</p>
          </c-card-body>
        </c-card>
      </c-col>
    </c-row>
  `,
  styleUrl: './report-graph.component.scss',
})
export class ReportGraphComponent implements OnInit {
  options: ChartOptions = {
    responsive: true,
    maintainAspectRatio: false,
  };

  constructor(private store: Store<ReportGraphComponent>) {}

  data = {
    labels: ['VueJs', 'EmberJs', 'ReactJs', 'Angular'],
    datasets: [
      {
        backgroundColor: ['#41B883', '#E46651', '#00D8FF', '#DD1B16'],
        data: [40, 20, 80, 10],
      },
    ],
  };

  ngOnInit(): void {
    this.store.dispatch(loadReportGraph());
  }
}
