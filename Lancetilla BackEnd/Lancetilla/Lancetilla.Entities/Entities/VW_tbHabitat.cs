using System;
using System.Collections.Generic;

namespace Lancetilla.Entities.Entities
{
    public partial class VW_tbHabitat
    {
        public int habi_Id { get; set; }
        public string habi_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? habi_UserCreacion { get; set; }
        public DateTime? habi_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? habi_UserModificacion { get; set; }
        public DateTime? habi_FechaModificacion { get; set; }
        public bool? habi_Estado { get; set; }
    }
}
