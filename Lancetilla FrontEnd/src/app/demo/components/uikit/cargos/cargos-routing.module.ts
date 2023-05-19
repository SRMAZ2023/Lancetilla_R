import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { cargosComponent } from './cargos.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: cargosComponent }
	])],
	exports: [RouterModule]
})
export class cargosRoutingModule { }
