export class CuidadoPlantasViewModel {
    constructor(
    public cupl_Id?: number,
    public plan_Id?: number,
    public plan_Codigo?:string,
    public tipl_Id?: number,
    public arbo_Id?: number,
    public tipl_NombreComun?: string,
    public tipl_NombreCientifico?: string,
    public ticu_Id?: number,
    public ticu_Descripcion?: string,
    public cupl_Fecha?: string,
    public cupl_UserCreacion?: number,
    public cupl_FechaCreacion?: string,
    public usua_UserCreaNombre?:string,
     public usua_UserModiNombre?: string,
     public cupl_Estado?: boolean
    ){}
}