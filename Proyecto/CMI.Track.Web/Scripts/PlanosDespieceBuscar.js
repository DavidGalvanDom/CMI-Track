//js de lista de Planos Despiece.
//David Galvan
//24/Febrero/2016
var PlanosDespieceBuscar = {
    colPlanosDespiece: {},
    idPlanoMontaje: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = PlanosDespieceBuscar.colPlanosDespiece.get(idRow);
        PlanosDespieceBuscar.parent.AsignaPlanosDespiece(rowSelected.attributes.id,
                                            rowSelected.attributes.nombrePlanoDespiece,
                                            rowSelected.attributes.codigoPlanoDespiece);
    },
    CargaGrid: function () {
        $('#cargandoInfoPD').show();        
        var url = contextPath + "PlanosDespiece/CargaPlanosDespieceActivos?idPlanoMontaje=" + PlanosDespieceBuscar.idPlanoMontaje; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            PlanosDespieceBuscar.colPlanosDespiece = new Backbone.Collection(data);
            var bolFilter = PlanosDespieceBuscar.colPlanosDespiece.length > 0 ? true : false;
            if (bolFilter) {
                gridProyecto = new bbGrid.View({
                    container: $('#bbGrid-buscaPlanosDespiece'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: PlanosDespieceBuscar.colPlanosDespiece,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Planos Despiece', name: 'nombrePlanoDespiece', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'codigoPlanoDespiece', filter: true, filterType: 'input' }], 
                    onRowDblClick: function () {
                        PlanosDespieceBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoPD').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Planos de Despiece registrados");
                $('#bbGrid-buscaPlanosDespiece')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Planos Despiece");
        });
    }
};