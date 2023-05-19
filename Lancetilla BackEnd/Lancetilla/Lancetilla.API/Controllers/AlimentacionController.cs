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
    public class AlimentacionController : ControllerBase
    {

        private readonly ZoologicoServicios  _zoologicoServicios;
        private readonly IMapper _mapper;

        public AlimentacionController(ZoologicoServicios  zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarAlimentacion")]
        public IActionResult ListarAlimentacion()
        {
            var list = _zoologicoServicios.ListarAlimentacion();
            return Ok(list);
        }

        [HttpPost("InsertAlimentos")]
        public IActionResult InsertAlimentos(AlimentacionViewModel item)
        {
            var departamento = _mapper.Map<tbAlimentacion>(item);
            var List = _zoologicoServicios.InsertAlimentos(departamento);
            return Ok(List);
        }

        [HttpPost("ActualizarAlimentos")]
        public IActionResult ActualizarAlimentos(AlimentacionViewModel item)
        {
            var departamento = _mapper.Map<tbAlimentacion>(item);
            var List = _zoologicoServicios.ActualizarAlimentos(departamento);
            return Ok(List);
        }

        [HttpPost("EliminarAlimentos")]
        public IActionResult EliminarAlimentos(AlimentacionViewModel item)
        {
            var departamento = _mapper.Map<tbAlimentacion>(item);
            var List = _zoologicoServicios.EliminarAlimentos(departamento);
            return Ok(List);
        }

    }
}
