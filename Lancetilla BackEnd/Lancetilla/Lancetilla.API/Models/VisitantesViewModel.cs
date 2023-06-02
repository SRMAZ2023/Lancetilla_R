using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class VisitantesViewModel
    {


        public int visi_Id { get; set; }
        public string visi_Nombres { get; set; }

        [NotMapped]
        public string visi_NombreCompleto { get; set; }
        public string visi_Apellido { get; set; }
        public string visi_RTN { get; set; }
        public string visi_Sexo { get; set; }
        public int? visi_UserCreacion { get; set; }
   
        public int? visi_UserModificacion { get; set; }
     

    }
}
