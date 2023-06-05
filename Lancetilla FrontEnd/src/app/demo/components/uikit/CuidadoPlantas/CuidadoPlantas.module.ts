import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CuidadoPlantasRoutingModule } from './CuidadoPlantas-routing.module';
import { TableModule } from 'primeng/table';
import { FileUploadModule } from 'primeng/fileupload';
import { ButtonModule } from 'primeng/button';
import { RippleModule } from 'primeng/ripple';
import { ToastModule } from 'primeng/toast';
import { CalendarModule } from "primeng/calendar";
import { PanelModule } from 'primeng/panel';
import { AccordionModule } from 'primeng/accordion';

import { ToolbarModule } from 'primeng/toolbar';
import { RatingModule } from 'primeng/rating';
import { InputTextModule } from 'primeng/inputtext';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { DropdownModule } from 'primeng/dropdown';
import { RadioButtonModule } from 'primeng/radiobutton';
import { InputNumberModule } from 'primeng/inputnumber';
import { DialogModule } from 'primeng/dialog';
import { CuidadoPlantasNewComponent } from './CuidadoPlantas-new/CuidadoPlantas-newcomponent';
import { CuidadoPlantasEditComponent } from './CuidadoPlantas-edit/CuidadoPlantas-edit.component';
import { CuidadoPlantasComponent } from './CuidadoPlantas-list/CuidadoPlantas.component';
@NgModule({
    imports: [
        CommonModule,
        CuidadoPlantasRoutingModule,
        TableModule,
        FileUploadModule,
        FormsModule,
        CalendarModule,
        ButtonModule,
        AccordionModule,
        RippleModule,
        PanelModule,
        ToastModule,
        ToolbarModule,
        RatingModule,
        InputTextModule,
        InputTextareaModule,
        DropdownModule,
        RadioButtonModule,
        InputNumberModule,
        DialogModule
    ],
    declarations: [CuidadoPlantasComponent, CuidadoPlantasNewComponent,CuidadoPlantasEditComponent ]
})
export class CuidadoPlantasModule { }
