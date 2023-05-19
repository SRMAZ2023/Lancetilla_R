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
        public string plan_Nombre { get; set; }
        public string plan_NombreCientifico { get; set; }
        public string plan_Reino { get; set; }
        public int arbo_Id { get; set; }

        [NotMapped]
        public string arbo_Descripcion { get; set; }
        public int cuid_Id { get; set; }
        [NotMapped]
        public string cuid_Descripcion { get; set; }
        [NotMapped]
        public string cuid_Frecuencia { get; set; }
       
        public int? plan_UserCreacion { get; set; }
      
 
        public int? plan_UserModificacion { get; set; }
 
    }
}
