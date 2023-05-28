import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AnimalesComponent } from './animales-list/Animales.component';
import { AnimalNewComponent } from './animales-new/AnimalesNew.component';
import { AnimalesEditComponent } from './animales-edit/Animales-edit.component';
@NgModule({
	imports: [RouterModule.forChild([
		{ path: '', component:AnimalesComponent },
		{ path: 'Create', component:AnimalNewComponent },
		{ path: 'Edit/:id', component:AnimalesEditComponent }

	])],
	exports: [RouterModule]
})
export class AnimalesRoutingModule { }
