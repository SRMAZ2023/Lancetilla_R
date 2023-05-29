import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MunicipiosComponent } from './Municipios.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: MunicipiosComponent }
	])],
	exports: [RouterModule]
})
export class MunicipiosRoutingModule { }
