export class UsuarioViewModel {
    constructor(
        public usua_Id?: number,
        public usua_NombreUsuario?: string,
        public empl_Id?: number,    
        public empl_Nombre?: string,
        public usua_Clave?: string,   
        public role_Id?: number,
        public role_Descripcion?: string,      
        public usua_EsAdmin?: string,
        public usua_UserCreacion?: number,
        public usua_UserModificacion?: number,   
        public usua_Admin?: boolean
    ) { }
}

export class UsuarioCrud {
    constructor(
        public usua_Id?: number,
        public usua_NombreUsuario?: string,
        public empl_Id?: number,    
        public empl_Nombre?: string,
        public usua_Clave?: string,   
        public role_Id?: number,
        public role_Descripcion?: string,      
        public usua_EsAdmin?: string,
        public usua_UserCreacion?: number,
        public usua_UserModificacion?: number,   
        public usua_Admin?: boolean
    ) { }

}