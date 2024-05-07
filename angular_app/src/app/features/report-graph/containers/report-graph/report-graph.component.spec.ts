import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportGraphComponent } from './report-graph.component';

describe('ReportGraphComponent', () => {
  let component: ReportGraphComponent;
  let fixture: ComponentFixture<ReportGraphComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ReportGraphComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ReportGraphComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
