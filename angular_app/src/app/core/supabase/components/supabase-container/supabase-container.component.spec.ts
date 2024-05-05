import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SupabaseContainerComponent } from './supabase-container.component';

describe('SupabaseContainerComponent', () => {
  let component: SupabaseContainerComponent;
  let fixture: ComponentFixture<SupabaseContainerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [SupabaseContainerComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SupabaseContainerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
