﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbMetodosPago
    {
        public tbMetodosPago()
        {
            tbFacturas = new HashSet<tbFacturas>();
        }

        public int meto_Id { get; set; }
        public string meto_Descripcion { get; set; }
        public int? meto_UserCreacion { get; set; }
        public DateTime? meto_FechaCreacion { get; set; }
        public int? meto_UserModificacion { get; set; }
        public DateTime? meto_FechaModificacion { get; set; }
        public bool? meto_Estado { get; set; }

        public virtual tbUsuarios meto_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios meto_UserModificacionNavigation { get; set; }
        public virtual ICollection<tbFacturas> tbFacturas { get; set; }
    }
}