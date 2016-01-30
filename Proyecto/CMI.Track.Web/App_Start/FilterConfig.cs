///Propósito: Filtros por cada petision al sitio web
///Fecha creación: 03/Febrero/14
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System.Web;
using System.Web.Mvc;
using CMI.Track.Web.Controllers;

namespace CMI.Track.Web
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new AutorizarLogin());
            filters.Add(new HandleErrorAttribute());
        }
    }
}
