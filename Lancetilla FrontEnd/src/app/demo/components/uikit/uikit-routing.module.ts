import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';

@NgModule({
    imports: [RouterModule.forChild([
        { path: 'Especies', data: { breadcrumb: 'especies' }, loadChildren: () => import('./Especies/especies.module').then(m => m.especiesModule) },
        { path: 'cargos', data: { breadcrumb: 'cargos' }, loadChildren: () => import('./cargos/cargos.module').then(m => m.cargosModule) },
        { path: 'departamentos', data: { breadcrumb: 'departamentos' }, loadChildren: () => import('./departamentos/departamentos.module').then(m => m.departamentosModule) },
        { path: 'TiposDeMantenimiento', data: { breadcrumb: 'TiposDeMantenimiento' }, loadChildren: () => import('./TipoDeMantenimiento/TiposDeMantenimiento.module').then(m => m.TiposDeMantenimientosModule) },
        { path: 'Plantas', data: { breadcrumb: 'Plantas' }, loadChildren: () => import('./Plantas/Plantas.module').then(m => m.PlantasModule) },
        { path: 'MetodoDePago', data: { breadcrumb: 'MetodoDePago' }, loadChildren: () => import('./MetodoDePago/MetodoPago.module').then(m => m.MetodoPagoModule) },
        { path: 'EstadoCivil', data: { breadcrumb: 'EstadoCivil' }, loadChildren: () => import('./EstadoCivil/EstadoCivil.module').then(m => m.EstadoCivilModule) },
        { path: 'Empleados', data: { breadcrumb: 'Empleados' }, loadChildren: () => import('./Empleados/empleados.module').then(m => m.EmpleadosModule) },
        { path: 'Mantenimineto', data: { breadcrumb: 'Mantenimineto' }, loadChildren: () => import('./Mantenimineto/Mantenimiento.module').then(m => m.MantenimientoModule) },
        { path: 'ManteniminetoXAnimal', data: { breadcrumb: 'ManteniminetoXAnimal' }, loadChildren: () => import('./ManteniminetoXAnimal/ManteniminetoPorAnimal.module').then(m => m.MantenimientoPorAnimalModule) },
        { path: 'Create', data: { breadcrumb: 'Create' }, loadChildren: () => import('./Plantas/Plantas.module').then(m => m.PlantasModule) },
        { path: 'Edit', data: { breadcrumb: 'Edit' }, loadChildren: () => import('./Plantas/Plantas.module').then(m => m.PlantasModule) },
        { path: 'button', data: { breadcrumb: 'Button' }, loadChildren: () => import('./button/buttondemo.module').then(m => m.ButtonDemoModule) },
        { path: 'charts', data: { breadcrumb: 'Charts' }, loadChildren: () => import('./charts/chartsdemo.module').then(m => m.ChartsDemoModule) },
        { path: 'file', data: { breadcrumb: 'File' }, loadChildren: () => import('./file/filedemo.module').then(m => m.FileDemoModule) },
        { path: 'floatlabel', data: { breadcrumb: 'Float Label' }, loadChildren: () => import('./floatlabel/floatlabeldemo.module').then(m => m.FloatlabelDemoModule) },
        { path: 'formlayout', data: { breadcrumb: 'Form Layout' }, loadChildren: () => import('./formlayout/formlayoutdemo.module').then(m => m.FormLayoutDemoModule) },
        { path: 'input', data: { breadcrumb: 'Input' }, loadChildren: () => import('./input/inputdemo.module').then(m => m.InputDemoModule) },
        { path: 'invalidstate', data: { breadcrumb: 'Invalid State' }, loadChildren: () => import('./invalid/invalidstatedemo.module').then(m => m.InvalidStateDemoModule) },
        { path: 'list', data: { breadcrumb: 'List' }, loadChildren: () => import('./list/listdemo.module').then(m => m.ListDemoModule) },
        { path: 'media', data: { breadcrumb: 'Media' }, loadChildren: () => import('./media/mediademo.module').then(m => m.MediaDemoModule) },
        { path: 'message', data: { breadcrumb: 'Message' }, loadChildren: () => import('./messages/messagesdemo.module').then(m => m.MessagesDemoModule) },
        { path: 'misc', data: { breadcrumb: 'Misc' }, loadChildren: () => import('./misc/miscdemo.module').then(m => m.MiscDemoModule) },
        { path: 'overlay', data: { breadcrumb: 'Overlay' }, loadChildren: () => import('./overlays/overlaysdemo.module').then(m => m.OverlaysDemoModule) },
        { path: 'panel', data: { breadcrumb: 'Panel' }, loadChildren: () => import('./panels/panelsdemo.module').then(m => m.PanelsDemoModule) },
        { path: 'table', data: { breadcrumb: 'Table' }, loadChildren: () => import('./table/tabledemo.module').then(m => m.TableDemoModule) },
        { path: 'tree', data: { breadcrumb: 'Tree' }, loadChildren: () => import('./tree/treedemo.module').then(m => m.TreeDemoModule) },
        { path: 'menu', data: { breadcrumb: 'Menu' }, loadChildren: () => import('./menus/menus.module').then(m => m.MenusModule) },
        { path: '**', redirectTo: '/notfound' }
    ])],
    exports: [RouterModule]
})
export class UIkitRoutingModule { }
