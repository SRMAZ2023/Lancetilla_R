import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { TiposDeMantenimientosComponent } from './TiposDeMantenimientos.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: TiposDeMantenimientosComponent }
	])],
	exports: [RouterModule]
})
export class TiposDeMantenimientosRoutingModule { }
