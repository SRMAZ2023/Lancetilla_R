using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class CuidadosDePlantaViewModel
    {

        public int cuid_Id { get; set; }
        public string cuid_Descripcion { get; set; }
        public string cuid_Frecuencia { get; set; }
        public int? cuid_UserCreacion { get; set; }   
        public int? cuid_UserModificacion { get; set; }
    
    
    }
}
