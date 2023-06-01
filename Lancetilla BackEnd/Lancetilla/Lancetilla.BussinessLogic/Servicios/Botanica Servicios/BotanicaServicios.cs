﻿using Lancetilla.DataAccess.Repositories.Bota;
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
      

        public BotanicaServicios(AreasBotanicasRepository areasBotanicasRepository, 
                                 CuidadosRepository cuidadosRepository, 
                                 PlantasRepository plantasRepository,
                                 TiposCuidados tiposCuidados,
                                 TiposdePlantasRepository  tiposdePlantasRepository)
        {
            _areasBotanicasRepository = areasBotanicasRepository;
            _cuidadosRepository = cuidadosRepository;
            _plantasRepository = plantasRepository;
            _tiposCuidados = tiposCuidados;
            _tiposdePlantasRepository = tiposdePlantasRepository;
           
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

        public IEnumerable PlantasPorArea()
        {
            var result = new ServiceResult();
            try
            {
                var list = _plantasRepository.PlantasPorArea();
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

        public IEnumerable<VW_tbPlantas> BuscarPlantasporTipo(int id)
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



    }
}
