import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MantenimientoPorAnimalComponent } from './MantenimientoPorAnimal-list/MantenimientoPorAnimal.component';
import { MantenimientoPorAnimalNewComponent } from './MantenimientoPorAnimal-new/MantenimientoPorAnimal-newcomponent';
import { MantenimientoPorAnimalEditComponent } from './MantenimientoPorAnimal-edit/ManteniminetoPorAnimal-edit.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:MantenimientoPorAnimalComponent },
		{ path: 'Create', component:MantenimientoPorAnimalNewComponent },
		{ path: 'Edit/:id', component:MantenimientoPorAnimalEditComponent }
	])],
	exports: [RouterModule]
})
export class MantenimientoPorAnimalRoutingModule { }
