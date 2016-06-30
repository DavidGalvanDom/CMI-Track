//js de catalogo de existencias.
//David Jasso
//02/Febrero/2016

var Existencias = {
    activeForm: '',
    colExistencias: {},
    gridExistencias: {},
    colAlmacen: [],
    colGrupo: [],
    materilActivo: '',
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.CargarColeccionAlmacen();
        this.CargarColeccionGrupo();
    },
    Eventos: function () {
        var that = this;
        var idM = '';
        $("#btnBuscarMat").click(that.onBuscarMaterial);
        $("#btnBuscarMatA").click(that.onBuscarMaterial);
        $("#idGrupoDe").change(that.onResetOptions);
        $("#idGrupoA").change(that.onResetOptions);
        $("#idAlmacenA").change(that.onResetOptions);
        $("#idAlmacenDe").change(that.onResetOptions);

        $("#btnImprimir").click(that.onImprimir);
        $("#btnBuscar").click(that.onBuscar);
    },
    onResetOptions: function () {
        $('#bbGrid-clear')[0].innerHTML = '';
        $('#Imprimir').hide();
    },
    onBuscar: function () {
        if ($('#selectedidMaterialM').val() === '' && $('#selectedidMaterialA').val() === '' &&
            $('#idAlmacenDe').val() === '' && $('#idAlmacenA').val() === '' &&
            $('#idGrupoDe').val() === '' && $('#idGrupoA').val() === '') {
            CMI.DespliegaError("Debe seleccionar por lo menos un criterio de busqueda.");
        } else {
            $('#bbGrid-clear')[0].innerHTML = '';
            $('#Imprimir').hide();
            Existencias.CargaGrid($('#selectedidMaterialM').val(), $('#selectedidMaterialA').val() ,
                                  $('#idAlmacenDe').val(), $('#idAlmacenA').val(),
                                  $('#idGrupoDe').val(), $('#idGrupoA').val());
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_existencias.html",
            rptTemplate = '',
            tabla_html,
            tablatmp = '',
            tableData,
            tcompleta = '',
            urlData = '?matrialDe=' + $('#selectedidMaterialM').val() + '&materialA=' + $('#selectedidMaterialA').val() +
                    '&almacenDe=' + $('#idAlmacenDe').val() + '&almacenA=' + $('#idAlmacenA').val() +
                    '&grupoDe=' + $('#idGrupoDe').val() + '&grupoA=' + $('#idGrupoA').val(),
            tablaheader;

        var f = new Date();
        $.get(templateURL, function (data) {
            rptTemplate = data;

            var url = contextPath + "Existencias/CargaExistencias" + urlData;
            $.getJSON(url, function (dataRows) {
                tableData = dataRows;
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td colspan='2'>" + tableData[i]['NombreGrupo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['idMaterial'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['NombreMaterial'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Ancho'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['UMAncho'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Largo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['UMLargo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Calidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Inventario'] + "</td>";
                    tcompleta += "</tr>";
                }

                rptTemplate = rptTemplate.replace('vrAlmacen', $('#idAlmacenDe option:selected').text().toUpperCase());
                rptTemplate = rptTemplate.replace('vrAlmacenA', $('#idAlmacenA option:selected').text().toUpperCase());
                rptTemplate = rptTemplate.replace('vrMaterial', $('#idMaterialM').val());
                rptTemplate = rptTemplate.replace('vrMaterialA', $('#idMaterialA').val());
                rptTemplate = rptTemplate.replace('vrGrupo', $('#idGrupoDe option:selected').text().toUpperCase());
                rptTemplate = rptTemplate.replace('vrGrupoA', $('#idGrupoA option:selected').text().toUpperCase());


                rptTemplate = rptTemplate.replace('vrFecha', f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                rptTemplate = rptTemplate.replace('vrImagen', "<img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' />");
                tablatmp = rptTemplate.replace('vrDetalle', tcompleta);
                var tmpElemento = document.createElement('a');
                var data_type = 'data:application/vnd.ms-excel';
                tabla_html = tablatmp.replace(/ /g, '%20');
                tmpElemento.href = data_type + ', ' + tabla_html;
                //Asignamos el nombre a nuestro EXCEL
                tmpElemento.download = 'Existencias.xls';
                // Simulamos el click al elemento creado para descargarlo
                tmpElemento.click();

                //getJSON fail
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
            });
        });
    },
    onBuscarMaterial: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Material/BuscarMaterial"; 
        $.get(url, function (data) {
            $('#buscar-Material').html(data);
            $('#buscar-Material').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            MaterialBuscar.parent = Existencias;
            MaterialBuscar.Inicial();
            Existencias.materilActivo = btn.getAttribute('data-texto');
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Materiales");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaMaterial: function (id, NombreMaterial,
                   AnchoMaterial, LargoMaterial,
                   PesoMaterial, CalidadMaterial) {

        $('#' + Existencias.materilActivo).val( NombreMaterial );
        $('#selected' + Existencias.materilActivo).val(id);

        $('#buscar-Material').modal('hide');
        $('#bbGrid-clear')[0].innerHTML = '';
        $('#Imprimir').hide();
    },
    CargarColeccionAlmacen: function () {
        var form = Existencias.activeForm;
        if (Existencias.colAlmacen.length < 1) {
            var url = contextPath + "Almacen/CargaAlmacenesActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                Existencias.colAlmacen = data;
                Existencias.CargaListaAlmacenes(form);
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            Existencias.CargaListaAlmacenes(form);
        }
    },
    CargarColeccionGrupo: function () {
        var form = Existencias.activeForm;
        if (Existencias.colGrupo.length < 1) {
            var url = contextPath + "Grupo/CargaGruposActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                Existencias.colGrupo = data;
                Existencias.CargaListaGrupos(form);
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de los grupos");
            });
        } else {
            Existencias.CargaListaGrupos(form);
        }
    },
    CargaListaGrupos: function (form) {
        var select = $(form + ' #idGrupoDe').empty();
        var selectA = $(form + ' #idGrupoA').empty();

        select.append('<option> </option>');
        selectA.append('<option> </option>');

        $.each(Existencias.colGrupo, function (i, item) {
            var valor = '<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreGrupo
                                 + '</option>';
            select.append(valor);
            selectA.append(valor);
        });
    },
    CargaListaAlmacenes: function (form) {
        var select = $(form + ' #idAlmacenA').empty();
        var selectD = $(form + ' #idAlmacenDe').empty();

        select.append('<option> </option>');
        selectD.append('<option> </option>');

        $.each(Existencias.colAlmacen, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreAlmacen
                                 + '</option>');
            selectD.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreAlmacen
                                 + '</option>');
        });
    },
    CargaGrid: function (matrialDe, materialA,
                         almacenDe, almacenA,
                         grupoDe, grupoA) {
        $('#cargandoInfo').show();
        var url = contextPath + "Existencias/CargaExistencias",
            data = '?matrialDe=' + matrialDe + '&materialA=' + materialA +
                    '&almacenDe=' + almacenDe + '&almacenA=' + almacenA +
                    '&grupoDe=' + grupoDe + '&grupoA=' + grupoA;
        $.getJSON(url + data, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Existencias.colExistencias = new Backbone.Collection(data);
            var bolFilter = Existencias.colExistencias.length > 0 ? true : false;
            if (bolFilter) {
                gridExistencias = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: false,
                    detalle: false,
                    clone: false,
                    editar: false,
                    borrar: false,
                    collection: Existencias.colExistencias,
                    colModel: [{ title: '#', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Grupo', name: 'NombreGrupo', filter: true, filterType: 'input' },
                               { title: 'id Material', name: 'idMaterial', filter: true, filterType: 'input' },
                               { title: 'Material', name: 'NombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'UM Ancho', name: 'UMAncho', filter: true, filterType: 'input' },
                               { title: 'Largo', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'UM Largo', name: 'UMLargo', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Existencia', name: 'Inventario', filter: true }]
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
    Existencias.Inicial();
});