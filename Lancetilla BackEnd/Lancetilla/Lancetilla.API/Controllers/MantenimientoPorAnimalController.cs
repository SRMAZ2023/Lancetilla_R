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
    public class MantenimientoPorAnimalController : ControllerBase
    {
        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public MantenimientoPorAnimalController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarMantenimientosAnimal")]
        public IActionResult ListarMantenimientos()
        {
            var list = _mantenimientoServicios.ListarMantenimientosAnimal();
            return Ok(list);
        }

        [HttpPost("Buscar")]
        public IActionResult BuscarMantenimientoAnimal(MantenimientoAnimalViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientoAnimal>(item);
            var List = _mantenimientoServicios.BuscarManteniminetoAnimales(item.anim_Id);
            return Ok(List);
        }

        [HttpPost("InsertMantenimientoAnimal")]
        public IActionResult InsertMantenimientoAnimal(MantenimientoAnimalViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientoAnimal>(item);
            var List = _mantenimientoServicios.InsertMantenimientoAnimal(mantenimientos);
            return Ok(List);
        }

        [HttpPut("ActualizarMantenimientoAnimal")]
        public IActionResult ActualizarMantenimientoAnimal(MantenimientoAnimalViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientoAnimal>(item);
            var List = _mantenimientoServicios.ActualizarMantenimientoAnimal(mantenimientos);
            return Ok(List);
        }

        [HttpPost("EliminarMantenimientoAnimal")]
        public IActionResult EliminarMantenimientoAnimal(MantenimientoAnimalViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientoAnimal>(item);
            var List = _mantenimientoServicios.EliminarMantenimientoAnimal(mantenimientos);
            return Ok(List);
        }



    }
}
