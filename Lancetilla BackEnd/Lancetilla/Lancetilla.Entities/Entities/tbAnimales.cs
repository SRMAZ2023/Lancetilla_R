﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbAnimales
    {
        public tbAnimales()
        {
            tbMantenimientoAnimal = new HashSet<tbMantenimientoAnimal>();
        }

        public int anim_Id { get; set; }
        public string anim_Codigo { get; set; }
        public string anim_Nombre { get; set; }
        public int raza_Id { get; set; }
        public int arzo_Id { get; set; }
        public int alim_Id { get; set; }
        public int? anim_UserCreacion { get; set; }
        public DateTime? anim_FechaCreacion { get; set; }
        public int? anim_UserModificacion { get; set; }
        public DateTime? anim_FechaModificacion { get; set; }
        public bool? anim_Estado { get; set; }

        public virtual tbAlimentacion alim { get; set; }
        public virtual tbUsuarios anim_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios anim_UserModificacionNavigation { get; set; }
        public virtual tbAreasZoologico arzo { get; set; }
        public virtual tbRazas raza { get; set; }
        public virtual ICollection<tbMantenimientoAnimal> tbMantenimientoAnimal { get; set; }
    }
}