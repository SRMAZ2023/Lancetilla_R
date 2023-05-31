using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class FacturasViewModel
    {


        public int fact_Id { get; set; }
        public int empl_Id { get; set; }
        public int visi_Id { get; set; }
        public int meto_Id { get; set; }
        public DateTime fact_Fecha { get; set; }

        [NotMapped]
        public string visi_Nombres { get; set; }

        [NotMapped]
        public string visi_RTN { get; set; }

        [NotMapped]
        public string visi_Sexo { get; set; }

        [NotMapped]
        public string meto_Descripcion { get; set; }

        [NotMapped]
        public string empl_Nombre { get; set; }

        [NotMapped]
        public string tick_Descripcion { get; set; }

        [NotMapped]
        public string tick_Precio { get; set; }

        [NotMapped]
        public string fade_Cantidad { get; set; }

        [NotMapped]
        public string fade_Total { get; set; }




        public int? fact_UserCreacion { get; set; }
    
        public int? fact_UserModificacion { get; set; }
    
        public bool? fact_Estado { get; set; }

    }
}
