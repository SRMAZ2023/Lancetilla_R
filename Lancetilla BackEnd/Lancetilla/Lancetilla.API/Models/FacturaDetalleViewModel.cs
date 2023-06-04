using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class FacturaDetalleViewModel
    {

        public int fade_Id { get; set; }
        public int fact_Id { get; set; }
        public int tick_Id { get; set; }
        public int fade_Cantidad { get; set; }
        public decimal fade_Total { get; set; }
        public int? fade_UserCreacion { get; set; }
      
        public int? fade_UserModificacion { get; set; }
      



    }
}
