export class TiposPlantasViewModel {
    constructor(
        public tipl_Id?: number,
        public tipl_NombreComun?: string,
        public tipl_NombreCientifico?: string,
        public rein_Id?: number,
        public rein_Descripcion?: string,
         
        public tipl_UserCreaNombre?: string,
        public tipl_UserCreacion?: number,
        public tipl_FechaCreacion?: string,
        public tipl_UserModiNombre?: string,
        public tipl_UserModificacion?: number,
        public tipl_FechaModificacion?: string,
        public tipl_Estado?: boolean

        
     
    ) { }
}