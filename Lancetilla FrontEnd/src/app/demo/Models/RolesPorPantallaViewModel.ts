export class RolesViewModel {
    constructor(
        public role_Id?: number,
        public role_Descripcion?: string,
         
        public usua_UserCreaNombre?: string,
        public role_UserCreacion?: number,
        public role_FechaCreacion?: string,
        public usua_UserModiNombre?: string,
        public role_UserModificacion?: number,
        public role_FechaModificacion?: string,
        public role_Estado?: boolean

        
     
    ) { }
}

export class RolesPorPantallaViewModel {
    constructor(
        public ropa_Id?: number,
        public role_Id?: number,
        public pant_Id?: number,
        
        public ropa_UserCreacion?: number,
        public ropa_FechaCreacion?: string,
        public ropa_UserModificacion?: number,
        public ropa_FechaModificacion?: string
     
    ) { }

}