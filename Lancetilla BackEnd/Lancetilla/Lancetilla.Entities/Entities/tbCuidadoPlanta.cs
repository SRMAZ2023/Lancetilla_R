﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbCuidadoPlanta
    {
        public int cupl_Id { get; set; }
        public int plan_Id { get; set; }
        public int ticu_Id { get; set; }
        public string cupl_Fecha { get; set; }
        public int? cupl_UserCreacion { get; set; }
        public DateTime? cupl_FechaCreacion { get; set; }
        public int? cupl_UserModificacion { get; set; }
        public DateTime? cupl_FechaModificacion { get; set; }
        public bool? cupl_Estado { get; set; }

        public virtual tbUsuarios cupl_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios cupl_UserModificacionNavigation { get; set; }
        public virtual tbPlantas plan { get; set; }
        public virtual tbTiposCuidados ticu { get; set; }
    }
}