import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { TipoCuidadosComponent } from './TipoCuidado.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: TipoCuidadosComponent }
	])],
	exports: [RouterModule]
})
export class TipoCuidadoRoutingModule { }
