using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class CuidadosViewModel
    {

        public int cuid_Id { get; set; }
        public string cuid_Observacion { get; set; }
        public int ticu_Id { get; set; }
        public string ticu_Descripcion { get; set; }
        public int? cuid_UserCreacion { get; set; }
        public DateTime? cuid_FechaCreacion { get; set; }
        public int? cuid_UserModificacion { get; set; }
        public DateTime? cuid_FechaModificacion { get; set; }

    }
}
