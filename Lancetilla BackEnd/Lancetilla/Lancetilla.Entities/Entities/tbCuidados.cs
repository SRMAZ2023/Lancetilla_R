﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbCuidados
    {
        public tbCuidados()
        {
            tbPlantas = new HashSet<tbPlantas>();
        }

        public int cuid_Id { get; set; }
        public string cuid_Descripcion { get; set; }
        public string cuid_Frecuencia { get; set; }
        public int? cuid_UserCreacion { get; set; }
        public DateTime? cuid_FechaCreacion { get; set; }
        public int? cuid_UserModificacion { get; set; }
        public DateTime? cuid_FechaModificacion { get; set; }
        public bool? cuid_Estado { get; set; }

        public virtual tbUsuarios cuid_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios cuid_UserModificacionNavigation { get; set; }
        public virtual ICollection<tbPlantas> tbPlantas { get; set; }
    }
}