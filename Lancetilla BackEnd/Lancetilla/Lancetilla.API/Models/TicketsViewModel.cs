using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class TicketsViewModel
    {

        public int tick_Id { get; set; }
        public string tick_Descripcion { get; set; }
        public decimal tick_Precio { get; set; }
       
        public int? tick_UserCreacion { get; set; }
      
        public int? tick_UserModificacion { get; set; }
      
    }
}
