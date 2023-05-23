import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { visitantesComponent } from './visitantes.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: visitantesComponent }
	])],
	exports: [RouterModule]
})
export class visitantesRoutingModule { }
