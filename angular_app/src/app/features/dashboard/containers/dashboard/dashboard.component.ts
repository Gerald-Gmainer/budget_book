import { ChangeDetectionStrategy, ChangeDetectorRef, Component, DestroyRef, OnInit, Renderer2, ViewChild, WritableSignal, inject, signal } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { Observable } from 'rxjs';
import { loadDashboard } from '../../store/dashboard.actions';
import { selectDashboardData } from '../../store/dashboard.selectors';
import { DashboardState } from '../../store/dashboard.state';
import { AuthService } from '@core/auth/services/auth.service';
import { Router } from '@angular/router';
import { ROUTES } from '@constants/routes';
import { ChartjsComponent } from '@coreui/angular-chartjs';
import { getStyle } from '@coreui/utils';
import { FormGroup, FormControl } from '@angular/forms';
import { ChartData, ChartDataset, ChartOptions, ChartType, PluginOptionsByType, ScaleOptions, TooltipLabelStyle } from 'chart.js';
import { DOCUMENT } from '@angular/common';
import { DashboardChartsData } from './dashboard-charts-data';

export interface IChartProps {
  data?: ChartData;
  labels?: any;
  options?: ChartOptions;
  colors?: any;
  type: ChartType;
  legend?: any;

  [propName: string]: any;
}

@Component({
  selector: 'app-dashboard',
  template: `
    <c-row class="g-4">
      <c-col sm="6" xl="3">
        <c-widget-stat-a color="primary" [title]="'Monthly Balance'">
          <ng-template cTemplateId="widgetValueTemplate" ngPreserveWhitespaces>
            26K
            <span class="fw-normal" style="font-size: 12px;"> (-12.4% <svg cIcon name="cilArrowBottom" size="sm"></svg>) </span>
          </ng-template>
          <ng-template cTemplateId="widgetChartTemplate">
            <c-chart [data]="data[0]" [options]="options[0]" class="mt-3 mx-3" height="70" [type]="'line'"></c-chart>
          </ng-template>
        </c-widget-stat-a>
      </c-col>

      <c-col sm="6" xl="3">
        <c-widget-stat-a [title]="'Yearly Balance'" color="info">
          <ng-template cTemplateId="widgetValueTemplate" ngPreserveWhitespaces>
            <span>$6.200</span>
            <span class="fw-normal" style="font-size: 12px;"> (40.9%<svg cIcon name="cilArrowTop" size="sm"></svg>) </span>
          </ng-template>
          <ng-template cTemplateId="widgetChartTemplate">
            <c-chart [data]="data[1]" [options]="options[1]" class="mt-3 mx-3" height="70" type="line"></c-chart>
          </ng-template>
        </c-widget-stat-a>
      </c-col>

      <c-col sm="6" xl="3">
        <c-widget-stat-a [title]="'All Balance'" color="warning">
          <ng-template cTemplateId="widgetValueTemplate" ngPreserveWhitespaces>
            <span>2.49</span>
            <span class="fw-normal" style="font-size: 12px;"> (84.7% <svg cIcon name="cilArrowTop" size="sm"></svg>) </span>
          </ng-template>
          <ng-template cTemplateId="widgetChartTemplate">
            <c-chart [data]="data[2]" [options]="options[2]" class="mt-3" height="70" type="line"></c-chart>
          </ng-template>
        </c-widget-stat-a>
      </c-col>

      <c-col sm="6" xl="3">
        <c-widget-stat-a [title]="'Month-end Money'" color="danger">
          <ng-template cTemplateId="widgetValueTemplate" ngPreserveWhitespaces>
            <span>44K</span>
            <span class="fw-normal" style="font-size: 12px;"> (-23.6% <svg cIcon name="cilArrowBottom" size="sm"></svg>) </span>
          </ng-template>
          <ng-template cTemplateId="widgetChartTemplate">
            <c-chart [data]="data[3]" [options]="options[3]" class="mt-3 mx-3" height="70" type="bar"></c-chart>
          </ng-template>
        </c-widget-stat-a>
      </c-col>
    </c-row>

    <c-row class="g-4">
      <c-col sm="12" xl="8">
        <c-card class="my-4">
          <c-card-body>
            <c-row>
              <c-col sm="5">
                <h4 class="card-title mb-0" id="traffic">Income / Outcome</h4>
                <div class="small text-body-secondary">January - December 2023</div>
              </c-col>
              <c-col class="d-none d-md-block" sm="7">
                <button cButton class="float-end" color="primary">
                  <svg cIcon name="cilCloudDownload"></svg>
                </button>
                <form [formGroup]="trafficRadioGroup">
                  <c-button-group class="float-end me-3" role="group">
                    <input class="btn-check" formControlName="trafficRadio" type="radio" value="Day" />
                    <label (click)="setTrafficPeriod('Day')" cButton cFormCheckLabel color="secondary" variant="outline"> Day </label>
                    <input class="btn-check" formControlName="trafficRadio" type="radio" value="Month" />
                    <label (click)="setTrafficPeriod('Month')" cButton cFormCheckLabel color="secondary" variant="outline"> Month </label>
                    <input class="btn-check" formControlName="trafficRadio" type="radio" value="Year" />
                    <label (click)="setTrafficPeriod('Year')" cButton cFormCheckLabel color="secondary" variant="outline"> Year </label>
                  </c-button-group>
                </form>
              </c-col>
            </c-row>
            <c-chart
              [data]="mainChart.data"
              [height]="300"
              [ngStyle]="{ 'marginTop.px': 40 }"
              [options]="mainChart.options"
              [type]="mainChart.type"
              (chartRef)="handleChartRef($event)"
            >
              Main chart
            </c-chart>
          </c-card-body>
          <c-card-footer>
            <c-row class="text-center mb-2" [xl]="5" [lg]="4" [sm]="2" [xs]="1" [gutter]="4">
              <c-col>
                <div class="text-body-secondary">Fixed Costs</div>
                <strong>29.703 Users (40%)</strong>
                <c-progress class="mt-2" thin color="success" value="40" />
              </c-col>
              <c-col>
                <div class="text-body-secondary">Food Costs</div>
                <div class="fw-semibold text-truncate">24.093 Users (20%)</div>
                <c-progress class="mt-2" thin color="info" value="20" />
              </c-col>
              <c-col>
                <div class="text-body-secondary">Variable Costs</div>
                <div class="fw-semibold text-truncate">78.706 Views (60%)</div>
                <c-progress class="mt-2" thin color="warning" value="60" />
              </c-col>
              <c-col>
                <div class="text-body-secondary">Other costs</div>
                <div class="fw-semibold text-truncate">22.123 Users (80%)</div>
                <c-progress class="mt-2" thin color="danger" value="80" />
              </c-col>
              <c-col class="d-none d-xl-block">
                <div class="text-body-secondary">Bounce Rate</div>
                <div class="fw-semibold text-truncate">Average Rate (40.15%)</div>
                <c-progress class="mt-2" thin value="40" />
              </c-col>
            </c-row>
          </c-card-footer>
        </c-card>
      </c-col>

      <c-col sm="12" xl="4">
        <c-card class="my-4">
          <c-card-body> <p>Last Bookings</p> </c-card-body>
        </c-card>
      </c-col>
    </c-row>
  `,
  styleUrl: './dashboard.component.scss',
  changeDetection: ChangeDetectionStrategy.Default,
})
export class DashboardComponent implements OnInit {
  @ViewChild('chart') chartComponent!: ChartjsComponent;
  readonly #destroyRef: DestroyRef = inject(DestroyRef);
  readonly #document: Document = inject(DOCUMENT);
  readonly #renderer: Renderer2 = inject(Renderer2);
  readonly #chartsData: DashboardChartsData = inject(DashboardChartsData);

  data: any[] = [];
  options: any[] = [];
  labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'January', 'February', 'March', 'April'];
  datasets = [
    [
      {
        label: 'My First dataset',
        backgroundColor: 'transparent',
        borderColor: 'rgba(255,255,255,.55)',
        pointBackgroundColor: getStyle('--cui-primary'),
        pointHoverBorderColor: getStyle('--cui-primary'),
        data: [65, 59, 84, 84, 51, 55, 40],
      },
    ],
    [
      {
        label: 'My Second dataset',
        backgroundColor: 'transparent',
        borderColor: 'rgba(255,255,255,.55)',
        pointBackgroundColor: getStyle('--cui-info'),
        pointHoverBorderColor: getStyle('--cui-info'),
        data: [1, 18, 9, 17, 34, 22, 11],
      },
    ],
    [
      {
        label: 'My Third dataset',
        backgroundColor: 'rgba(255,255,255,.2)',
        borderColor: 'rgba(255,255,255,.55)',
        pointBackgroundColor: getStyle('--cui-warning'),
        pointHoverBorderColor: getStyle('--cui-warning'),
        data: [78, 81, 80, 45, 34, 12, 40],
        fill: true,
      },
    ],
    [
      {
        label: 'My Fourth dataset',
        backgroundColor: 'rgba(255,255,255,.2)',
        borderColor: 'rgba(255,255,255,.55)',
        data: [78, 81, 80, 45, 34, 12, 40, 85, 65, 23, 12, 98, 34, 84, 67, 82],
        barPercentage: 0.7,
      },
    ],
  ];
  optionsDefault = {
    plugins: {
      legend: {
        display: false,
      },
    },
    maintainAspectRatio: false,
    scales: {
      x: {
        border: {
          display: false,
        },
        grid: {
          display: false,
          drawBorder: false,
        },
        ticks: {
          display: false,
        },
      },
      y: {
        min: 30,
        max: 89,
        display: false,
        grid: {
          display: false,
        },
        ticks: {
          display: false,
        },
      },
    },
    elements: {
      line: {
        borderWidth: 1,
        tension: 0.4,
      },
      point: {
        radius: 4,
        hitRadius: 10,
        hoverRadius: 4,
      },
    },
  };
  public mainChart: IChartProps = { type: 'line' };
  public mainChartRef: WritableSignal<any> = signal(undefined);
  public chart: Array<IChartProps> = [];
  public trafficRadioGroup = new FormGroup({
    trafficRadio: new FormControl('Month'),
  });

  constructor(private store: Store<DashboardState>, private authService: AuthService, private router: Router, private changeDetectorRef: ChangeDetectorRef) {}

  ngOnInit(): void {
    this.setData();
    this.initCharts();
    this.updateChartOnColorModeChange();
  }

  ngAfterContentInit(): void {
    this.changeDetectorRef.detectChanges();
  }

  setData() {
    for (let idx = 0; idx < 4; idx++) {
      this.data[idx] = {
        labels: idx < 3 ? this.labels.slice(0, 7) : this.labels,
        datasets: this.datasets[idx],
      };
    }
    this.setOptions();
  }

  setOptions() {
    for (let idx = 0; idx < 4; idx++) {
      const options = JSON.parse(JSON.stringify(this.optionsDefault));
      switch (idx) {
        case 0: {
          this.options.push(options);
          break;
        }
        case 1: {
          options.scales.y.min = -9;
          options.scales.y.max = 39;
          options.elements.line.tension = 0;
          this.options.push(options);
          break;
        }
        case 2: {
          options.scales.x = { display: false };
          options.scales.y = { display: false };
          options.elements.line.borderWidth = 2;
          options.elements.point.radius = 0;
          this.options.push(options);
          break;
        }
        case 3: {
          options.scales.x.grid = { display: false, drawTicks: false };
          options.scales.x.grid = { display: false, drawTicks: false, drawBorder: false };
          options.scales.y.min = undefined;
          options.scales.y.max = undefined;
          options.elements = {};
          this.options.push(options);
          break;
        }
      }
    }
  }

  initCharts(): void {
    this.mainChart = this.#chartsData.mainChart;
  }

  setTrafficPeriod(value: string): void {
    this.trafficRadioGroup.setValue({ trafficRadio: value });
    this.#chartsData.initMainChart(value);
    this.initCharts();
  }

  handleChartRef($chartRef: any) {
    if ($chartRef) {
      this.mainChartRef.set($chartRef);
    }
  }

  updateChartOnColorModeChange() {
    const unListen = this.#renderer.listen(this.#document.documentElement, 'ColorSchemeChange', () => {
      this.setChartStyles();
    });

    this.#destroyRef.onDestroy(() => {
      unListen();
    });
  }

  setChartStyles() {
    if (this.mainChartRef()) {
      setTimeout(() => {
        const options: ChartOptions = { ...this.mainChart.options };
        const scales = this.#chartsData.getScales();
        this.mainChartRef().options.scales = { ...options.scales, ...scales };
        this.mainChartRef().update();
      });
    }
  }
}
