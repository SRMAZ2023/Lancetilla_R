using System;
using System.Collections.Generic;

namespace Lancetilla.Entities.Entities
{
    public partial class VW_tbRoles
    {
        public int role_Id { get; set; }
        public string role_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? role_UserCreacion { get; set; }
        public DateTime? role_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? role_UserModificacion { get; set; }
        public DateTime? role_FechaModificacion { get; set; }
        public bool? role_Estado { get; set; }
    }
}
