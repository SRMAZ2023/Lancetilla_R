import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AnimalesEditComponent} from './Animales-edit.component';

describe('AnimalesEditComponent', () => {
  let component: AnimalesEditComponent;
  let fixture: ComponentFixture<AnimalesEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AnimalesEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AnimalesEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
