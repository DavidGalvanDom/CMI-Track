//js de lista de Proyectos.
//David Galvan
//17/Febrero/2016
var RequerimientoBuscar = {
    colRequerimientos: {},
    idEtapa: 0,
    idProyecto: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = RequerimientoBuscar.colRequerimientos.get(idRow);
        RequerimientoBuscar.parent.AsignaRequerimiento(rowSelected.attributes.id,
                                            rowSelected.attributes.folioRequerimiento,
                                            rowSelected.attributes.fechaSolicitud);
    },
    CargaGrid: function () {
        $('#cargandoInfoBP').show();
        var url = contextPath + "ReqGralMaterial/CargaReqGralMateriales?idEtapa=" + RequerimientoBuscar.idEtapa + "&idProyecto=" + RequerimientoBuscar.idProyecto; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            RequerimientoBuscar.colRequerimientos = new Backbone.Collection(data);
            var bolFilter = RequerimientoBuscar.colRequerimientos.length > 0 ? true : false;
            if (bolFilter) {
                gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-muestraRequerimiento'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: RequerimientoBuscar.colRequerimientos,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Folio Requerimiento', name: 'folioRequerimiento', filter: true, filterType: 'input' },
                               { title: 'Fecha Solicitud', name: 'fechaSolicitud', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        RequerimientoBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoBE').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Requerimientos.");
                $('#bbGrid-muestraRequerimiento')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Requerimientos :(");
        });
    }
};