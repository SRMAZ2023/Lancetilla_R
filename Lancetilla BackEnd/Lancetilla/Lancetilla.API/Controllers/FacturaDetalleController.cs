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
    public class FacturaDetalleController : ControllerBase
    {


        private readonly FacturaServicios _facturaServicios;
        private readonly IMapper _mapper;

        public FacturaDetalleController(FacturaServicios facturaServicios, IMapper mapper)
        {
            _facturaServicios = facturaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarFacturaDetalles")]
        public IActionResult ListarFacturaDetalles()
        {
            var list = _facturaServicios.ListarFacturaDetalles();
            return Ok(list);
        }

        [HttpPost("InsertarFacturaDetalle")]
        public IActionResult InsertarFacturaDetalle(FacturaDetalleViewModel item)
        {
            var visitantes = _mapper.Map<tbFacturasDetalles>(item);
            var List = _facturaServicios.InsertarFacturaDetalle(visitantes);

            return Ok(List);
        }
    }
}
