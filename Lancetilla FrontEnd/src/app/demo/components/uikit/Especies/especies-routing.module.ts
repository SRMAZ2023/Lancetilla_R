import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { especiesComponent } from './especies.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: especiesComponent }
	])],
	exports: [RouterModule]
})
export class especiesRoutingModule { }
