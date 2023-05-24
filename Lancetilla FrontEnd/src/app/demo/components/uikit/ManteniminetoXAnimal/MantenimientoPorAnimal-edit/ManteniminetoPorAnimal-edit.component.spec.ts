import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MantenimientoPorAnimalEditComponent } from './ManteniminetoPorAnimal-edit.component';

describe('MantenimientoPorAnimalEditComponent', () => {
  let component: MantenimientoPorAnimalEditComponent;
  let fixture: ComponentFixture<MantenimientoPorAnimalEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MantenimientoPorAnimalEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MantenimientoPorAnimalEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
