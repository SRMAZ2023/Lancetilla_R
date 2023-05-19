using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lancetilla.DataAccess.Repositories.Zool;
using Lancetilla.Entities.Entities;

namespace Lancetilla.BussinessLogic.Servicios.Zoologico_Servicios
{
  public  class ZoologicoServicios
    {

        private readonly AlimentacionRepository  _alimentacionRepository;
        private readonly AnimalesRepository _animalesRepository;
        private readonly AreasZoologicoRepository _areasZoologicoRepository;
        private readonly EspeciesRepository _especiesRepository;
        private readonly HabitatRepository  _habitatRepository;

        public ZoologicoServicios(    AlimentacionRepository  alimentacionRepository,
                                      AnimalesRepository  animalesRepository,
                                      AreasZoologicoRepository  areasZoologicoRepository,
                                      EspeciesRepository  especiesRepository,
                                       HabitatRepository  habitatRepository)
                                      
        {
            _alimentacionRepository = alimentacionRepository;
            _animalesRepository = animalesRepository;
            _areasZoologicoRepository = areasZoologicoRepository;
            _especiesRepository = especiesRepository;
            _habitatRepository = habitatRepository;



        }

        #region Alimentacion 
        public IEnumerable<VW_tbALimentacion> ListarAlimentacion()
        {
            try
            {
                var list = _alimentacionRepository.ListarAlimentacion();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbALimentacion>();

            }
        }

        public ServiceResult EliminarAlimentos(tbAlimentacion item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _alimentacionRepository.Delete(item);
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

        public ServiceResult InsertAlimentos(tbAlimentacion item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _alimentacionRepository.Insert(item);
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

        public ServiceResult ActualizarAlimentos(tbAlimentacion item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _alimentacionRepository.Update(item);
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

        #region Animales

        public IEnumerable<VW_tbAnimales> ListarAnimales()
        {
            try
            {
                var list = _animalesRepository.ListarAnimales();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbAnimales>();

            }
        }


        public ServiceResult InsertarAnimales(tbAnimales item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _animalesRepository.Insert(item);
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

        public ServiceResult ActualizarAnimales(tbAnimales item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _animalesRepository.Update(item);
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

        public ServiceResult EliminarAnimales(tbAnimales item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _animalesRepository.Delete(item);
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

        #region Areas del Zoologico

        public IEnumerable<VW_tbAreasZoologico> ListarAreasDeZoologico()
        {
            try
            {
                var list = _areasZoologicoRepository.ListarAreasDeZoologico();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbAreasZoologico>();

            }
        }

        public ServiceResult InsertarAreasDeZoologico(tbAreasZoologico item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasZoologicoRepository.Insert(item);
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

        public ServiceResult ActualizarAreasDeZoologico(tbAreasZoologico item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasZoologicoRepository.Update(item);
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

        public ServiceResult EliminarAreasDeZoologico(tbAreasZoologico item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _areasZoologicoRepository.Delete(item);
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

        #region Especies
        public IEnumerable<VW_tbEspecies> ListarEspecies()
        {
            try
            {
                var list = _especiesRepository.ListarEspecies();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbEspecies>();

            }
        }

        public ServiceResult EliminarEspecie(tbEspecies item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _especiesRepository.Delete(item);
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

        public ServiceResult InsertarEspecie(tbEspecies item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _especiesRepository.Insert(item);
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

        public ServiceResult ActualizarEspecie(tbEspecies item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _especiesRepository.Update(item);
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

      
        #region Habitat
        /* public IEnumerable<VW_tbHabitat> ListarHabitat()
         {
             try
             {
                 var list = _especiesRepository.ListarHabitat();
                 return list;
             }
             catch (Exception ex)
             {

                 return Enumerable.Empty<VW_tbHabitat>();

             }
         }*/







        #endregion
    }
}
