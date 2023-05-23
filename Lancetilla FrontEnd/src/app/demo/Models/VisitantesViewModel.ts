export class VisitantesViewModel {
    constructor(
        public visi_Id?: number,
        public visi_Nombre?: string,
        public visi_RTN?: string,
        public visi_Sexos?: string,
        public usua_UserCreaNombre?:string,
        public visi_UserCreacion?: number,
        public visi_FechaCreacion?:string,
        public usua_UserModiNombre?: number,
        public visi_UserModificacion?: number,
        public visi_FechaModificacion?: string,
        public visi_Estado?: boolean
    ){}
}