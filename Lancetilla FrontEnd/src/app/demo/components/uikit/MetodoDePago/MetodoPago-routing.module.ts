import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MetodoPagoComponent } from './MetodoPago.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: MetodoPagoComponent }
	])],
	exports: [RouterModule]
})
export class MetodoPagoRoutingModule { }
