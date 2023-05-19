import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { PlantasComponent } from './Plantas.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:PlantasComponent },
		{ path: 'PlantasInsert', component:PlantasComponent }
	])],
	exports: [RouterModule]
})
export class PlantasRoutingModule { }
