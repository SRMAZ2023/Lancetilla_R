using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class AnimalesViewModel
    {
        public int anim_Id { get; set; }
        public string anim_Nombre { get; set; }
        public string anim_NombreCientifico { get; set; }
        public string anim_Reino { get; set; }
        public int habi_Id { get; set; }

        [NotMapped]
        public string habi_Descripcion { get; set; }
        public int arzo_Id { get; set; }

        [NotMapped]
        public string arzo_Descripcion { get; set; }
        public int alim_Id { get; set; }

        [NotMapped]
        public string alim_Descripcion { get; set; }
        public int espe_Id { get; set; }

        [NotMapped]
        public string espe_Descripcion { get; set; }

        [NotMapped]
        public string usua_UserCreaNombre { get; set; }
        public int? anim_UserCreacion { get; set; }

        [NotMapped]
        public string usua_UserModiNombre { get; set; }
        public int? anim_UserModificacion { get; set; }
     
       
    }


}

