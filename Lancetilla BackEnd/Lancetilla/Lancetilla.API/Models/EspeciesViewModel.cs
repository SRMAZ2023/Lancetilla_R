using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class EspeciesViewModel
    {

        public int espe_Id { get; set; }
        public string espe_Descripcion { get; set; }
        public int? espe_UserCreacion { get; set; }    
        public int? espe_UserModificacion { get; set; }
    }
}
