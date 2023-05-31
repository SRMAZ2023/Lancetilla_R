import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';

@NgModule({
    imports: [RouterModule.forChild([
        { path: 'Empleados', data: { breadcrumb: 'Empleados' }, loadChildren: () => import('./Empleados/empleados.module').then(m => m.EmpleadosModule) },
        { path: 'Reporte Factura', data: { breadcrumb: 'Reporte Factura' }, loadChildren: () => import('./Reporte Factura/ReporteFactura.module').then(m => m.ReporteFacturaModule) },
        { path: 'charts', data: { breadcrumb: 'charts' }, loadChildren: () => import('./charts/chartsdemo.module').then(m => m.ChartsDemoModule) },
        { path: 'Usuarios', data: { breadcrumb: 'Usuarios' }, loadChildren: () => import('./usuarios/usuarios.module').then(m => m.UsuariosModule) },
        { path: 'razas', data: { breadcrumb: 'razas' }, loadChildren: () => import('./razas/Razas.module').then(m => m.RazasModule) },
        { path: 'animales', data: { breadcrumb: 'animales' }, loadChildren: () => import('./animales/Animales.module').then(m => m.AnimalesModule) },
        { path: 'ManteniminetoXAnimal', data: { breadcrumb: 'ManteniminetoXAnimal' }, loadChildren: () => import('./ManteniminetoXAnimal/ManteniminetoPorAnimal.module').then(m => m.MantenimientoPorAnimalModule) },
        { path: 'RolesPorPantalla', data: { breadcrumb: 'RolesPorPantalla' }, loadChildren: () => import('./RolesPorPantallas/RolesPorPantallas.module').then(m => m.RolesPorPantallaModule) },
        { path: 'Municipios', data: { breadcrumb: 'Municipios' }, loadChildren: () => import('./Municipios/Municipios.module').then(m => m.MunicipiosModule) },
        { path: 'Mantenimineto', data: { breadcrumb: 'RolesPorPantalla' }, loadChildren: () => import('./Mantenimineto/Mantenimiento.module').then(m => m.MantenimientoModule) },
        { path: 'Especies', data: { breadcrumb: 'especies' }, loadChildren: () => import('./Especies/especies.module').then(m => m.especiesModule) },
        { path: 'cuidadosplantas', data: { breadcrumb: 'cuidadosplantas' }, loadChildren: () => import('./cuidadosplantas/cuidadosplantas.module').then(m => m.CuidadosPlantasModule) },
        { path: 'visitantes', data: { breadcrumb: 'visitantes' }, loadChildren: () => import('./visitantes/visitantes.module').then(m => m.visitantesModule) },
        { path: 'areaszoologicas', data: { breadcrumb: 'areaszoologicas' }, loadChildren: () => import('./areaszoologicas/areaszoologicas.module').then(m => m.AreasZoologicasModule) },
        { path: 'areasbotanicas', data: { breadcrumb: 'areasbotanicas' }, loadChildren: () => import('./areasbotanicas/areasbotanicas.module').then(m => m.AreasBotanicasModule) },
        { path: 'alimentacion', data: { breadcrumb: 'alimentacion' }, loadChildren: () => import('./alimentacion/alimentacion.module').then(m => m.AlimentacionModule) },
        { path: 'habitat', data: { breadcrumb: 'habitat' }, loadChildren: () => import('./habitat/habitat.module').then(m => m.HabitatModule) },
        { path: 'cargos', data: { breadcrumb: 'cargos' }, loadChildren: () => import('./cargos/cargos.module').then(m => m.cargosModule) },
        { path: 'departamentos', data: { breadcrumb: 'departamentos' }, loadChildren: () => import('./departamentos/departamentos.module').then(m => m.departamentosModule) },
        { path: 'TiposDeMantenimiento', data: { breadcrumb: 'TiposDeMantenimiento' }, loadChildren: () => import('./TipoDeMantenimiento/TiposDeMantenimiento.module').then(m => m.TiposDeMantenimientosModule) },
        { path: 'Plantas', data: { breadcrumb: 'Plantas' }, loadChildren: () => import('./Plantas/Plantas.module').then(m => m.PlantasModule) },
        { path: 'MetodoDePago', data: { breadcrumb: 'MetodoDePago' }, loadChildren: () => import('./MetodoDePago/MetodoPago.module').then(m => m.MetodoPagoModule) },
        { path: 'EstadoCivil', data: { breadcrumb: 'EstadoCivil' }, loadChildren: () => import('./EstadoCivil/EstadoCivil.module').then(m => m.EstadoCivilModule) },
        { path: '**', redirectTo: '/notfound' }
    ])],
    exports: [RouterModule]
})
export class UIkitRoutingModule { }
