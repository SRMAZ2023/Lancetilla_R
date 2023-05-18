using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lancetilla.DataAccess.Repositories.Mant;
using Lancetilla.Entities.Entities;

namespace Lancetilla.BussinessLogic.Servicios.Mantenimiento_Servicios
{
    public class MantenimientoServicios
    {

        private readonly CargosRepository  _cargosRepository;
        private readonly DepartamentosRepository _departamentosRepository;
        private readonly EmpleadosRepository _empleadosRepository;
        private readonly EstadoCivilesRepository _estadoCivilesRepository;
      
        private readonly MantenimientosRepository  _mantenimientosRepository;
        private readonly MunicipiosRepository _municipiosRepository;
        private readonly TiposDeMantenimientoRepository  _tiposDeMantenimientoRepository;
        private readonly VisitantesRepository _visitantesRepository;


        public MantenimientoServicios(CargosRepository cargosRepository,
                                      DepartamentosRepository  departamentosRepository,
                                      EmpleadosRepository  empleadosRepository,
                                      EstadoCivilesRepository  estadoCivilesRepository,
                                      MantenimientosRepository mantenimientosRepository,
                                      MunicipiosRepository municipiosRepository,
                                      TiposDeMantenimientoRepository tiposDeMantenimientoRepository,
                                      VisitantesRepository visitantesRepository)

        {
            _cargosRepository = cargosRepository;
            _departamentosRepository = departamentosRepository;
            _empleadosRepository = empleadosRepository;
            _estadoCivilesRepository = estadoCivilesRepository;

            _mantenimientosRepository = mantenimientosRepository;
            _municipiosRepository = municipiosRepository;
            _tiposDeMantenimientoRepository = tiposDeMantenimientoRepository;
            _visitantesRepository = visitantesRepository;

        }

        #region Cargos
        #endregion

        #region Departamentos
        public IEnumerable<VW_tbDepartamentos> ListarDepartamentos()
        {
            try
            {
                var list = _departamentosRepository.ListarDepartamentos();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbDepartamentos>();
            }
        }
        #endregion

        #region Estados Civiles

        #endregion

        #region Empleados 

        #endregion

        #region Mantenimiento
        #endregion

        #region Municipios

        #endregion

        #region Tipos de Mantenimiento

        #endregion

        #region Visitantes 

        #endregion
    }
}
