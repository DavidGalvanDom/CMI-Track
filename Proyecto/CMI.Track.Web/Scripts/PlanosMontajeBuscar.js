//js de lista de Planos Montaje.
//David Galvan
//17/Febrero/2016
var PlanosMontajeBuscar = {
    colPlanosMontaje: {},
    idEtapa: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = PlanosMontajeBuscar.colPlanosMontaje.get(idRow);
        PlanosMontajeBuscar.parent.AsignaPlanosMontaje(rowSelected.attributes.id,
                                            rowSelected.attributes.nombrePlanoMontaje,
                                            rowSelected.attributes.fechaInicio,
                                            rowSelected.attributes.fechaFin);
    },
    CargaGrid: function () {
        $('#cargandoInfoPM').show();
        var url = contextPath + "PlanosMontaje/CargaPlanosMontajeActivos?idEtapa=" + PlanosMontajeBuscar.idEtapa; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            PlanosMontajeBuscar.colPlanosMontaje = new Backbone.Collection(data);
            var bolFilter = PlanosMontajeBuscar.colPlanosMontaje.length > 0 ? true : false;
            if (bolFilter) {
                gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-buscaPlanosMontaje'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: PlanosMontajeBuscar.colPlanosMontaje,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre PlanosMontaje', name: 'nombrePlanoMontaje', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'fechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'fechaFin', filter: true, filterType: 'input' }],
                    onRowClick: function () {
                        PlanosMontajeBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoPM').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Planos de Montaje registrados");
                $('#bbGrid-buscaPlanosMontaje')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Planos de Montaje");
        });
    }
};