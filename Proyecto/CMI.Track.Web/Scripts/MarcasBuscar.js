//js de lista de Materiales.
//David Jasso
//17/Febrero/2016
var MarcaBuscar = {
    colMarcas: {},
    idProyecto: 0,
    idEtapa: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = MarcaBuscar.colMarcas.get(idRow);
        MarcaBuscar.parent.AsignaMarca(rowSelected.attributes.id);
    },
    CargaGrid: function () {
        $('#cargandoInfoBM').show();
        var url = contextPath + "OrdenEmbarque/CargaMarcas?idProyecto=" + MarcaBuscar.idProyecto + "&idEtapa=" + MarcaBuscar.idEtapa; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            MarcaBuscar.colMarcas = new Backbone.Collection(data);
            var bolFilter = MarcaBuscar.colMarcas.length > 0 ? true : false;
            if (bolFilter) {
                gridMarca = new bbGrid.View({
                    container: $('#bbGrid-buscaMarcas'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: MarcaBuscar.colMarcas,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proyecto', name: 'NombreProyecto', filter: true, filterType: 'input' },
                               { title: 'Etapa', name: 'idEtapa', filter: true, filterType: 'input' },
                               { title: 'Marca', name: 'NombreMarca', filter: true, filterType: 'input' },
                               { title: 'Piezas', name: 'Piezas', filter: true, filterType: 'input' },
                               { title: 'Peso', name: 'Peso', filter: true, filterType: 'input' },
                               { title: 'Total', name: 'Total', filter: true, filterType: 'input' },
                               { title: 'Plano', name: 'NombrePlano', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        MarcaBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoBM').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Marcas.");
                $('#bbGrid-buscaMarcas')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Marcas");
        });
    }
};