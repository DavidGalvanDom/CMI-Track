//js de catalogo de existencias.
//David Jasso
//02/Febrero/2016

var Existencias = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    activeForm: '',
    colExistencias: {},
    gridExistencias: {},
    colAlmacen: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        var idM = '';
        $("#btnBuscarMat").click(that.onBuscarMaterial);
        $("#idAlmacen").change(that.onCambiaAlmacen);
        $("#btnImprimir").click(that.onImprimir);
       // $('#rowAlmacen').hide();
    },
    onCambiaAlmacen: function () {

        if ($('#idAlmacen').val() == '') {
            $('#CausaDiv').show();
        }
        else {
            $('#bbGrid-clear')[0].innerHTML = '';
            Existencias.CargaGrid(idM, $('#idAlmacen').val());
            $('#Imprimir').show();
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_existencias.html";
        var rptTemplate = '';
        var tabla_html;
        var tablatmp = '';
        var tableData;
        var tablaheader;

        var tcompleta = ''
        var f = new Date();
        $.get(templateURL, function (data) { rptTemplate = data; });
   
        var url = contextPath + "Existencias/CargaExistencias?idMaterial=" + $('#idMaterialM').val() + "&idAlmacen=" + $('#idAlmacen').val(); // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
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
                rptTemplate = rptTemplate.replace('vrAlmacen', $('#idAlmacen').val());
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
      //  });


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
            MaterialBuscar.parent = Existencias;
            MaterialBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Materiales");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaMaterial: function (id, NombreMaterial,
                   AnchoMaterial, LargoMaterial, PesoMaterial, CalidadMaterial) {
        $('#idMaterialM').val(id);
        $('#idMaterialSelect').val(id);
        $('#buscar-Material').modal('hide');
        $('#bbGrid-clear')[0].innerHTML = '';
        Existencias.CargarColeccionAlmacen();
        idM = id;
 
    },
    CargarColeccionAlmacen: function () {
        var form = Existencias.activeForm;
        if (Existencias.colAlmacen.length < 1) {
            var url = contextPath + "Almacen/CargaAlmacenesActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                Existencias.colAlmacen = data;
                Existencias.CargaListaAlmacenes(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            Existencias.CargaListaAlmacenes(form);
        }
    },
    CargaListaAlmacenes: function (form) {
        var select = $(form + ' #idAlmacen').empty();

        select.append('<option> </option>');

        $.each(Existencias.colAlmacen, function (i, item) {
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
            modulo = Existencias;
        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },

    CargaGrid: function (id,idAlmacen) {
        $('#cargandoInfo').show();
        var url = contextPath + "Existencias/CargaExistencias?idMaterial=" + id + "&idAlmacen=" + idAlmacen; // El url del controlador
        $.getJSON(url, function (data) {
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
                    clone: Existencias.accClonar,
                    editar: Existencias.accEscritura,
                    borrar: Existencias.accBorrar,
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
            } else {
                CMI.DespliegaInformacion("No se encontraron registros");
                $('#bbGrid-clear')[0].innerHTML = "";
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