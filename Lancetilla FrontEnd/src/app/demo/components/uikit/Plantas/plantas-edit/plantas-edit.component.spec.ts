import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlantasEditComponent } from './plantas-edit.component';

describe('PlantasEditComponent', () => {
  let component: PlantasEditComponent;
  let fixture: ComponentFixture<PlantasEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PlantasEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PlantasEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
