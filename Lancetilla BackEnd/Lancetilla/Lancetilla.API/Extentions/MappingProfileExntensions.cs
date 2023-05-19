﻿using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Extentions
{
    public class MappingProfileExntensions : Profile
    {
        public MappingProfileExntensions()
        {
            CreateMap<DepartamentosViewModel, tbDepartamentos>().ReverseMap();

            CreateMap<CargosViewModel, tbCargos>().ReverseMap();

            CreateMap<EspeciesViewModel, tbEspecies>().ReverseMap();
        }
    }
}
