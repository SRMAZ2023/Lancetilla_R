import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { DepartamentosComponent } from './departamentos.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: DepartamentosComponent }
	])],
	exports: [RouterModule]
})
export class departamentosRoutingModule { }
