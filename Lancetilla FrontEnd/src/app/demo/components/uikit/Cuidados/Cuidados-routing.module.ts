import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CuidadosComponent } from './Cuidados.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: CuidadosComponent }
	])],
	exports: [RouterModule]
})
export class CuidadosRoutingModule { }
