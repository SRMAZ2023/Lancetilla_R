import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { EstadoCivilesComponent } from './EstadoCivil.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: EstadoCivilesComponent }
	])],
	exports: [RouterModule]
})
export class EstadoCivilesRoutingModule { }
