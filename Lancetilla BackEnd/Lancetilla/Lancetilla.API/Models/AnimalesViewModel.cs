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
        public string anim_Codigo { get; set; }
        public string anim_Nombre { get; set; }
        public int raza_Id { get; set; }
        public string raza_Descripcion { get; set; }
        public int habi_Id { get; set; }
        public string habi_Descripcion { get; set; }
        public int rein_Id { get; set; }
        public string rein_Descripcion { get; set; }
        public int arzo_Id { get; set; }
        public string arzo_Descripcion { get; set; }
        public int alim_Id { get; set; }
        public string alim_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? anim_UserCreacion { get; set; }
        public DateTime? anim_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? anim_UserModificacion { get; set; }
        public DateTime? anim_FechaModificacion { get; set; }
        public bool? anim_Estado { get; set; }


    }


}

