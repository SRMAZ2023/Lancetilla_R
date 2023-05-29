import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FacturasComponent } from './facturas-list/facturas.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:FacturasComponent },
	])],
	exports: [RouterModule]
})
export class FacturasRoutingModule { }
