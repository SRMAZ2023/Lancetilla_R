﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbTiposCuidados
    {
        public tbTiposCuidados()
        {
            tbCuidadoPlanta = new HashSet<tbCuidadoPlanta>();
            tbCuidados = new HashSet<tbCuidados>();
        }

        public int ticu_Id { get; set; }
        public string ticu_Descripcion { get; set; }
        public int? ticu_UserCreacion { get; set; }
        public DateTime? ticu_FechaCreacion { get; set; }
        public int? ticu_UserModificacion { get; set; }
        public DateTime? ticu_FechaModificacion { get; set; }
        public bool? ticu_Estado { get; set; }

        public virtual tbUsuarios ticu_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios ticu_UserModificacionNavigation { get; set; }
        public virtual ICollection<tbCuidadoPlanta> tbCuidadoPlanta { get; set; }
        public virtual ICollection<tbCuidados> tbCuidados { get; set; }
    }
}