import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CuidadosPlantasComponent } from './cuidadosplantas.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: CuidadosPlantasComponent }
	])],
	exports: [RouterModule]
})
export class CuidadosPlantasRoutingModule { }
