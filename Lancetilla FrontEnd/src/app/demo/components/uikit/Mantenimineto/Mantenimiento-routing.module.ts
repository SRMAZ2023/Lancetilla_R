import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MantenimientoComponent } from './Mantenimiento.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: MantenimientoComponent }
	])],
	exports: [RouterModule]
})
export class MantenimientoRoutingModule { }
