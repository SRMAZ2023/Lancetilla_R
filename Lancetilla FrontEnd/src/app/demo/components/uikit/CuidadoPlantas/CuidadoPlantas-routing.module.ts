import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import {CuidadoPlantasComponent } from './CuidadoPlantas-list/CuidadoPlantas.component';
import {CuidadoPlantasNewComponent } from './CuidadoPlantas-new/CuidadoPlantas-newcomponent';
import {CuidadoPlantasEditComponent } from './CuidadoPlantas-edit/CuidadoPlantas-edit.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:CuidadoPlantasComponent },
		{ path: 'Create', component:CuidadoPlantasNewComponent },
		{ path: 'Edit/:id', component:CuidadoPlantasEditComponent }
	])],
	exports: [RouterModule]
})
export class CuidadoPlantasRoutingModule { }
