using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Models
{
    public class EmpleadosViewModel
    {

        public int empl_Id { get; set; }
        public string empl_Nombre { get; set; }

        public string empl_Apellido { get; set; }
        public string empl_Identidad { get; set; }
        public DateTime empl_FechaNacimiento { get; set; }
        public string empl_Direccion { get; set; }
        public string empl_Sexo { get; set; }
        public string empl_Sexos { get; set; }
        public string empl_Telefono { get; set; }
        public int estc_Id { get; set; }

        [NotMapped]
        public string estc_Descripcion { get; set; }
        public int carg_Id { get; set; }

        [NotMapped]
        public string carg_Descripcion { get; set; }
        public string muni_Id { get; set; }

        [NotMapped]
        public string muni_Descripcion { get; set; }
        public int dept_Id { get; set; }

        [NotMapped]
        public string dept_Descripcion { get; set; }

        [NotMapped]
        public string usua_UserCreaNombre { get; set; }
        public int? empl_UserCreacion { get; set; }
      

        [NotMapped]
        public string usua_UserModiNombre { get; set; }
        public int? empl_UserModificacion { get; set; }
     
        

    }
}
