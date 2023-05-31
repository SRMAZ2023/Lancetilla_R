export class RazasViewModel {
    constructor(
        public raza_Id?: number,
        public raza_Descripcion?: string,
        public raza_NombreCientifico?: string,
        public rein_Id?: number,
        public habi_Id?: number,
        public espe_Id?: number,
        public rein_Descripcion?: string,
        public espe_Descripcion?: string,
        public habi_Descripcion?: string,
        public usua_UserCreaNombre?: string,
        public raza_UserCreacion?: number,
        public raza_FechaCreacion?: string,
        public usua_UserModiNombre?: string,
        public raza_UserModificacion?: number,
        public raza_FechaModificacion?: string,
        public raza_Estado?: boolean
    ) { }
}
