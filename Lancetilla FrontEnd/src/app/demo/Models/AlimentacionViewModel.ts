export class AlimentacionViewModel  {

    constructor(
        public alim_Id?: number,
        public alim_Descripcion?:string,
        public usua_UserCreaNombre?:string,
        public alim_UserCreacion?: 1,
        public alim_FechaCreacion?:string,
        public usua_UserModiNombre?: number,
        public alim_UserModificacion?: number,
        public alim_FechaModificacion?: string,
        public alim_Estado?: boolean
    ){}

}