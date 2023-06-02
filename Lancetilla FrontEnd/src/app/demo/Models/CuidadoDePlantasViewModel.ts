export class CuidadoDePlantasViewModel {
     constructor(
        public cuid_Id?: number,
        public cuid_Descripcion?: string,
        public cuid_Frecuencia?: string,
        public usua_UserCreaNombre?:string,
        public cuid_UserCreacion?: number,
        public cuid_FechaCreacion?:string,
        public usua_UserModiNombre?: number,
        public cuid_UserModificacion?: number,
        public cuid_FechaModificacion?: string,
        public cuid_Estado?: boolean
    ){}
}