export class EmpleadosViewModel {

    constructor(

        public empl_Id?: number,
        public empl_Nombre?: string,
        public empl_Apellido?: string,
        public empl_Identidad?: string,
        public empl_FechaNacimiento?: Date,
        public empl_Direccion?: string,
        public empl_Sexo?: string,
        public empl_Sexos?: string,
        public empl_Telefono?: string,
        public estc_Id?: number,//1
        public estc_Descripcion?: string,
        public carg_Id?: number,//2
        public carg_Descripcion?: string,
        public muni_Id?: string,//3
        public muni_Descripcion?: string,
        public dept_Id?: string,//4
        public dept_Descripcion?: string,
        public usua_UserCreaNombre?: string,
        public empl_UserCreacion?: number,
        public usua_UserModiNombre?: string,
        public empl_UserModificacion?: number

    ) { }

}

export class Municipios {

    constructor(

        public muni_Id?: string,
        public muni_Descripcion?: string,
        public dept_Descripcion?: string,
        public dept_Id?: string,
        public muni_UserCreacion?: number

    ) { }


}