using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Botanica_Servicios;
using Lancetilla.BussinessLogic.Servicios.Zoologico_Servicios;
using Lancetilla.Entities.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RazasController : ControllerBase
    {
                private readonly ZoologicoServicios _zoologicoServicios;
        private readonly IMapper _mapper;

        public RazasController(ZoologicoServicios zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarRazas")]
        public IActionResult ListarRazas()
        {
            var list = _zoologicoServicios.ListarRazas();
            return Ok(list);
        }

        [HttpPost("InsertarRazas")]
        public IActionResult InsertarRazas(RazasViewModel item)
        {
            var plantas = _mapper.Map<tbRazas>(item);
            var List = _zoologicoServicios.InsertarRaza(plantas);
            return Ok(List);
        }

        [HttpPost("ActualizarRazas")]
        public IActionResult ActualizarRazas(RazasViewModel item)
        {
            var plantas = _mapper.Map<tbRazas>(item);
            var List = _zoologicoServicios.ActualizarRaza(plantas);
            return Ok(List);
        }

        [HttpPost("EliminarRazas")]
        public IActionResult EliminarRazas(RazasViewModel item)
        {
            var plantas = _mapper.Map<tbRazas>(item);
            var List = _zoologicoServicios.EliminarRazas(plantas);
            return Ok(List);
        }
    }
}
