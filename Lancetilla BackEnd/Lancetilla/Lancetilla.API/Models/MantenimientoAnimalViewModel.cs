using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class MantenimientoAnimalViewModel
    {

        public int maan_Id { get; set; }
       
        public int anim_Id { get; set; }
        [NotMapped]
        public string anim_Nombre { get; set; }

        public DateTime maan_Fecha { get; set; }
       
        public int mant_Id { get; set; }   
        [NotMapped]
        public string mant_Observaciones { get; set; }
     
        public int tima_Id { get; set; }      
        [NotMapped]
        public string tima_Descripcion { get; set; }
      
        public int? maan_UserCreacion { get; set; }
     
  
        public int? maan_UserModificacion { get; set; }
     
  

    }
}
