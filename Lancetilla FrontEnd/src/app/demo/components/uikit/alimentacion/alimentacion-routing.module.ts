import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AlimentacionComponent } from './alimentacion.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: AlimentacionComponent }
	])],
	exports: [RouterModule]
})
export class AlimentacionRoutingModule { }
