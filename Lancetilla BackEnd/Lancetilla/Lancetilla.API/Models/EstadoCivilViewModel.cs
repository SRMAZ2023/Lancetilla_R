using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class EstadoCivilViewModel
    {

        public int estc_Id { get; set; }
        public string estc_Descripcion { get; set; }
        public int? estc_UserCreacion { get; set; }
     
        public int? estc_UserModificacion { get; set; }
       
    }
}
