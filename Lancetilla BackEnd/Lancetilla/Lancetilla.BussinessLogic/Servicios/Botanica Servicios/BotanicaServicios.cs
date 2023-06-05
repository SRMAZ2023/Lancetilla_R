using Lancetilla.DataAccess.Repositories.Bota;
using Lancetilla.Entities.Entities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.BussinessLogic.Servicios.Botanica_Servicios
{
    public class BotanicaServicios
    {

        private readonly AreasBotanicasRepository _areasBotanicasRepository;
        private readonly TiposCuidados _tiposCuidados;
        private readonly CuidadosRepository _cuidadosRepository;
        private readonly PlantasRepository _plantasRepository;
        private readonly TiposdePlantasRepository _tiposdePlantasRepository;
        private readonly CuidadoPlantas _cuidadoPlantas;


        public BotanicaServicios(AreasBotanicasRepository areasBotanicasRepository,
                                 CuidadosRepository cuidadosRepository,
                                 PlantasRepository plantasRepository,
                                 TiposCuidados tiposCuidados,
                                 TiposdePlantasRepository tiposdePlantasRepository,
                                 CuidadoPlantas cuidadoPlantas)
        {
            _areasBotanicasRepository = areasBotanicasRepository;
            _cuidadosRepository = cuidadosRepository;
            _plantasRepository = plantasRepository;
            _tiposCuidados = tiposCuidados;
            _tiposdePlantasRepository = tiposdePlantasRepository;
            _cuidadoPlantas = cuidadoPlantas;

        }

        #region AreasBotanicas
        public IEnumerable<VW_tbAreasBotanicas> ListarAreasBotanicas()
        {
            try
            {
                var list = _areasBotanicasRepository.ListarAreasBotanicas();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbAreasBotanicas>();

            }
        }

        public ServiceResult InsertarAreaBotanica(tbAreasBotanicas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasBotanicasRepository.Insert(item);
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

        public ServiceResult ActualizarAreaBotanica(tbAreasBotanicas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasBotanicasRepository.Update(item);
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

        public ServiceResult EliminarAreaBotanica(tbAreasBotanicas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasBotanicasRepository.Delete(item);
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

        #region AreasBotanicas
        public IEnumerable<VW_tbTiposPlantas> ListarTiposPlantas()
        {
            try
            {
                var list = _tiposdePlantasRepository.ListarTiposPlantas();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbTiposPlantas>();

            }
        }
        /*
        public ServiceResult InsertarAreaBotanica(tbAreasBotanicas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasBotanicasRepository.Insert(item);
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

        public ServiceResult ActualizarAreaBotanica(tbAreasBotanicas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasBotanicasRepository.Update(item);
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

        public ServiceResult EliminarAreaBotanica(tbAreasBotanicas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasBotanicasRepository.Delete(item);
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
        }*/
        #endregion

        #region Cuidados  
        public IEnumerable<VW_tbCuidados> ListarCuidados()
        {
            try
            {
                var list = _cuidadosRepository.ListarCuidados();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbCuidados>();

            }
        }

        public ServiceResult InsertarCuidados(tbCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cuidadosRepository.Insert(item);
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

        public ServiceResult ActualizarCuidado(tbCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cuidadosRepository.Update(item);
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


        public ServiceResult EliminarCuidado(tbCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cuidadosRepository.Delete(item);
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

        #region tiposcuidados
        public IEnumerable<VW_tbTiposCuidados> ListarTiposCuidados()
        {
            try
            {
                var list = _tiposCuidados.ListarTiposCuidados();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbTiposCuidados>();

            }
        }







        public ServiceResult InsertarTiposCuidados(tbTiposCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposCuidados.Insert(item);
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

        public ServiceResult ActualizarTiposCuidados(tbTiposCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposCuidados.Update(item);
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

        public ServiceResult EliminarTiposCuidados(tbTiposCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposCuidados.Delete(item);
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

        #region Plantas
        public IEnumerable<VW_tbPlantas> ListarPlantas()
        {
            try
            {
                var list = _plantasRepository.ListarPlantas();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbPlantas>();

            }
        }


        public IEnumerable<VW_MantenimientoAnimales> MantenimientosPorAnimal(string fechaInicio, string fechafinal)
        {
            try
            {
                var list = _plantasRepository.MantenimientosPorAnimal(fechaInicio, fechafinal);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_MantenimientoAnimales>();
            }
        }

        

        public IEnumerable ConteoZoologico()
        {
            var result = new ServiceResult();
            try
            {
                var list = _plantasRepository.ConteoZoologico();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_FacturasDetalle>();
            }
        }
        public IEnumerable ConteoBotanica()
        {
            var result = new ServiceResult();
            try
            {
                var list = _plantasRepository.ConteoBotanica();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_FacturasDetalle>();
            }
        }
        public IEnumerable qntienemasmantenimientos()
        {
            var result = new ServiceResult();
            try
            {
                var list = _plantasRepository.qntienemasmantenimientos();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_MantenimientoAnimales>();
            }
        }
        public IEnumerable AnimalesPorAreas()
        {
            var result = new ServiceResult();
            try
            {
                var list = _plantasRepository.AnimalesPorAreas();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_tbAreasZoologico>();
            }

        }

        public IEnumerable CuidadosPorPlantas()
        {
            var result = new ServiceResult();
            try
            {
                var list = _plantasRepository.CuidadosPorPlantas();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_tbPlantas>();
            }
        }
        public VW_tbPlantas BuscarPlantas(int id)
        {
            try
            {
                var list = _plantasRepository.Find(id);
                return list;
            }
            catch (Exception ex)
            {

                return null;

            }
        }




        public ServiceResult InsertarPlanta(tbPlantas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _plantasRepository.Insert(item);
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

        public ServiceResult ActualizarPlanta(tbPlantas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _plantasRepository.Update(item);
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

        public ServiceResult EliminarPlanta(tbPlantas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _plantasRepository.Delete(item);
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

        #region Tipos de Plantas

        public IEnumerable<VW_tbTiposPlantas> BuscarPlantasporTipo(int id)
        {
            try
            {
                var list = _tiposdePlantasRepository.Find(id);
                return list;
            }
            catch (Exception ex)
            {

                return null;

            }
        }
        public IEnumerable<VW_tbTiposPlantas> ListarTipoPlantas()
        {
            try
            {
                var list = _tiposdePlantasRepository.ListarTiposPlantas();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbTiposPlantas>();

            }
        }







        public ServiceResult InsertarTiposPlanta(tbTiposPlantas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposdePlantasRepository.Insert(item);
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



        public ServiceResult ActualizarTiposPlanta(tbTiposPlantas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposdePlantasRepository.Update(item);
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
        
        public ServiceResult EliminarTiposPlanta(tbTiposPlantas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposdePlantasRepository.Delete(item);
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

        #region CuidadosPlantas 

        public IEnumerable CuidadoPorPlanta()
        {
            var result = new ServiceResult();
            try
            {
                var list = _cuidadosRepository.CuidadoPorPlanta();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_tbCuidados>();
            }
        }

        public IEnumerable MantenimientoPorAnimal()
        {
            var result = new ServiceResult();
            try
            {
                var list = _cuidadosRepository.MantenimientoPorAnimal();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_MantenimientoAnimales>();
            }
        }
        public IEnumerable<VW_tbCuidadoPlanta> ListarCuidadoPlantas()
        {
            try
            {
                var list = _cuidadoPlantas.ListarCuidados();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbCuidadoPlanta>();

            }
        }

        public IEnumerable<VW_tbCuidadoPlanta> BuscarCuidadoPlantas(int id)
        {
            try
            {
                var list = _cuidadoPlantas.Find2(id);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbCuidadoPlanta>();

            }
        }
        public IEnumerable<VW_tbCuidadoPlanta> BuscarCuidadoPlantas2(int id)
        {
            try
            {
                var list = _cuidadoPlantas.Find3(id);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbCuidadoPlanta>();

            }
        }


        public ServiceResult InsertarCuidadoPlantas(tbCuidadoPlanta item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cuidadoPlantas.Insert(item);
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

        public ServiceResult ActualizarCuidadoPlantas(tbCuidadoPlanta item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cuidadoPlantas.Update(item);
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


        public ServiceResult EliminarCuidadoPlantas(tbCuidadoPlanta item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _cuidadoPlantas.Delete(item);
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

    }
}
