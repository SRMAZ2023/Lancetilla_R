﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class VW_MantenimientoAnimales
    {
        public int maan_Id { get; set; }
        public int anim_Id { get; set; }
        public string anim_Nombre { get; set; }
        public string maan_Fecha { get; set; }
        public int tima_Id { get; set; }
        public string tima_Descripcion { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? maan_UserCreacion { get; set; }
        public DateTime? maan_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? maan_UserModificacion { get; set; }
        public bool? maan_Estado { get; set; }
        public DateTime? maan_FechaModificacion { get; set; }

        [NotMapped]
        public int Hoy { get; set; }


    }
}