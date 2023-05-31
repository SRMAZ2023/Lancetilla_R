export class FacturasViewModel {
    constructor(
        public fact_Id?: number,
        public empl_Id?: number,        
        public visi_Id?: number,
        public meto_Id?: number,
    
        public fact_UserCreacion?: number,
        public fact_UserModificacion?: number,
        public fact_Fecha?: string,

        public empl_Nombre?: string,
        public meto_Descripcion?: string,
        public visi_Nombres?: string,
        public visi_RTN?: string,
        public visi_Sexo?: string,
      
        public tick_Descripcion?: string,
        public tick_Precio?: string,
       
        public fade_Cantidad?: string,
        public fade_Total?: string,
        public fact_Estado?: boolean
    ) { }
}
