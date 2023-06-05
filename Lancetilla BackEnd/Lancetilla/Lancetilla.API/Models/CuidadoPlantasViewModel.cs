using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class CuidadoPlantasViewModel
    {

        public int cupl_Id { get; set; }
        public int plan_Id { get; set; }
        public int ticu_Id { get; set; }

        public int arbo_Id { get; set; }

        public string cupl_Fecha { get; set; }
        public int? cupl_UserCreacion { get; set; }
        public int? cupl_UserModificacion { get; set; }

    }
}
