import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { ReporteFacturaComponent } from './ReporteFactura.component';



@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component: ReporteFacturaComponent },
		

	
	])],
	exports: [RouterModule]
})
export class ReporteFacturaRoutingModule { }
