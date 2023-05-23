import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AreasZoologicasComponent } from './areaszoologicas.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: AreasZoologicasComponent }
	])],
	exports: [RouterModule]
})
export class AreasZoologicasRoutingModule { }
