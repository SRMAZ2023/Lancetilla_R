export class AnimalViewModel {

    constructor(
        public anim_Id?: number,
        public anim_Nombre?: string,
        public anim_NombreCientifico?: string,
        public anim_Reino?: string,
        public habi_Id?: number,
        public habi_Descripcion?: string,
        public arzo_Id?: number,
        public arzo_Descripcion?: string,
        public alim_Id?: number,
        public alim_Descripcion?: string,
        public espe_Id?: number,
        public espe_Descripcion?: string,
        public usua_UserCreaNombre?: string,
        public anim_UserCreacion?: number,
        public anim_FechaCreacion?: string,
        public usua_UserModiNombre?: number,
        public anim_UserModificacion?: number,
        public anim_FechaModificacion?: string,
        public anim_Estado?: boolean
    ){}

}

export class AnimalCrud {

    constructor(
        public anim_Id?: number,
        public anim_Nombre?: string,
        public anim_NombreCientifico?: string,
        public anim_Reino?: string,
        public habi_Id?: number,
        public habi_Descripcion?: string,
        public arzo_Id?: number,
        public arzo_Descripcion?: string,
        public alim_Id?: number,
        public alim_Descripcion?: string,
        public espe_Id?: number,
        public espe_Descripcion?: string,
        public anim_UserCreacion?: number,
        public anim_UserModificacion?: number,
    ){}

}