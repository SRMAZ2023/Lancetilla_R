using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class PlantasViewModel
    {
        public int plan_Id { get; set; }
        public string plan_Codigo { get; set; }
        public int tipl_Id { get; set; }
        public string tipl_NombreComun { get; set; }
        public string tipl_NombreCientifico { get; set; }
        public int arbo_Id { get; set; }
        public string arbo_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? plan_UserCreacion { get; set; }
        public DateTime? plan_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? plan_UserModificacion { get; set; }
        public DateTime? plan_FechaModificacion { get; set; }
        public bool? plan_Estado { get; set; }

    }
}
