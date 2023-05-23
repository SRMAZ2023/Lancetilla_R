import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AreasBotanicasComponent } from './areasbotanicas.component';

@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: AreasBotanicasComponent }
	])],
	exports: [RouterModule]
})
export class AreasBotanicasRoutingModule { }
