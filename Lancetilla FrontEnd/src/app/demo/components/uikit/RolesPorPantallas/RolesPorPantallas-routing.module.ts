import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { RolesPorPantallaComponent } from './RolesPorPantallas.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: RolesPorPantallaComponent }
	])],
	exports: [RouterModule]
})
export class RolesPorPantallaRoutingModule { }
