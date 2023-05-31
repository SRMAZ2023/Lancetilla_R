import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { RazasComponent } from './Razas.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:RazasComponent },
	])],
	exports: [RouterModule]
})
export class RazasRoutingModule { }
