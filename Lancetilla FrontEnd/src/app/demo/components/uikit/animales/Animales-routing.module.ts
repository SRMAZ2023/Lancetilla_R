import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AnimalesComponent } from './Animales.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:AnimalesComponent },

	])],
	exports: [RouterModule]
})
export class AnimalesRoutingModule { }
