using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class RolesPorPantallaViewModel
    {

        public int ropa_Id { get; set; }
        public int role_Id { get; set; }
       
        [NotMapped]
        public string role_Descripcion { get; set; }

        public int pant_Id { get; set; }
        
        [NotMapped]
        public string pant_Descripcion { get; set; }
        public int? ropa_UserCreacion { get; set; }
      
        public int? ropa_UserModificacion { get; set; }
    

    }
}
