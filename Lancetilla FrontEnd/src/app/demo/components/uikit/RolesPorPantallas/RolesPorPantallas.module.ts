import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RolesPorPantallaRoutingModule } from './RolesPorPantallas-routing.module';
import { RolesPorPantallaComponent } from './RolesPorPantallas.component';
import { TableModule } from 'primeng/table';
import { FileUploadModule } from 'primeng/fileupload';
import { ButtonModule } from 'primeng/button';
import { RippleModule } from 'primeng/ripple';
import { ToastModule } from 'primeng/toast';
import { ToolbarModule } from 'primeng/toolbar';
import { RatingModule } from 'primeng/rating';
import { InputTextModule } from 'primeng/inputtext';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { DropdownModule } from 'primeng/dropdown';
import { RadioButtonModule } from 'primeng/radiobutton';
import { InputNumberModule } from 'primeng/inputnumber';
import { DialogModule } from 'primeng/dialog';






import { ToggleButtonModule } from 'primeng/togglebutton';

import { MultiSelectModule } from 'primeng/multiselect';

import { ProgressBarModule } from 'primeng/progressbar';

import { SliderModule } from 'primeng/slider';



@NgModule({
    imports: [
      
        MultiSelectModule,
        SliderModule,
        ToggleButtonModule,
        CommonModule,
        ProgressBarModule,
        RolesPorPantallaRoutingModule,
        TableModule,
        FileUploadModule,
        FormsModule,
        ButtonModule,
        RippleModule,
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
    declarations: [RolesPorPantallaComponent]
})
export class RolesPorPantallaModule { }
