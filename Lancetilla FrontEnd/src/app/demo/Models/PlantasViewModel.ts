export class PlantasViewModel {
    constructor(
        public plan_Id?: number,
        public plan_Codigo?: string,
        public rein_Id?: number,
        public rein_Descripcion?: string,
        public plan_Nombre?: string,
        public plan_NombreCientifico?: string,
        public arbo_Id?: number,
        public arbo_Descripcion?: string,
        public usua_UserCreaNombre?: string,
        public plan_UserCreacion?: number,
        public plan_FechaCreacion?: string,
        public usua_UserModiNombre?: string,
        public plan_UserModificacion?: number,
        public plan_FechaModificacion?: string,
        public plan_Estado?: boolean
    ) { }
}

export class PlantasCrud {
    constructor(
        public plan_Id?: number,
        public plan_Codigo?: string,

        public plan_Nombre?: string,
        public plan_NombreCientifico?: string,
        public rein_Id?: string,
        public arbo_Id?: number,
        public arbo_Descripcion?: string,
        public rein_Descripcion?: string,
        public plan_UserCreacion?: number,
        public plan_UserModificacion?: number
    ) { }

}