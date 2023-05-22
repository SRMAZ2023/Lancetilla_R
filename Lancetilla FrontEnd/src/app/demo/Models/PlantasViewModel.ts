export class PlantasViewModel {
    constructor(
        public plan_Id?: number,
        public plan_Nombre?: string,
        public plan_NombreCientifico?: string,
        public plan_Reino?: string,
        public arbo_Id?: number,
        public arbo_Descripcion?: string,
        public cuid_Id?: number,
        public cuid_Descripcion?: string,
        public cuid_Frecuencia?: string,
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
        public plan_Nombre?: string,
        public plan_NombreCientifico?: string,
        public plan_Reino?: string,
        public arbo_Id?: number,
        public arbo_Descripcion?: string,
        public cuid_Id?: number,
        public cuid_Descripcion?: string,
        public cuid_Frecuencia?: string,
        public plan_UserCreacion?: number,
        public plan_UserModificacion?: number
    ) { }

}