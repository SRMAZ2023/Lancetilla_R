using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class tbTiposCuidadosViewModel
    {

        public int ticu_Id { get; set; }
        public string ticu_Descripcion { get; set; }
        public int? ticu_UserCreacion { get; set; }
         public int? ticu_UserModificacion { get; set; }
 
    }
}
