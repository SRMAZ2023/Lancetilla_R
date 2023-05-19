using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lancetilla.DataAccess;
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
        public IEnumerable<VW_tbCargos> ListarCargos()
        {
            try
            {
                var list = _cargosRepository.ListarCargos();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbCargos>();
            }
        }

        public ServiceResult ActualizarCargo(tbCargos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cargosRepository.Update(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarCargo(tbCargos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cargosRepository.Insert(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult EliminarCargo(tbCargos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cargosRepository.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
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

        public ServiceResult InsertDepartamento (tbDepartamentos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _departamentosRepository.Insert(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult ActualizarDepartamento(tbDepartamentos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _departamentosRepository.Update(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult EliminarDepartamento(tbDepartamentos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _departamentosRepository.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Estados Civiles
        public IEnumerable<VW_tbEstadosCiviles> ListarEstadoCiviles()
        {
            try
            {
                var list = _estadoCivilesRepository.ListarEstadoCiviles();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbEstadosCiviles>();
            }
        }
        #endregion

        #region Empleados 
        public IEnumerable<VW_tbEmpleados> ListarEmpleados()
        {
            try
            {
                var list = _empleadosRepository.ListarEmpleados();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbEmpleados>();

            }
        }
        #endregion

        #region Mantenimiento
        public IEnumerable<VW_tbMantenimientos> ListarMantenimientos()
        {
            try
            {
                var list = _mantenimientosRepository.ListarMantenimientos();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbMantenimientos>();

            }
        }
        #endregion

        #region Municipios
        public IEnumerable<VW_tbMunicipios> ListarMunicipios()
        {
            try
            {
                var list = _municipiosRepository.ListarMunicipios();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbMunicipios>();

            }
        }
        #endregion

        #region Tipos de Mantenimiento
        public IEnumerable<VW_tbTiposMantenimientos> ListarTiposDeMantenimientos()
        {
            try
            {
                var list = _tiposDeMantenimientoRepository.ListarTiposDeMantenimientos();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbTiposMantenimientos>();

            }
        }
        #endregion

        #region Visitantes 
        public IEnumerable<VW_tbVisitantes> ListarVisitantes()
        {
            try
            {
                var list = _visitantesRepository.ListarVisitantes();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbVisitantes>();

            }
        }
        #endregion
    }
}
