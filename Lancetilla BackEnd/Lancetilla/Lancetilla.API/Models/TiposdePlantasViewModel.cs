using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public partial class TiposdePlantasViewModel
    {
        public int tipl_Id { get; set; }
        public string tipl_NombreComun { get; set; }
        public string tipl_NombreCientifico { get; set; }
        public int rein_Id { get; set; }
        public string rein_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? tipl_UserCreacion { get; set; }
        public DateTime? tipl_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? tipl_UserModificacion { get; set; }
        public DateTime? tipl_FechaModificacion { get; set; }
        public bool? tipl_Estado { get; set; }
    }
}
