﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbMantenimientoAnimal
    {
        public int maan_Id { get; set; }
        public int anim_Id { get; set; }
        public int mant_Id { get; set; }
        public DateTime maan_Fecha { get; set; }
        public int? maan_UserCreacion { get; set; }
        public DateTime? maan_FechaCreacion { get; set; }
        public int? maan_UserModificacion { get; set; }
        public DateTime? maan_FechaModificacion { get; set; }
        public bool? maan_Estado { get; set; }

        public virtual tbAnimales anim { get; set; }
        public virtual tbUsuarios maan_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios maan_UserModificacionNavigation { get; set; }
        public virtual tbMantenimientos mant { get; set; }
    }
}