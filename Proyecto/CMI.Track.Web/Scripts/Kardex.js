//js de catalogo de kardex.
//David Jasso
//02/Febrero/2016

var Kardex = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    activeForm: '',
    colKardex: {},
    gridKardex: {},
    colAlmacen: [],
    idMaterialSel : 0,
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarMat").click(that.onBuscarMaterial);
        $("#idAlmacen").change(that.onCambiaAlmacen);
        $("#btnImprimir").click(that.onImprimir);
    },
    onCambiaAlmacen: function () {
        if ($('#idAlmacen').val() === '') {
            $('#CausaDiv').show();
            $('#Imprimir').hide();
            $('#bbGrid-clear')[0].innerHTML = "";
        } else {
            $('#bbGrid-clear')[0].innerHTML = '';
            $('#Imprimir').hide();
            Kardex.CargaGrid(Kardex.idMaterialSel, $('#idAlmacen').val());
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_kardex.html",
             rptTemplate = '',
             tabla_html,
             tablatmp = '',
             tableData,
             tablaheader,
             total = 0,
             Existe = 0,
             tcompleta = '',
             f = new Date();
        $.get(templateURL, function (dataTemplate) {

            rptTemplate = dataTemplate;

            var url = contextPath + "Kardex/CargaKardex?idMaterial=" + Kardex.idMaterialSel + "&idAlmacen=" + $('#idAlmacen').val(); // El url del controlador
            $.getJSON(url, function (data) {

                if (data.Success === true) {
                    tableData = data.data;
                    for (i = 0; i < tableData.length; i++) {
                        tcompleta += "<tr>";
                        tcompleta += "<td>" + tableData[i]['NombreGrupo'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['idMaterial'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['NombreMaterial'] + "</td>";
                        tcompleta += "<td>" + "</td>";
                        tcompleta += "<td>" + tableData[i]['Ancho'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['Largo'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['Documento'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['NomTipoMOvto'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['TipoMovto'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['Cantidad'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['Fecha'] + "</td>";
                        tcompleta += "</tr>";
                        total += tableData[i]['Cantidad'];
                        Existe = tableData[i]['Inventario'];
                    }
                    rptTemplate = rptTemplate.replace('vrAlmacen', $('#idAlmacen  option:selected').text().toUpperCase());
                    rptTemplate = rptTemplate.replace('vrMaterial', $('#idMaterialM').val());

                    rptTemplate = rptTemplate.replace('vrFecha', f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                    rptTemplate = rptTemplate.replace('vrSaldo', total);
                    rptTemplate = rptTemplate.replace('vrExistencias', Existe);
                    rptTemplate = rptTemplate.replace('vrImagen', "<img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' />");
                    tablatmp = rptTemplate.replace('vrDetalle', tcompleta);
                    var tmpElemento = document.createElement('a');
                    var data_type = 'data:application/vnd.ms-excel';
                    tabla_html = tablatmp.replace(/ /g, '%20');
                    tmpElemento.href = data_type + ', ' + tabla_html;
                    //Asignamos el nombre a nuestro EXCEL
                    tmpElemento.download = 'Kardex.xls';
                    // Simulamos el click al elemento creado para descargarlo
                    tmpElemento.click();
                } else {
                    CMI.DespliegaError(data.Message);
                }

                //getJSON fail
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion del Kardex");
            });
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la plantilla rpt_kardex");
        });
    },
    onBuscarMaterial: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Material/BuscarMaterial"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-Material').html(data);
            $('#buscar-Material').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            MaterialBuscar.parent = Kardex;
            MaterialBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Materiales");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaMaterial: function (id, NombreMaterial,
                   AnchoMaterial, LargoMaterial, PesoMaterial, CalidadMaterial) {
        $('#idMaterialM').val(NombreMaterial);
        Kardex.idMaterialSel = id;
        $('#buscar-Material').modal('hide');
        $('#bbGrid-clear')[0].innerHTML = '';
        $('#Imprimir').hide();
        Kardex.CargarColeccionAlmacen();
    },
    CargarColeccionAlmacen: function () {
        var form = Kardex.activeForm;
        if (Kardex.colAlmacen.length < 1) {
            var url = contextPath + "Almacen/CargaAlmacenesActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                Kardex.colAlmacen = data;
                Kardex.CargaListaAlmacenes(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            Kardex.CargaListaAlmacenes(form);
        }
    },
    CargaListaAlmacenes: function (form) {
        var select = $(form + ' #idAlmacen').empty();

        select.append('<option> </option>');

        $.each(Kardex.colAlmacen, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreAlmacen
                                 + '</option>');
        });

        $(form + '#idAlmacen').val($(form + '#idAlmacen').val());
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = Kardex;
        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();
    },
    CargaGrid: function (id,idAlmacen) {
        $('#cargandoInfo').show();
        var url = contextPath + "Kardex/CargaKardex?idMaterial=" + id + "&idAlmacen=" + idAlmacen; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== true) { CMI.DespliegaError(data.Message); return; }
            Kardex.colKardex = new Backbone.Collection(data.data);
            var bolFilter = Kardex.colKardex.length > 0 ? true : false;
            if (bolFilter) {
                gridKardex = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: false,
                    detalle: false,
                    clone: Kardex.accClonar,
                    editar: Kardex.accEscritura,
                    borrar: Kardex.accBorrar,
                    collection: Kardex.colKardex,
                    colModel: [{ title: '#', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Grupo', name: 'NombreGrupo', filter: true, filterType: 'input' },
                               { title: 'id Material', name: 'idMaterial', filter: true, filterType: 'input' },
                               { title: 'Material', name: 'NombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Almacen', name: 'NombreAlmacen', filter: true, filterType: 'input' },
                               { title: 'Documento', name: 'Documento', filter: true, filterType: 'input' },
                               { title: 'Movimiento', name: 'NomTipoMOvto', filter: true, filterType: 'input' },
                               { title: 'Tipo Movimiento', name: 'TipoMovto', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'Fecha', filter: true }]
                });
                $('#cargandoInfo').hide();
                $('#Imprimir').show();
            } else {
                CMI.DespliegaInformacion("No se encontraron registros");
                $('#bbGrid-clear')[0].innerHTML = "";
                $('#Imprimir').hide();
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion");
        });
    }
};

$(function () {
    Kardex.Inicial();
});