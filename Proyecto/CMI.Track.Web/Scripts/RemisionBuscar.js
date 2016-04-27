//js de lista de Remisiones.
//David Galvan
//26/Abril/2016
var RemisionBuscar = {
    colRemision: {},
    idProyecto: 0,
    idEtapa: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = RemisionBuscar.colRemision.get(idRow);
        RemisionBuscar.parent.AsignaRemision(rowSelected.attributes.id,
                                            rowSelected.attributes.NombreCliente,
                                            rowSelected.attributes.Transporte,
                                            rowSelected.attributes.fechaEnvio);
    },
    CargaGrid: function () {
        $('#cargandoInfoRE').show();
        var url = contextPath + "Remision/CargaRemisionesActivas?idProyecto=" + RemisionBuscar.idProyecto + "&idEtapa=" + RemisionBuscar.idEtapa; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            RemisionBuscar.colRemision = new Backbone.Collection(data);
            var bolFilter = RemisionBuscar.colRemision.length > 0 ? true : false;
            if (bolFilter) {
                gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-buscaRemisiones'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: RemisionBuscar.colRemision,
                    colModel: [{ title: 'Remision', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Cliente', name: 'NombreCliente', filter: true, filterType: 'input' },
                               { title: 'Transporte', name: 'Transporte', filter: true, filterType: 'input' },
                               { title: 'Fecha Envio', name: 'fechaEnvio', filter: true, filterType: 'input' },
                               { title: 'Fecha Remision', name: 'fechaRemision', filter: true, filterType: 'input'}],
                    onRowDblClick: function () {
                        RemisionBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoRE').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Remisiones.");
                $('#bbGrid-buscaRemisiones')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Remisiones");
        });
    }
};