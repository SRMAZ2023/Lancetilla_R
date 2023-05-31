using System;
using System.Collections;
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
        private readonly RazasRepository _razasRepository;

        private readonly ReinosRepository _reinosRepository;

        public ZoologicoServicios(    AlimentacionRepository  alimentacionRepository,
                                      AnimalesRepository  animalesRepository,
                                      AreasZoologicoRepository  areasZoologicoRepository,
                                      EspeciesRepository  especiesRepository,
                                       HabitatRepository  habitatRepository,
                                       RazasRepository razasRepository,
                                       ReinosRepository reinosRepository)
                                      
        {
            _alimentacionRepository = alimentacionRepository;
            _animalesRepository = animalesRepository;
            _areasZoologicoRepository = areasZoologicoRepository;
            _especiesRepository = especiesRepository;
            _habitatRepository = habitatRepository;
            _reinosRepository = reinosRepository;
            _razasRepository = razasRepository;

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
        public VW_tbAnimales BuscarAnimales(int id)
        {
            try
            {
                var list = _animalesRepository.Find(id);
                return list;
            }
            catch (Exception ex)
            {

                return null;

            }
        }


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
        public IEnumerable AnimalesPorArea()
        {
            var result = new ServiceResult();
            try
            {
                var list = _animalesRepository.AnimalesPorArea();
                return list;
            }
            catch (Exception e)
            {
                return Enumerable.Empty<VW_tbAnimales>();
            }
        }

        public IEnumerable AnimalesPorHabitat()
        {
            var result = new ServiceResult();
            try
            {
                var list = _animalesRepository.AnimalesPorHabitat();
                return list;
            }
            catch (Exception e)
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
        public IEnumerable<VW_tbHabitat> ListarHabitat()
        {
            try
            {
                var list = _habitatRepository.ListarHabitat();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbHabitat>();

            }
        }

        public ServiceResult EliminarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Delete(item);
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

        public ServiceResult InsertarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Insert(item);
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

        public ServiceResult ActualizarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Update(item);
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

        #region Reinos
        public IEnumerable<VW_tbReinos> ListarReinos()
        {
            try
            {
                var list = _reinosRepository.ListarReinos();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbReinos>();

            }
        }
        /*
        public ServiceResult EliminarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Delete(item);
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

        public ServiceResult InsertarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Insert(item);
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

        public ServiceResult ActualizarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Update(item);
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

        */




        #endregion

        #region Reinos
        public IEnumerable<VW_tbRazas> ListarRazas()
        {
            try
            {
                var list = _razasRepository.ListarRazas();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbRazas>();

            }
        }
        /*
        public ServiceResult EliminarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Delete(item);
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

        public ServiceResult InsertarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Insert(item);
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

        public ServiceResult ActualizarHabitat(tbHabitat item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _habitatRepository.Update(item);
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

        */




        #endregion


    }
}
