import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { TiposPlantasComponent } from './TiposPlantas.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: TiposPlantasComponent }
	])],
	exports: [RouterModule]
})
export class TiposPlantasRoutingModule { }
