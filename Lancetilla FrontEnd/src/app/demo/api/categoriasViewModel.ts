export class Categorias {
    constructor(
        public cate_Id?: number,
        public cate_Nombre?: string,
        public cate_Estado?: boolean,
        public cate_UsuarioCreador?: number,
        public cate_FechaCreacion?: Date,
        public cate_UsuarioModificador?: number,
        public cate_FechaModificacion?: Date,
    ) {

    }
}