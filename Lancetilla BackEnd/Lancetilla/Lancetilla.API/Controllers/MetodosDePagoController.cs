using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Factura_Servicios;
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
    public class MetodosDePagoController : ControllerBase
    {

        private readonly FacturaServicios _facturaServicios;
        private readonly IMapper _mapper;

        public MetodosDePagoController(FacturaServicios facturaServicios, IMapper mapper)
        {
            _facturaServicios = facturaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarMetodosDePago")]
        public IActionResult ListarMetodosDePago()
        {
            var list = _facturaServicios.ListarMetodosDePago();
            return Ok(list);
        }


        [HttpPost("InsertarMetodoDePago")]
        public IActionResult InsertarMetodoDePago(MetodosDePagoViewModel item)
        {
            var metodosPago = _mapper.Map<tbMetodosPago>(item);
            var List = _facturaServicios.InsertarMetodoDePago(metodosPago);
            return Ok(List);
        }

        [HttpPost("ActualizarMetodoDePago")]
        public IActionResult ActualizarMetodoDePago(MetodosDePagoViewModel item)
        {
            var metodosPago = _mapper.Map<tbMetodosPago>(item);
            var List = _facturaServicios.ActualizarMetodoDePago(metodosPago);
            return Ok(List);
        }

        [HttpPost("EliminarMetodoDePago")]
        public IActionResult EliminarMetodoDePago(MetodosDePagoViewModel item)
        {
            var metodosPago = _mapper.Map<tbMetodosPago>(item);
            var List = _facturaServicios.EliminarMetodoDePago(metodosPago);
            return Ok(List);
        }
    }
}
