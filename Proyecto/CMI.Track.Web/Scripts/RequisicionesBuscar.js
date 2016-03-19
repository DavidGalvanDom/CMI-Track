//js de lista de Requisiciones.
//David Jasso
//17/Marzo/2016
var RequisicionesBuscar = {
    colRequisicion: {},
    idEtapa: 0,
    idProyecto: 0,
    idRequerimiento: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = RequisicionesBuscar.colRequisicion.get(idRow);
        RequisicionesBuscar.parent.AsignaRequisicion(rowSelected.attributes.id,
                                            rowSelected.attributes.NombreOrigen,
                                            rowSelected.attributes.Causa,
                                            rowSelected.attributes.Estatus);
    },
    CargaGrid: function () {
        $('#cargandoInfoBE').show();
        var url = contextPath + "ReqManualCompra/CargaRequisiciones?idEtapa=" + RequisicionesBuscar.idEtapa + "&idProyecto=" + RequisicionesBuscar.idProyecto + "&idRequerimiento=" + RequisicionesBuscar.idRequerimiento; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            RequisicionesBuscar.colRequisicion = new Backbone.Collection(data);
            var bolFilter = RequisicionesBuscar.colRequisicion.length > 0 ? true : false;
            if (bolFilter) {
                gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-muestraRequisicion'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: RequisicionesBuscar.colRequisicion,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Origen', name: 'NombreOrigen', filter: true, filterType: 'input' },
                               { title: 'Causa', name: 'Causa', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        RequisicionesBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoBE').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Requisiciones.");
                $('#bbGrid-muestraRequisicion')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Requisiciones :(");
        });
    }
};