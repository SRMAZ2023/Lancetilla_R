using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
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


 

        [NotMapped]
        public string Ticket_Zoologico { get; set; }


        [NotMapped]
        public string Ticket_JardinBotanico { get; set; }

        [NotMapped]
        public string meto_Descripcion { get; set; }

        public int? fade_UserModificacion { get; set; }
      



    }
}
