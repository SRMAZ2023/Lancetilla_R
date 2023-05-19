using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class CargosViewModel
    {

        public int carg_Id { get; set; }
        public string carg_Descripcion { get; set; }
        public int? carg_UserCreacion { get; set; }
        public int? carg_UserModificacion { get; set; }
      
    }
}
