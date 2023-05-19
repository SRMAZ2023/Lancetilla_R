using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class RolViewModel
    {

        public int role_Id { get; set; }
        public string role_Descripcion { get; set; }
        public int? role_UserCreacion { get; set; }
       
        public int? role_UserModificacion { get; set; }
  
      
    }
}
