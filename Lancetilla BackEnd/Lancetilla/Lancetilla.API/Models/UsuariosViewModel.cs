using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class UsuariosViewModel
    {

        public int usua_Id { get; set; }
        [NotMapped]
        public string usua_NombreUsuario { get; set; }
        public int empl_Id { get; set; }
        [NotMapped]
        public string empl_Nombre { get; set; }
        public string usua_Contraseña { get; set; }
        public int role_Id { get; set; }
        [NotMapped]
        public string role_Descripcion { get; set; }
        public bool usua_Admin { get; set; }
        public string usua_EsAdmin { get; set; }
      
        public int? usua_UserCreacion { get; set; }
            
        public int? usua_UserModificacion { get; set; }
     
   
    }

}

