import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { empleadosComponent } from './empleados-list/empleados.component';
import { empleadosNewComponent } from './empleados-new/empleadosNew.component';
import { empleadosEditComponent } from './empleados-edit/empleados-edit.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:empleadosComponent },
		{ path: 'Create', component:empleadosNewComponent },
		{ path: 'Edit/:id', component:empleadosEditComponent }
	])],
	exports: [RouterModule]
})
export class empleadosRoutingModule { }
