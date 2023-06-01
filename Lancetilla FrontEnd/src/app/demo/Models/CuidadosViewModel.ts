export class CuidadosViewModel {
    constructor(
        public cuid_Id?: number,
        public cuid_Observacion?: string,
        public ticu_Id?: number,
        public ticu_Descripcion?: string,
        public usua_UserCreaNombre?: string,
        public cuid_UserCreacion?: number,
        public cuid_FechaCreacion?: string,
        public usua_UserModiNombre?: number,
        public cuid_UserModificacion?: number,
        public cuid_FechaModificacion?: string,
        public cuid_Estado?: boolean
    ){}
}