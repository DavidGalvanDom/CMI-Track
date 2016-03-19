//js de lista de Materiales.
//David Jasso
//17/Febrero/2016
var MaterialBuscar = {
    colMateriales: {},
    idProyecto: 0,
    revisionProyecto: 0,
    parent: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
    },
    onSeleccionar: function (idRow) {
        var rowSelected = MaterialBuscar.colMateriales.get(idRow);
        MaterialBuscar.parent.AsignaMaterial(rowSelected.attributes.id,
                                            rowSelected.attributes.NombreMaterial,
                                            rowSelected.attributes.AnchoMaterial,
                                            rowSelected.attributes.LargoMaterial,
                                            rowSelected.attributes.PesoMaterial,
                                            rowSelected.attributes.CalidadMaterial);
    },
    CargaGrid: function () {
        $('#cargandoInfoBM').show();
        var url = contextPath + "Material/CargaMaterialesActivos"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            MaterialBuscar.colMateriales = new Backbone.Collection(data);
            var bolFilter = MaterialBuscar.colMateriales.length > 0 ? true : false;
            if (bolFilter) {
                gridMaterial = new bbGrid.View({
                    container: $('#bbGrid-buscaMateriales'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    collection: MaterialBuscar.colMateriales,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Material', name: 'NombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'AnchoMaterial', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'LargoMaterial', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'CalidadMaterial', filter: true, filterType: 'input' },
                               { title: 'Peso', name: 'PesoMaterial', filter: true, filterType: 'input' }],
                    onRowDblClick: function () {
                        MaterialBuscar.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfoBM').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Materiales.");
                $('#bbGrid-buscaMateriales')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Materiales");
        });
    }
};