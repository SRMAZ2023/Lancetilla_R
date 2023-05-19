using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class MetodosDePagoViewModel
    {

        public int meto_Id { get; set; }
        public string meto_Descripcion { get; set; }
        public int? meto_UserCreacion { get; set; }
     
        public int? meto_UserModificacion { get; set; }
    
      

    }
}
