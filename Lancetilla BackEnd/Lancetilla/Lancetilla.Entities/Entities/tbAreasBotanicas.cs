﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbAreasBotanicas
    {
        public tbAreasBotanicas()
        {
            tbPlantas = new HashSet<tbPlantas>();
        }

        public int arbo_Id { get; set; }
        public string arbo_Descripcion { get; set; }
        public int? arbo_UserCreacion { get; set; }
        public DateTime? arbo_FechaCreacion { get; set; }
        public int? arbo_UserModificacion { get; set; }
        public DateTime? arbo_FechaModificacion { get; set; }
        public bool? arbo_Estado { get; set; }

        public virtual tbUsuarios arbo_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios arbo_UserModificacionNavigation { get; set; }
        public virtual ICollection<tbPlantas> tbPlantas { get; set; }
    }
}