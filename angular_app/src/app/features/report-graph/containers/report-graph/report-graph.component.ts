import { Component, OnInit } from '@angular/core';
import { loadReportGraph } from '@features/report-graph/store/report-graph.actions';
import { Store } from '@ngrx/store';

// TODO data laden von app abschauen

@Component({
  selector: 'app-report-graph',
  template: `
    <c-row class="g-4">
      <c-col sm="12" xl="6">
        <c-card>
          <c-card-body>
            <p>graph</p>
          </c-card-body>
        </c-card>
      </c-col>

      <c-col sm="12" xl="6">
        <c-card>
          <c-card-body>
            <p>list</p>
          </c-card-body>
        </c-card>
      </c-col>
    </c-row>
  `,
  styleUrl: './report-graph.component.scss',
})
export class ReportGraphComponent implements OnInit {
  constructor(private store: Store<ReportGraphComponent>) {}

  ngOnInit(): void {
    this.store.dispatch(loadReportGraph());
  }
}
