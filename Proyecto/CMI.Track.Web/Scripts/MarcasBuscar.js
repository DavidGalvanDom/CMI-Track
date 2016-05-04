//js de lista de Marcas.
//David Galvan
//01/Marzo/2016
var MarcasBuscar = {
    colMarcas: {},
    idPlanoDespiece: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = MarcasBuscar.colMarcas.get(idRow);
        MarcasBuscar.parent.AsignaMarca(rowSelected.attributes.id,
                                        rowSelected.attributes.nombreMarca,
                                        rowSelected.attributes.codigoMarca,
                                        rowSelected.attributes.Piezas);
    },
    CargaGrid: function () {
        $('#cargandoInfoMA').show();
        var url = contextPath + "Marcas/CargaMarcasActivas?idPlanoDespiece=" + MarcasBuscar.idPlanoDespiece; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            MarcasBuscar.colMarcas = new Backbone.Collection(data);
            var bolFilter = MarcasBuscar.colMarcas.length > 0 ? true : false;
            if (bolFilter) {
                gridMarcas = new bbGrid.View({
                    container: $('#bbGrid-buscaMarcas'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: MarcasBuscar.colMarcas,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMarca', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'codigoMarca', filter: true, filterType: 'input' },
                               { title: 'Piezas', name: 'Piezas', filter: true, filterType: 'input' }],
                    onRowClick: function () {
                        MarcasBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoMA').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Marcas registradas");
                $('#bbGrid-buscaMarcas')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Marcas");
        });
    }
};