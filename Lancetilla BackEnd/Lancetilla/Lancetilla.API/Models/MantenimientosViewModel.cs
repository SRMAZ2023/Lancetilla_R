using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class MantenimientosViewModel
    {

        public int mant_Id { get; set; }
        public string mant_Observaciones { get; set; }
        public int tima_Id { get; set; }


        [NotMapped]
        public string tima_Descripcion { get; set; }
     
        public int? mant_UserCreacion { get; set; }
          
        public int? mant_UserModificacion { get; set; }

    }
}


