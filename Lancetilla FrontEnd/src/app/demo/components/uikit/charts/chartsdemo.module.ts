import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ChartsDemoRoutingModule } from './chartsdemo-routing.module';
import { ChartModule } from 'primeng/chart'
import { ChartsDemoComponent } from './chartsdemo.component';
import { CalendarModule } from 'primeng/calendar';
import { FormsModule } from '@angular/forms';

@NgModule({
	imports: [
		FormsModule,
		CommonModule,
		CalendarModule,
		ChartsDemoRoutingModule,
		ChartModule
	],
	declarations: [ChartsDemoComponent]
})
export class ChartsDemoModule { }
