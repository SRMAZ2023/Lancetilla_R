using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class MunicipiosViewModel
    {
        public int muni_Id { get; set; }
        public string muni_Descripcion { get; set; }
        public int dept_Id { get; set; }
        public int? muni_UserCreacion { get; set; }
    }
}
