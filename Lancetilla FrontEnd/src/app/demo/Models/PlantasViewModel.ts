export class PlantasViewModel {
    constructor(
        public plan_Id?: number,
        public plan_Codigo?: string,
        public arbo_Id?: number,
        public tipl_Id?: number,
        public arbo_Descripcion?: string,
        public tipl_Descripcion?: string,
        public usua_UserCreaNombre?: string,
        public plan_UserCreacion?: number,
        public plan_FechaCreacion?: string,
        public usua_UserModiNombre?: string,
        public plan_UserModificacion?: number,
        public plan_FechaModificacion?: string,
        public plan_Estado?: boolean
    ) { }
}
