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
    public class VisitantesController : ControllerBase
    {

        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public VisitantesController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarVisitantes")]
        public IActionResult ListarVisitantes()
        {
            var list = _mantenimientoServicios.ListarVisitantes();
            return Ok(list);
        }
        [HttpGet("VisitantesSexo")]
        public IActionResult Grafica()
        {
            var list = _mantenimientoServicios.VisitantesSexo();

            return Ok(list);
        }

        [HttpPost("InsertVisitantes")]
        public IActionResult InsertVisitantes(VisitantesViewModel item)
        {
            var visitantes = _mapper.Map<tbVisitantes>(item);
            var List = _mantenimientoServicios.InsertVisitantes(visitantes);

            List.Data = _mapper.Map<VisitantesViewModel>(List.Data);
            return Ok(List);
        }

        
        [HttpPost("ActualizarVisitantes")]
        public IActionResult ActualizarVisitantes(VisitantesViewModel item)
        {
            var visitantes = _mapper.Map<tbVisitantes>(item);
            var List = _mantenimientoServicios.ActualizarVisitantes(visitantes);
            return Ok(List);
        }

     
    }
}
