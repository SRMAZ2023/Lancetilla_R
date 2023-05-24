import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { LayoutService } from './service/app.layout.service';

@Component({
    selector: 'app-menu',
    templateUrl: './app.menu.component.html'
})
export class AppMenuComponent implements OnInit {

    model: any[] = [];

    constructor(public layoutService: LayoutService) { }

    ngOnInit() {
        this.model = [
            {
                label: 'Home',
                items: [
                    { label: 'Dashboard', icon: 'pi pi-fw pi-home', routerLink: ['/'] }
                ]
            },
            {
                label: 'UI Components',
                items: [
                    { label: 'Empleados', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/Empleados'] },
                    { label: 'Usuarios', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/Usuarios'] },
                    { label: 'Manteniminto', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/Mantenimineto'] },
                    { label: 'Especies', icon: 'pi pi-fw pi-id-card', routerLink: ['/uikit/Especies'] },
                    { label: 'Visitantes', icon: 'pi pi-fw pi-id-card', routerLink: ['/uikit/visitantes'] },
                    { label: 'Cuidado de Plantas', icon: 'pi pi-fw pi-id-card', routerLink: ['/uikit/cuidadosplantas'] },
                    { label: 'Áreas Zoológicas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/areaszoologicas'] },
                    { label: 'Áreas Botánica', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/areasbotanicas'] },
                    { label: 'Hábitat', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/habitat'] },
                    { label: 'Alimentacion', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/alimentacion'] },
                    { label: 'Cargos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/cargos'] },
                    { label: 'Departamentos', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/departamentos'] },
                    { label: 'Tipos De Mantenimiento', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/TiposDeMantenimiento'] },
                    { label: 'Plantas', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/Plantas'] },
                    { label: 'Metodo De Pago', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/MetodoDePago'] },
                    { label: 'Estado Civil', icon: 'pi pi-fw pi-bookmark', routerLink: ['/uikit/EstadoCivil'] },
                ]
            },
            {
                label: 'Prime Blocks',
                items: [
                    { label: 'Free Blocks', icon: 'pi pi-fw pi-eye', routerLink: ['/blocks'], badge: 'NEW' },
                    { label: 'All Blocks', icon: 'pi pi-fw pi-globe', url: ['https://www.primefaces.org/primeblocks-ng'], target: '_blank' },
                ]
            },
            {
                label: 'Utilities',
                items: [
                    { label: 'PrimeIcons', icon: 'pi pi-fw pi-prime', routerLink: ['/utilities/icons'] },
                    { label: 'PrimeFlex', icon: 'pi pi-fw pi-desktop', url: ['https://www.primefaces.org/primeflex/'], target: '_blank' },
                ]
            },
            {
                label: 'Pages',
                icon: 'pi pi-fw pi-briefcase',
                items: [
                    {
                        label: 'Landing',
                        icon: 'pi pi-fw pi-globe',
                        routerLink: ['/landing']
                    },
                    {
                        label: 'Auth',
                        icon: 'pi pi-fw pi-user',
                        items: [
                            {
                                label: 'Login',
                                icon: 'pi pi-fw pi-sign-in',
                                routerLink: ['/auth/login']
                            },
                            {
                                label: 'Error',
                                icon: 'pi pi-fw pi-times-circle',
                                routerLink: ['/auth/error']
                            },
                            {
                                label: 'Access Denied',
                                icon: 'pi pi-fw pi-lock',
                                routerLink: ['/auth/access']
                            }
                        ]
                    },
                    {
                        label: 'Crud',
                        icon: 'pi pi-fw pi-pencil',
                        routerLink: ['/pages/crud']
                    },
                    {
                        label: 'Timeline',
                        icon: 'pi pi-fw pi-calendar',
                        routerLink: ['/pages/timeline']
                    },
                    {
                        label: 'Not Found',
                        icon: 'pi pi-fw pi-exclamation-circle',
                        routerLink: ['/notfound']
                    },
                    {
                        label: 'Empty',
                        icon: 'pi pi-fw pi-circle-off',
                        routerLink: ['/pages/empty']
                    },
                ]
            },
            {
                label: 'Hierarchy',
                items: [
                    {
                        label: 'Submenu 1', icon: 'pi pi-fw pi-bookmark',
                        items: [
                            {
                                label: 'Submenu 1.1', icon: 'pi pi-fw pi-bookmark',
                                items: [
                                    { label: 'Submenu 1.1.1', icon: 'pi pi-fw pi-bookmark' },
                                    { label: 'Submenu 1.1.2', icon: 'pi pi-fw pi-bookmark' },
                                    { label: 'Submenu 1.1.3', icon: 'pi pi-fw pi-bookmark' },
                                ]
                            },
                            {
                                label: 'Submenu 1.2', icon: 'pi pi-fw pi-bookmark',
                                items: [
                                    { label: 'Submenu 1.2.1', icon: 'pi pi-fw pi-bookmark' }
                                ]
                            },
                        ]
                    },
                    {
                        label: 'Submenu 2', icon: 'pi pi-fw pi-bookmark',
                        items: [
                            {
                                label: 'Submenu 2.1', icon: 'pi pi-fw pi-bookmark',
                                items: [
                                    { label: 'Submenu 2.1.1', icon: 'pi pi-fw pi-bookmark' },
                                    { label: 'Submenu 2.1.2', icon: 'pi pi-fw pi-bookmark' },
                                ]
                            },
                            {
                                label: 'Submenu 2.2', icon: 'pi pi-fw pi-bookmark',
                                items: [
                                    { label: 'Submenu 2.2.1', icon: 'pi pi-fw pi-bookmark' },
                                ]
                            },
                        ]
                    }
                ]
            },
            {
                label: 'Get Started',
                items: [
                    {
                        label: 'Documentation', icon: 'pi pi-fw pi-question', routerLink: ['/documentation']
                    },
                    {
                        label: 'View Source', icon: 'pi pi-fw pi-search', url: ['https://github.com/primefaces/sakai-ng'], target: '_blank'
                    }
                ]
            }
        ];
    }
}
