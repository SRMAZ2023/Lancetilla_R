﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbRoles
    {
        public int role_Id { get; set; }
        public string role_Descripcion { get; set; }
        public int? role_UserCreacion { get; set; }
        public DateTime? role_FechaCreacion { get; set; }
        public int? role_UserModificacion { get; set; }
        public DateTime? role_FechaModificacion { get; set; }
        public bool? role_Estado { get; set; }

        public virtual tbUsuarios role_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios role_UserModificacionNavigation { get; set; }
    }
}