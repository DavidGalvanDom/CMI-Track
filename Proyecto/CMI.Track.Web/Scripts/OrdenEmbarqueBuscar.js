/*global $, CMI, Backbone, bbGrid,contextPath*/
//js de lista de Proyectos.
//David Galvan
//17/Febrero/2016
var OrdenEmbarqueBuscar = {
    colOrdenEmbarque: {},
    parent: {},
    gridOrdenEmbarque: {},
    idProyecto: 0,
    revisionProyecto: '',
    idEtapa: 0,
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = OrdenEmbarqueBuscar.colOrdenEmbarque.get(idRow);
        OrdenEmbarqueBuscar.parent.AsignaOrdenEmbarque(rowSelected.attributes.id,
                                            rowSelected.attributes.idOrdenProduccion,
                                            rowSelected.attributes.observacionOrdenEmbarque,
                                            rowSelected.attributes.fechaCreacion);
    },
    CargaGrid: function () {
        var data = 'idProyecto=' + OrdenEmbarqueBuscar.idProyecto +
              '&revision=' + OrdenEmbarqueBuscar.revisionProyecto +
              '&idEtapa=' + OrdenEmbarqueBuscar.idEtapa;

        $('#cargandoInfoOE').show();
        var url = contextPath + "OrdenEmbarque/CargaOrdenEmbarqueActivos"; // El url del controlador
        $.getJSON(url,data, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            OrdenEmbarqueBuscar.colOrdenEmbarque = new Backbone.Collection(data);
            var bolFilter = OrdenEmbarqueBuscar.colOrdenEmbarque.length > 0 ? true : false;
            if (bolFilter) {
                OrdenEmbarqueBuscar.gridOrdenEmbarque = new bbGrid.View({
                    container: $('#bbGrid-buscaOrdenEmbarque'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: OrdenEmbarqueBuscar.colOrdenEmbarque,
                    colModel: [{ title: 'Orden Embarque', name: 'id', width: '15%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Orden Produccion', name: 'idOrdenProduccion', width: '15%', filter: true, filterType: 'input' },
                               { title: 'Observacion', name: 'observacionOrdenEmbarque', width: '55%', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'fechaCreacion', width: '15%', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        OrdenEmbarqueBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoOE').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Ordenes de Embarque");
                $('#bbGrid-buscaOrdenEmbarque')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Ordenes de Embarque");
        });
    }
};