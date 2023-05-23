using System;
using System.Collections.Generic;

namespace Lancetilla.Entities.Entities
{
    public partial class VW_tbRolesPantalla_INDEX
    {
        public int ropa_Id { get; set; }
        public int role_Id { get; set; }
        public string role_Descripcion { get; set; }
        public int pant_Id { get; set; }
        public string pant_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? ropa_UserCreacion { get; set; }
        public DateTime? ropa_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? ropa_UserModificacion { get; set; }
        public DateTime? ropa_FechaModificacion { get; set; }
    }
}
