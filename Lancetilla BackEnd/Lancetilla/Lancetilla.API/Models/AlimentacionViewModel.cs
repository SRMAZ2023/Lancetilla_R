using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class AlimentacionViewModel
    {

        public int alim_Id { get; set; }
        public string alim_Descripcion { get; set; }
        public int? alim_UserCreacion { get; set; }
        
        public int? alim_UserModificacion { get; set; }
      
    }
}
