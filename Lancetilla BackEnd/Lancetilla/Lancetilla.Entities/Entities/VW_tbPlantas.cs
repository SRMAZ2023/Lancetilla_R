﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Lancetilla.Entities.Entities
{
    public partial class VW_tbPlantas
    {
        public int plan_Id { get; set; }
        public string plan_Nombre { get; set; }
        public string plan_NombreCientifico { get; set; }
        public string plan_Reino { get; set; }
        public int arbo_Id { get; set; }
        public string arbo_Descripcion { get; set; }
        public int cuid_Id { get; set; }
        public string cuid_Descripcion { get; set; }
        public string cuid_Frecuencia { get; set; }
        public string usua_UserCreaNombre { get; set; }
        public int? plan_UserCreacion { get; set; }
        public DateTime? plan_FechaCreacion { get; set; }
        public string usua_UserModiNombre { get; set; }
        public int? plan_UserModificacion { get; set; }
        public DateTime? plan_FechaModificacion { get; set; }
        public bool? plan_Estado { get; set; }
    }
}