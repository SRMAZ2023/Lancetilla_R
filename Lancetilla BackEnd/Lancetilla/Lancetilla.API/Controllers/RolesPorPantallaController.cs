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
    public class RolesPorPantallaController : ControllerBase
    {

        private readonly AccesoServicios _AccesoServicios;
        private readonly IMapper _mapper;

        public RolesPorPantallaController(AccesoServicios accesoServicios, IMapper mapper)
        {
            _AccesoServicios = accesoServicios;
            _mapper = mapper;
        }
      


        [HttpPost("PantallasPorRol")]
        public IActionResult PantallasPorRol(RolesPorPantallaViewModel item)
        {
            var resultMapeado = _mapper.Map<tbRolesPantallas>(item);

            var respuesta = _AccesoServicios.PantallasPorRol(resultMapeado);

            
            return Ok(respuesta);
        }


        [HttpPost("InsertarRolPorPantalla")]
        public IActionResult InsertarRolPorPantalla(RolesPorPantallaViewModel item)
        {
            var usuarios = _mapper.Map<tbRolesPantallas>(item);
            var List = _AccesoServicios.InsertarRolPorPantalla(usuarios);
            return Ok(List);
        }

        [HttpPost("EliminarRolPorPantalla")]
        public IActionResult EliminarRolPorPantalla(RolesPorPantallaViewModel item)
        {
            var usuarios = _mapper.Map<tbRolesPantallas>(item);
            var List = _AccesoServicios.EliminarRolPorPantalla(usuarios);
            return Ok(List);
        }







    }
}
