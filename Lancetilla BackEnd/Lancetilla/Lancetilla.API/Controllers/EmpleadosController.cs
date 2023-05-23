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
    public class EmpleadosController : ControllerBase
    {

        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public EmpleadosController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarEmpleados")]
        public IActionResult ListarEmpleados()
        {
            var list = _mantenimientoServicios.ListarEmpleados();
            return Ok(list);
        }

        [HttpGet("BuscarEmpleados/{id}")]
        public IActionResult BuscarEmpleados(int id)
        {
            var list = _mantenimientoServicios.BuscarEmpleados(id);
            return Ok(list);
        }

        [HttpPost("InsertEmpleados")]
        public IActionResult InsertEmpleados(EmpleadosViewModel item)
        {
            var empleados = _mapper.Map<tbEmpleados>(item);
            var List = _mantenimientoServicios.InsertEmpleados(empleados);
            return Ok(List);
        }


        [HttpPost("ActualizarEmpleados")]
        public IActionResult ActualizarEmpleados(EmpleadosViewModel item)
        {
            var empleados = _mapper.Map<tbEmpleados>(item);
            var List = _mantenimientoServicios.ActualizarEmpleados(empleados);
            return Ok(List);
        }


        [HttpPost("EliminarEmpleados")]
        public IActionResult EliminarEmpleados(EmpleadosViewModel item)
        {
            var empleados = _mapper.Map<tbEmpleados>(item);
            var List = _mantenimientoServicios.EliminarEmpleados(empleados);
            return Ok(List);
        }



    }
}
