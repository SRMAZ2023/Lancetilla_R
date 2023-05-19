using AutoMapper;
using Lancetilla.API.Models;
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
    public class EspeciesController : ControllerBase
    {

        private readonly ZoologicoServicios _zoologicoServicios;
        private readonly IMapper _mapper;

        public EspeciesController(ZoologicoServicios zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarAnimales")]
        public IActionResult ListarAnimales()
        {
            var list = _zoologicoServicios.ListarAnimales();
            return Ok(list);
        }

        [HttpPost("InsertarEspecie")]
        public IActionResult InsertarEspecie(EspeciesViewModel item)
        {
            var departamento = _mapper.Map<tbEspecies>(item);
            var List = _zoologicoServicios.InsertarEspecie(departamento);
            return Ok(List);
        }

        [HttpPost("ActualizarEspecie")]
        public IActionResult ActualizarEspecie(EspeciesViewModel item)
        {
            var departamento = _mapper.Map<tbEspecies>(item);
            var List = _zoologicoServicios.ActualizarEspecie(departamento);
            return Ok(List);
        }

        [HttpPost("EliminarEspecie")]
        public IActionResult EliminarEspecie(EspeciesViewModel item)
        {
            var departamento = _mapper.Map<tbEspecies>(item);
            var List = _zoologicoServicios.EliminarEspecie(departamento);
            return Ok(List);
        }
    }
}
