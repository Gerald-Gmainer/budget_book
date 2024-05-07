import { TestBed } from '@angular/core/testing';

import { ReportGraphService } from './report-graph.service';

describe('ReportGraphService', () => {
  let service: ReportGraphService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ReportGraphService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
