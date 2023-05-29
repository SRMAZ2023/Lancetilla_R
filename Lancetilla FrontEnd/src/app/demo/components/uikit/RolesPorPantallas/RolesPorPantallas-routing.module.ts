import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { RolesPorPantallaComponent } from './RolesPorPantallaLISTA/RolesPorPantallas.component';
import { RolesPorPantallaInsertComponent } from './RolesPorPantalla-Insert/RolesPorPantallas-Insert.component';
import { RolesPorPantallaUpdateComponent } from './RolesPorPantalla-Editar/RolesPorPantallas-Update.component';


@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: RolesPorPantallaComponent },
		{ path: 'Insert', component: RolesPorPantallaInsertComponent },
		{ path: 'Update/:role_Id/:role_Descripcion', component: RolesPorPantallaUpdateComponent }

	
	])],
	exports: [RouterModule]
})
export class RolesPorPantallaRoutingModule { }
