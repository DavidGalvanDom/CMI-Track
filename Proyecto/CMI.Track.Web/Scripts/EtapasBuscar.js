//js de lista de Proyectos.
//David Galvan
//17/Febrero/2016
var EtapaBuscar = {
    colEtapas: {},
    idProyecto: 0,
    revisionProyecto: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = EtapaBuscar.colEtapas.get(idRow);
        EtapaBuscar.parent.AsignaEtapa(rowSelected.attributes.idEtapa,
                                            rowSelected.attributes.NombreEtapa,
                                            rowSelected.attributes.FechaInicio,
                                            rowSelected.attributes.FechaFin);
    },
    CargaGrid: function () {
        $('#cargandoInfoBP').show();
        var url = contextPath + "Etapa/CargaEtapasActivas?idProyecto=" + EtapaBuscar.idProyecto + "&revision=" + EtapaBuscar.revisionProyecto; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            EtapaBuscar.colEtapas = new Backbone.Collection(data);
            var bolFilter = EtapaBuscar.colEtapas.length > 0 ? true : false;
            if (bolFilter) {
                gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-buscaEtapas'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: EtapaBuscar.colEtapas,
                    colModel: [{ title: 'Id', name: 'idEtapa', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Etapa', name: 'NombreEtapa', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'FechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'FechaFin', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        EtapaBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoBE').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Etapas.");
                $('#bbGrid-buscaEtapas')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Etapas");
        });
    }
};