﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbHabitat
    {
        public tbHabitat()
        {
            tbRazas = new HashSet<tbRazas>();
        }

        public int habi_Id { get; set; }
        public string habi_Descripcion { get; set; }
        public int? habi_UserCreacion { get; set; }
        public DateTime? habi_FechaCreacion { get; set; }
        public int? habi_UserModificacion { get; set; }
        public DateTime? habi_FechaModificacion { get; set; }
        public bool? habi_Estado { get; set; }

        public virtual tbUsuarios habi_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios habi_UserModificacionNavigation { get; set; }
        public virtual ICollection<tbRazas> tbRazas { get; set; }
    }
}