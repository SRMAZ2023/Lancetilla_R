﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbFacturas
    {
        public int fact_Id { get; set; }
        public int empl_Id { get; set; }
        public int visi_Id { get; set; }
        public int meto_Id { get; set; }
        public DateTime fact_Fecha { get; set; }
        public int? fact_UserCreacion { get; set; }
        public DateTime? fact_FechaCreacion { get; set; }
        public int? fact_UserModificacion { get; set; }
        public DateTime? fact_FechaModificacion { get; set; }
        public bool? fact_Estado { get; set; }

        public virtual tbEmpleados empl { get; set; }
        public virtual tbUsuarios fact_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios fact_UserModificacionNavigation { get; set; }
        public virtual tbMetodosPago meto { get; set; }
        public virtual tbVisitantes visi { get; set; }
    }
}