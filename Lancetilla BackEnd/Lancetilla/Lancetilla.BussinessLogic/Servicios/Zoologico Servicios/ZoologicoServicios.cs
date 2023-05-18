using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lancetilla.DataAccess.Repositories.Zool;

namespace Lancetilla.BussinessLogic.Servicios.Zoologico_Servicios
{
  public  class ZoologicoServicios
    {

        private readonly AlimentacionRepository  _alimentacionRepository;
        private readonly AnimalesRepository _animalesRepository;
        private readonly AreasZoologicoRepository _areasZoologicoRepository;
        private readonly EspeciesRepository _especiesRepository;
      
        public ZoologicoServicios(    AlimentacionRepository  alimentacionRepository,
                                      AnimalesRepository  animalesRepository,
                                      AreasZoologicoRepository  areasZoologicoRepository,
                                      EspeciesRepository  especiesRepository)
                                      
        {
            _alimentacionRepository = alimentacionRepository;
            _animalesRepository = animalesRepository;
            _areasZoologicoRepository = areasZoologicoRepository;
            _especiesRepository = especiesRepository;

          

        }

        #region Cargos
        #endregion

        #region Departamentos

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
