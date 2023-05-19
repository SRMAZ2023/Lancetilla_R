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
        #endregion


    }
}
