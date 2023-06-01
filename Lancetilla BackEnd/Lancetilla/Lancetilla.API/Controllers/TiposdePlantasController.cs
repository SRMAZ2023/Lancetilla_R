using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Botanica_Servicios;
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
    public class TiposdePlantasController : ControllerBase
    {
        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public TiposdePlantasController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }

        [HttpGet("ListarTiposPlantas")]
        public IActionResult ListarTiposPlantas()
        {
            var list = _botanicaServicios.ListarTiposPlantas();
            return Ok(list);
        }

        [HttpPost("BuscarPlantasPorTipo")]
        public IActionResult BuscarPlantasPorTipo(PlantasViewModel item)
        {
            var mantenimientos = _mapper.Map<tbPlantas>(item);
            var List = _botanicaServicios.BuscarPlantasporTipo(item.tipl_Id);
            return Ok(List);
        }


        [HttpPost("InsertarTiposPlantas")]
        public IActionResult InsertarTiposPlantas(TiposdePlantasViewModel item)
        {
            var animales = _mapper.Map<tbTiposPlantas>(item);
            var List = _botanicaServicios.InsertarTiposPlanta(animales);
            return Ok(List);
        }

        [HttpPost("ActualizarTiposPlantas")]
        public IActionResult ActualizarTiposPlantas(TiposdePlantasViewModel item)
        {
            var animales = _mapper.Map<tbTiposPlantas>(item);
            var List = _botanicaServicios.ActualizarTiposPlanta(animales);
            return Ok(List);
        }

        [HttpPost("EliminarTiposPlantas")]
        public IActionResult EliminarTiposPlantas(TiposdePlantasViewModel item)
        {
            var animales = _mapper.Map<tbTiposPlantas>(item);
            var List = _botanicaServicios.EliminarTiposPlanta(animales);
            return Ok(List);
        }


    }
}
