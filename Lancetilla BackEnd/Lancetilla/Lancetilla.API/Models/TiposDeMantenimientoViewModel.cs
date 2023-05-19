using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class TiposDeMantenimientoViewModel
    {

        public int tima_Id { get; set; }
        public string tima_Descripcion { get; set; }
      
        public int? tima_UserCreacion { get; set; }
    
        public int? tima_UserModificacion { get; set; }
      
    }
}
