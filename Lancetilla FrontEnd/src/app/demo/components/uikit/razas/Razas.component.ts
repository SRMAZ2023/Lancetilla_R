import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Table } from 'primeng/table';
import { PlantasService } from 'src/app/demo/service/Plantas.service';
import { PlantasViewModel } from 'src/app/demo/Models/PlantasViewModel';
import { TiposPlantasService } from 'src/app/demo/service/TiposPlantas.service';
import { AreaBotanicaViewModel } from 'src/app/demo/Models/AreaBotanicaViewModel';
import { TiposPlantasViewModel } from 'src/app/demo/Models/TiposPlantasViewModel';
import { AreaBotanicaService } from 'src/app/demo/service/AreaBotanica.service';
import { RazasService } from 'src/app/demo/service/Razas.service';
import { ReinosService } from 'src/app/demo/service/Reinos.service';
import { HabitatService } from 'src/app/demo/service/Habitat.service';
import { Especies } from 'src/app/demo/api/product';
import { ProductService } from 'src/app/demo/service/product.service';
import { HabitatViewModel } from 'src/app/demo/Models/HabitatViewModel';
import { ReinosViewModel } from 'src/app/demo/Models/ReinosViewModel';
import { RazasViewModel } from 'src/app/demo/Models/RazasViewModel';
import { Console } from 'console';
import { DatePipe } from '@angular/common';

import { LocalStorageService } from '../../../../local-storage.service';
import { Router, ActivatedRoute, Params } from '@angular/router';

//import { MetodoPagos } from 'src/app/demo/api/MetodoPagosViewModel';

@Component({
    templateUrl: './Razas.component.html',
    providers: [MessageService, RazasService, ReinosService, HabitatService, ProductService, DatePipe]
})
export class RazasComponent implements OnInit {

    //Dialogs
  
      public RazaDialog: boolean = false;
    

    EsAdmin: any;
    Permiso: any;

    deleteRazaDialog: boolean = false;


    first: number = 0;
    rows: number = 10;

    cols: any[] = []; // Aquí debes definir las columnas de tu tabla

    onPageChange(event: any) {
        this.first = event.first;
        this.rows = event.rows;
    }
    onRowsPerPageChange() {
        this.first = 0; 
      }
  
    //Dialogs

    //datos
    datos: any = {};

    public Editar: boolean = false;
    Razas: RazasViewModel[] = [];
    Raza: RazasViewModel = {};
    habitat: HabitatViewModel [] = [];
    reinos: ReinosViewModel [] = [];
    especies: Especies [] = [];

    //validar espacio
    espacio: boolean = false;

    //Paginacion de el datatable
    selectedRazas: RazasViewModel[] = [];
    rowsPerPageOptions = [5, 10, 20];
    //Paginacion de el datatable

    //Validacion
    submitted: boolean = false;
 

    statuses: any[] = [];
    columns: any[] = []; 

    constructor(
        private _router: Router ,
        private localStorage: LocalStorageService,private RazasService: RazasService, 
        
        private datePipe: DatePipe, 
        private reinoservicio: ReinosService,
        private habitatservicio: HabitatService,
        private especieservicio: ProductService,
        private messageService: MessageService) {
            this.EsAdmin = this.localStorage.getItem('EsAdmin')
            this.Permiso = this.localStorage.getItem('Razas')
                 
            this.columns = []; 
    }

    toggleRow(row: any) {
        if (this.isRowExpanded(row)) {
          this.expandedRow = null;
        } else {
          this.expandedRow = row;
        }
      }
      
      isRowExpanded(row: any): boolean {
         return this.expandedRow === row;
      }
   

    expandedRows: RazasViewModel[] = [];
    expandedRow: any = null;

    Animales(razas: RazasViewModel) {
        this.Raza = { ...razas };
      
        var params = {
          "raza_Id": razas.raza_Id
        };
      
     
        this.RazasService.GetAnimalesXRaza(params).subscribe(
          Response => {
            this.datos = Response;
          
      
            // Verificar si la fila seleccionada ya está expandida
            const index = this.expandedRows.findIndex(row => row.raza_Id === this.Raza.raza_Id);
            if (index > -1) {
              // La fila está expandida, la contraemos para ocultarla
              this.expandedRows.splice(index, 1);
              this.expandedRow = null;
            } else {
              // Cerrar todas las filas expandidas
              this.expandedRows = [];
      
              // Expandir la fila seleccionada
              const selectedRow = this.Razas.find(row => row.raza_Id === this.Raza.raza_Id);
              if (selectedRow) {
                this.expandedRows.push(selectedRow);
                this.expandedRow = selectedRow;
              }
            }
          },
          error => {
            console.log("manzana");
          }
        );
      }
      
      formattedDate: string | undefined;

    ngOnInit() {

        if (this.EsAdmin  != null || this.EsAdmin  != undefined  ) {

            if (this.EsAdmin == false) {

                if (this.Permiso == false) {
                    this._router.navigate(['login']);
                }              
            }
    
        }else{

            this._router.navigate(['login']);
        }

        this.RazasService.getRazas().subscribe(
            Response => {
                 this.datos = Response;
        
             
                const uniqueAnimals = this.datos.filter((valorActual: { anim_Id: any; }, indiceActual: any, arreglo: { anim_Id: any; }[]) => {
                    return arreglo.findIndex((elemento: { anim_Id: any; }) => elemento.anim_Id === valorActual.anim_Id) === indiceActual;
                });
        
                this.Razas = uniqueAnimals;
        
               
                this.formattedDate = this.datePipe.transform(this.datos.maan_Fecha, 'yyyy-MM-dd')?.toString();
        
             },
            error => {
                console.log(error);
            }
        );
            this.loadData();
        this.cols = [
            { field: 'raza_Id', header: 'raza_Id' },
            { field: 'raza_Descripcion', header: 'raza_Descripcion' },
            { field: 'raza_NombreCientifico', header: 'raza_NombreCientifico' },
            { field: 'rein_Descripcion', header: 'rein_Descripcion' },
            { field: 'habi_Descripcion', header: 'habi_Descripcion' },
            { field: 'espe_Descripcion', header: 'espe_Descripcion' },

        ];
        //Modelo de los datos de la tabla

        this.reinoservicio.getReinos().subscribe(
            Response => {
                this.reinos = Response.map((item: { rein_Descripcion: any; rein_Id: any; }) => ({ label: item.rein_Descripcion, value: item.rein_Id }));

            },
             Error => {}
             )

             
        this.habitatservicio.getHabitat().subscribe(
            Response => {
                this.habitat = Response.map((item: { habi_Descripcion: any; habi_Id: any; }) => ({ label: item.habi_Descripcion, value: item.habi_Id }));

            },
             Error => {}
             )

             this.especieservicio.getEspecies().subscribe(
                Response => {
                    this.especies = Response.map((item: { espe_Descripcion: any; espe_Id: any; }) => ({ label: item.espe_Descripcion, value: item.espe_Id }));
    
                },
                 Error => {}
                 )

    }
    private loadData() {
        this.RazasService.getRazas().subscribe(
            Response => {
                console.log(Response);
                this.Razas = Response
            },
            error => (
                console.log(error)
            )
        );
    }

    //Metodo que desactiva el dialog
    hideDialog() {
        this.RazaDialog = false;
        this.submitted = false;
    }
    //Metodo que desactiva el dialog

    //Metodo que activa el dialog
    openNew() {
        console.log(this.RazaDialog);
        this.Raza = {};
        this.submitted = false;
        this.RazaDialog = true;
        console.log(this.RazaDialog);
      }
      
    //Metodo que activa el dialog


    //Toma los datos de ka tabla
    editRazas(Razas: RazasViewModel) {
        this.Editar = true;
        this.Raza = { ...Razas };
        this.RazaDialog = true;
    }
    //Toma los datos de ka tabla

    //Toma el id del item
    deleteRazas(Razas: PlantasViewModel) {
        this.deleteRazaDialog = true;
        this.Raza = { ...Razas };
    }
    //Toma el id del item

    //Confirma el eliminar
    confirmDelete() {
        this.deleteRazaDialog = false;
        var params = {
            "raza_Id": this.Raza.raza_Id,
            "raza_Descripcion": "",
            "raza_NombreCientifico": "",
            "rein_Id": 0,
            "habi_Id": 0,
            "espe_Id": 0,
            "meto_UserCreacion": 1,
            "meto_UserModificacion": 1
        }

        this.RazasService.DeleteRazas(params).subscribe(
            Response => {
                this.datos = Response;
                console.log(this.datos)
                if (this.datos.code == 500) {

                    this.messageService.add({ severity: 'info', summary: 'Aviso:', detail: this.datos.message, life: 3000 });

                } else if (this.datos.code == 200) {

                    this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                    this.Raza = {};
                    this.RazaDialog = false;
                    this.Razas= this.Razas.filter(val => val.raza_Id !== this.Raza.raza_Id);
                    this.loadData();


                } else {
                    this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                }
            },
            error => {
                console.log("manzana")
            }
        );

    }
    //Confirma el eliminar

    isInputEmptyOrWhitespace(value: string | undefined): boolean {
        if (value === undefined) {
            return true; // Tratar 'undefined' como un valor vacío
        }

        return value.trim() === '';
    }


    //Enviamos y editamos datos
    saveRazas() {
        this.submitted = true;

        var params = {
            "raza_Id": this.Raza.raza_Id,
            "raza_Descripcion": this.Raza.raza_Descripcion ? this.Raza.raza_Descripcion.trim() : '',
            "raza_NombreCientifico": this.Raza.raza_NombreCientifico ? this.Raza.raza_NombreCientifico.trim() : '',
            "rein_Id": this.Raza.rein_Id ? this.Raza.rein_Id: 0,
            "habi_Id": this.Raza.habi_Id ? this.Raza.habi_Id: 0,
            "espe_Id": this.Raza.espe_Id ? this.Raza.espe_Id: 0,
            "raza_UserCreacion": 1,
            "raza_UserModificacion": 1
        }

        console.log(params)
        if (this.Raza.raza_Descripcion?.trim() == '' || this.Raza.raza_NombreCientifico?.trim() == '' ) {
            this.espacio = true;
        }

        if (params.raza_Descripcion === "" || params.raza_NombreCientifico === "" || params.rein_Id == 0 || params.rein_Id == undefined || params.habi_Id == 0 || params.habi_Id == undefined || params.espe_Id == 0 || params.espe_Id == undefined) {
            this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'Los campos son requeridos.', life: 3000 });

        }
        else {
            //Validacion de params
            if (params.raza_Descripcion !== undefined &&
                params.raza_Descripcion.trim() !== '' &&
                params.raza_NombreCientifico !== undefined &&
                params.raza_NombreCientifico.trim() !== '' &&
                params.rein_Id != undefined &&
                params.rein_Id != 0 &&
                params.habi_Id != 0 &&
                params.habi_Id != 0 &&           
                params.espe_Id != 0 &&
                params.espe_Id !== undefined &&
                params.raza_UserModificacion !== undefined) {

                //Si insertara o editara
                if (!this.Editar) {

                    this.RazasService.postRazas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 409) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: this.datos.message, life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Raza = {};
                                this.RazaDialog = false;
                                this.loadData();


                            } else {
                                this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )

                } else {
                    this.RazasService.EditRazas(params).subscribe(
                        Response => {
                            this.datos = Response;
                            if (this.datos.code == 500) {

                                this.messageService.add({ severity: 'warn', summary: 'Advertencia:', detail: 'El código ya existe.', life: 3000 });

                            } else if (this.datos.code == 200) {

                                this.messageService.add({ severity: 'success', summary: 'Felicidades:', detail: this.datos.message, life: 3000 });
                                this.Raza = {};
                                this.RazaDialog= false;
                                this.loadData();


                            } else {
                                this.messageService.add({ severity: 'error', summary: 'Error:', detail: this.datos.message, life: 3000 });
                            }
                        },
                        error => {
                            console.log(error);
                        }
                    )

                }
            }
        }
        //Enviamos y editamos datos

    }



    //Buscador
    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }
    //Buscador

}
