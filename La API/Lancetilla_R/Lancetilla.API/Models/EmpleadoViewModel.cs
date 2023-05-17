﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ServiciosPublicitarios.API.models
{
    public class EmpleadoViewModel
    {
        public int empe_Id { get; set; }
        public string empe_Nombres { get; set; }
        public string empe_Apellidos { get; set; }
        public string empe_Identidad { get; set; }
        public DateTime empe_FechaNacimiento { get; set; }
        public string empe_Sexo { get; set; }
        public int eciv_Id { get; set; }
        public int muni_Id { get; set; }
        public string empe_DireccionExacta { get; set; }
        public string empe_Telefono { get; set; }
        public int sucu_Id { get; set; }
        public int carg_Id { get; set; }
        public int empe_UsuCreacion { get; set; }
        public DateTime empe_FechaCreacion { get; set; }
        public int? empe_UsuModificacion { get; set; }
        public DateTime? empe_FechaModificacion { get; set; }
        public bool? empe_Estado { get; set; }
    }
}
