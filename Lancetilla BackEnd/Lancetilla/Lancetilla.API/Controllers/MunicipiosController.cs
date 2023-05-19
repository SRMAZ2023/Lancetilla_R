using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Mantenimiento_Servicios;
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
    public class MunicipiosController : ControllerBase
    {

        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public MunicipiosController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarMunicipios")]
        public IActionResult ListarMunicipios()
        {
            var list = _mantenimientoServicios.ListarMunicipios();
            return Ok(list);
        }

        [HttpPost("InsertMunicipio")]
        public IActionResult InsertMunicipio(MunicipiosViewModel item)
        {
            var municipios = _mapper.Map<tbMunicipios>(item);
            var List = _mantenimientoServicios.InsertMunicipio(municipios);
            return Ok(List);
        }

        [HttpPost("ActualizarMunicipio")]
        public IActionResult ActualizarMunicipio(MunicipiosViewModel item)
        {
            var municipios = _mapper.Map<tbMunicipios>(item);
            var List = _mantenimientoServicios.ActualizarMunicipio(municipios);
            return Ok(List);
        }

        [HttpPost("EliminarMunicipio")]
        public IActionResult EliminarMunicipio(MunicipiosViewModel item)
        {
            var municipios = _mapper.Map<tbMunicipios>(item);
            var List = _mantenimientoServicios.EliminarMunicipio(municipios);
            return Ok(List);
        }

        [HttpPost("CargarMunicipiosPorDepa")]
        public IActionResult CargarMunicipiosPorDepa(MunicipiosViewModel item)
        {
            var municipios = _mapper.Map<tbMunicipios>(item);
            var List = _mantenimientoServicios.CargarMunicipiosPorDepa(municipios);
            return Ok(List);
        }
    }
}
