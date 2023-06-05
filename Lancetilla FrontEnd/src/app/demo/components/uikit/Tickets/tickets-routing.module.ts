import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ticketsComponent } from './tickets.component';



import { BreadcrumbModule } from 'primeng/breadcrumb';
import { MenubarModule } from 'primeng/menubar';
import { TabMenuModule } from 'primeng/tabmenu';
import { StepsModule } from 'primeng/steps';
import { TieredMenuModule } from 'primeng/tieredmenu';
import { MenuModule } from 'primeng/menu';
import { ButtonModule } from 'primeng/button';
import { ContextMenuModule } from 'primeng/contextmenu';
import { MegaMenuModule } from 'primeng/megamenu';
import { PanelMenuModule } from 'primeng/panelmenu';
import { InputTextModule } from 'primeng/inputtext';

import { ToolbarModule } from 'primeng/toolbar';
import { RatingModule } from 'primeng/rating';

import { InputTextareaModule } from 'primeng/inputtextarea';

import { RadioButtonModule } from 'primeng/radiobutton';
import { InputNumberModule } from 'primeng/inputnumber';


import { InputMaskModule } from "primeng/inputmask";

import { FormsModule } from '@angular/forms';

import { MessageService } from 'primeng/api';
import { TicketsService } from 'src/app/demo/service/Tickets.service';

import { CheckboxModule } from 'primeng/checkbox';

import { DropdownModule } from 'primeng/dropdown';

import { ToastModule } from 'primeng/toast';



import { FileUploadModule } from 'primeng/fileupload';

import { RippleModule } from 'primeng/ripple';

import { DialogModule } from 'primeng/dialog';



@NgModule({
  imports: [
    CommonModule,
    DialogModule,
    
    FileUploadModule,
    RippleModule,
    ToastModule,
    DropdownModule,
	  CheckboxModule,
    FormsModule,
    InputMaskModule,
    ToolbarModule,
    RatingModule,
    InputNumberModule,
    RadioButtonModule,
    InputTextareaModule,
    BreadcrumbModule,
    MenubarModule,
    TabMenuModule,
    StepsModule,
    TieredMenuModule,
    MenuModule,
    ButtonModule,
    ContextMenuModule,
    MegaMenuModule,
    PanelMenuModule,
    InputTextModule,
    RouterModule.forChild([
      {
        path: '', component: ticketsComponent, children: [
          { path: '', redirectTo: 'personal', pathMatch: 'full' },
        
        ]
      }
    ])
  ],
  declarations: [ticketsComponent],
  exports: [RouterModule],
  providers: [MessageService, TicketsService] // Agrega el proveedor FacturaService aquí
})
export class ticketsRoutingModule { }
