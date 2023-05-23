import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { HabitatComponent } from './habitat.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: HabitatComponent }
	])],
	exports: [RouterModule]
})
export class HabitatRoutingModule { }
