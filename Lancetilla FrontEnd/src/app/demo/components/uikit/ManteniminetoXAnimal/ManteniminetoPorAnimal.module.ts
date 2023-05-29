import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MantenimientoPorAnimalRoutingModule } from './ManteniminetoPorAnimal-routing.module';
import { TableModule } from 'primeng/table';
import { FileUploadModule } from 'primeng/fileupload';
import { ButtonModule } from 'primeng/button';
import { RippleModule } from 'primeng/ripple';
import { ToastModule } from 'primeng/toast';
import { CalendarModule } from "primeng/calendar";
import { PanelModule } from 'primeng/panel';

import { ToolbarModule } from 'primeng/toolbar';
import { RatingModule } from 'primeng/rating';
import { InputTextModule } from 'primeng/inputtext';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { DropdownModule } from 'primeng/dropdown';
import { RadioButtonModule } from 'primeng/radiobutton';
import { InputNumberModule } from 'primeng/inputnumber';
import { DialogModule } from 'primeng/dialog';
import { MantenimientoPorAnimalNewComponent } from './MantenimientoPorAnimal-new/MantenimientoPorAnimal-newcomponent';
import { MantenimientoPorAnimalEditComponent } from './MantenimientoPorAnimal-edit/ManteniminetoPorAnimal-edit.component';
import { MantenimientoPorAnimalComponent } from './MantenimientoPorAnimal-list/MantenimientoPorAnimal.component';
@NgModule({
    imports: [
        CommonModule,
        MantenimientoPorAnimalRoutingModule,
        TableModule,
        FileUploadModule,
        FormsModule,
        CalendarModule,
        ButtonModule,
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
    declarations: [MantenimientoPorAnimalComponent, MantenimientoPorAnimalNewComponent,MantenimientoPorAnimalEditComponent ]
})
export class MantenimientoPorAnimalModule { }
