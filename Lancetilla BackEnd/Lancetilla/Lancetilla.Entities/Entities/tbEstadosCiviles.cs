﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class tbEstadosCiviles
    {
        public tbEstadosCiviles()
        {
            tbEmpleados = new HashSet<tbEmpleados>();
        }

        public int estc_Id { get; set; }
        public string estc_Descripcion { get; set; }
        public int? estc_UserCreacion { get; set; }
        public DateTime? estc_FechaCreacion { get; set; }
        public int? estc_UserModificacion { get; set; }
        public DateTime? estc_FechaModificacion { get; set; }
        public bool? estc_Estado { get; set; }

        public virtual tbUsuarios estc_UserCreacionNavigation { get; set; }
        public virtual tbUsuarios estc_UserModificacionNavigation { get; set; }
        public virtual ICollection<tbEmpleados> tbEmpleados { get; set; }
    }
}