using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class HabitatViewModel
    {
        public int habi_Id { get; set; }
        public string habi_Descripcion { get; set; }
        [NotMapped]
        public string usua_UserCreaNombre { get; set; }
        public int? habi_UserCreacion { get; set; }
        public DateTime? habi_FechaCreacion { get; set; }
        [NotMapped]
        public string usua_UserModiNombre { get; set; }
        public int? habi_UserModificacion { get; set; }
        public DateTime? habi_FechaModificacion { get; set; }
        public bool? habi_Estado { get; set; }
    }
}
