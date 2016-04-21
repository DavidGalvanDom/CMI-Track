/*global $, CMI, Backbone, bbGrid,contextPath*/
//js de lista de Proyectos.
//David Galvan
//17/Febrero/2016
var ProyectoBuscar = {
    colProyectos: {},
    parent: {},
    gridProyecto : {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = ProyectoBuscar.colProyecto.get(idRow);
        ProyectoBuscar.parent.AsignaProyecto(rowSelected.attributes.idProyecto,
                                            rowSelected.attributes.Revision,
                                            rowSelected.attributes.NombreProyecto,
                                            rowSelected.attributes.CodigoProyecto,
                                            rowSelected.attributes.FechaInicio,
                                            rowSelected.attributes.FechaFin,
                                            rowSelected.attributes.estatusRevision);
    },
    CargaGrid: function () {
        $('#cargandoInfoPM').show();
        var url = contextPath + "Proyecto/CargaProyectosActivos"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            ProyectoBuscar.colProyecto = new Backbone.Collection(data);
            var bolFilter = ProyectoBuscar.colProyecto.length > 0 ? true : false;
            if (bolFilter) {
                ProyectoBuscar.gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-buscaProyecto'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: ProyectoBuscar.colProyecto,
                    colModel: [{ title: 'Id', name: 'idProyecto', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Proyecto', name: 'NombreProyecto', width: '30%', filter: true, filterType: 'input' },
                               { title: 'Revision', name: 'Revision', width: '8%', filter: true, filterType: 'input' },
                               { title: 'Estatus Revision', name: 'nomEstatusRevison', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'CodigoProyecto', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'FechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'FechaFin', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        ProyectoBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoPM').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Proyecto registrados");
                $('#bbGrid-buscaProyecto')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Proyecto");
        });
    }
};