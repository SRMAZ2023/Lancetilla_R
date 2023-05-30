using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public partial class ReinosViewModel
    {
        public int rein_Id { get; set; }
        public string rein_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? rein_UserCreacion { get; set; }
        public DateTime? rein_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? rein_UserModificacion { get; set; }
        public DateTime? rein_FechaModificacion { get; set; }
        public bool? rein_Estado { get; set; }
    }
}
