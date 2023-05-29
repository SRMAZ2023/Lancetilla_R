using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Acceso_Servicios;
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
    public class RolesController : ControllerBase
    {

        private readonly AccesoServicios _AccesoServicios;
        private readonly IMapper _mapper;

        public RolesController(AccesoServicios accesoServicios, IMapper mapper)
        {
            _AccesoServicios = accesoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarRoles")]
        public IActionResult ListarRoles()
        {
            var list = _AccesoServicios.ListarRoles();
            return Ok(list);
        }

      
        [HttpPost("InsertarRol")]
        public IActionResult InsertarRol(RolViewModel item)
        {
            var usuarios = _mapper.Map<tbRoles>(item);
            var respuesta = _AccesoServicios.InsertarRol(usuarios);
        
            respuesta.Data = _mapper.Map<RolViewModel>(respuesta.Data);

            return Ok(respuesta);
        }

        [HttpPost("ActualizarRol")]
        public IActionResult ActualizarRol(RolViewModel item)
        {
            var usuarios = _mapper.Map<tbRoles>(item);
            var List = _AccesoServicios.ActualizarRol(usuarios);
            return Ok(List);
        }

        [HttpPost("EliminarRol")]
        public IActionResult EliminarRol(RolViewModel item)
        {
            var usuarios = _mapper.Map<tbRoles>(item);
            var List = _AccesoServicios.EliminarRol(usuarios);
            return Ok(List);
        }


    }
}
