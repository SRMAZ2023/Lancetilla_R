using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class MunicipiosViewModel
    {
        public string muni_Id { get; set; }
        public string muni_Descripcion { get; set; }

        [NotMapped]

        public string dept_Descripcion { get; set; }
        public string dept_Id { get; set; }
        public int? muni_UserCreacion { get; set; }

        public int? muni_UserModificacion { get; set; }


    }
}
