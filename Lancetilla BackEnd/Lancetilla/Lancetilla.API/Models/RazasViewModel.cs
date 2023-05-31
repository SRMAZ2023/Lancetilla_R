using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class RazasViewModel
    {
        public int raza_Id { get; set; }
        public string raza_Descripcion { get; set; }
        public string raza_NombreCientifico { get; set; }
        public int habi_Id { get; set; }
        public string habi_Descripcion { get; set; }
        public int espe_Id { get; set; }
        public string espe_Descripcion { get; set; }
        public int rein_Id { get; set; }
        public string rein_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? raza_UserCreacion { get; set; }
        public DateTime? raza_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? raza_UserModificacion { get; set; }
        public DateTime? raza_FechaModificacion { get; set; }
        public bool? raza_Estado { get; set; }
    }
}
