import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CuidadoPlantasEditComponent } from './CuidadoPlantas-edit.component';

describe('CuidadoPlantasEditComponent', () => {
  let component: CuidadoPlantasEditComponent;
  let fixture: ComponentFixture<CuidadoPlantasEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CuidadoPlantasEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CuidadoPlantasEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
