using Lancetilla.DataAccess.Repositories.Bota;
using Lancetilla.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.BussinessLogic.Servicios.Botanica_Servicios
{
    public class BotanicaServicios
    {

        private readonly AreasBotanicasRepository _areasBotanicasRepository;
        private readonly CuidadosRepository _cuidadosRepository;
        private readonly PlantasRepository _plantasRepository;
      

        public BotanicaServicios(AreasBotanicasRepository areasBotanicasRepository, 
                                 CuidadosRepository cuidadosRepository, 
                                 PlantasRepository plantasRepository)
        {
            _areasBotanicasRepository = areasBotanicasRepository;
            _cuidadosRepository = cuidadosRepository;
            _plantasRepository = plantasRepository;
           
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

        #region Cuidados de plantas
        public IEnumerable<VW_tbCuidados> ListarCuidadosDePlantas()
        {
            try
            {
                var list = _cuidadosRepository.ListarCuidadosDePlantas();
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


    }
}
