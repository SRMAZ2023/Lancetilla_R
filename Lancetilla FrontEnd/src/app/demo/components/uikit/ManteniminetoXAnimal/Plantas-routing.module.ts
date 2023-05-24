import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { PlantasComponent } from './MantenimientoPorAnimal-list/Plantas.component';
import { PlantasNewComponent } from './MantenimientoPorAnimal-new/Plantas.component';
import { PlantasEditComponent } from './MantenimientoPorAnimal-edit/plantas-edit.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:PlantasComponent },
		{ path: 'Create', component:PlantasNewComponent },
		{ path: 'Edit/:id', component:PlantasEditComponent }
	])],
	exports: [RouterModule]
})
export class PlantasRoutingModule { }
