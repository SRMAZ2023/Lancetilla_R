import { ComponentFixture, TestBed } from '@angular/core/testing';

import { empleadosEditComponent } from './empleados-edit.component';
describe('empleadosEditComponent', () => {
  let component: empleadosEditComponent;
  let fixture: ComponentFixture<empleadosEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ empleadosEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(empleadosEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
