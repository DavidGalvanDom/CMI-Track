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
            Kardex.CargaGrid(idM, $('#idAlmacen').val());
            $('#Imprimir').show();
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_kardex.html";
        var rptTemplate = '';
        var tabla_html;
        var tablatmp = '';
        var tableData;
        var tablaheader;
        var total = 0;
        var tcompleta = ''
        var urlImagen = window.location.protocol + '//' + window.location.host + '//Content/images/CMI.TRACK.reportes.png';
        var f = new Date();
        $.get(templateURL, function (data) { rptTemplate = data; });
      //  var urlHeader = contextPath + "Kardex/CargaHeaderMovimientos?id=" + $('#idDoc').val(); // El url del controlador
       // $.getJSON(urlHeader, function (data) {
        //    tablaheader = data;
         //   for (j = 0; j < tablaheader.length; j++) {
            
                // rptTemplate = rptTemplate.replace('vrNoPro', tablaheader[j]['id']);
                // rptTemplate = rptTemplate.replace('vrNombrePro', tablaheader[j]['NombreProyecto']);
                // rptTemplate = rptTemplate.replace('vrFolioReq', tablaheader[j]['FolioRequerimiento']);
                // rptTemplate = rptTemplate.replace('vrDepto', tablaheader[j]['NombreDepto']);
                // rptTemplate = rptTemplate.replace('vrSolicita', tablaheader[j]['NomnreUsuario']);
           // }

            var url = contextPath + "Kardex/CargaKardex?idMaterial=" + $('#idMaterialM').val() + "&idAlmacen=" + $('#idAlmacen').val(); // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td>" + tableData[i]['NombreGrupo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['idMaterial'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['NombreMaterial'] + "</td>";
                    tcompleta += "<td>" + "</td>";
                    tcompleta += "<td>" + tableData[i]['Ancho'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Largo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['NomTipoMOvto'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['TipoMovto'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Cantidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Fecha'] + "</td>";
                    tcompleta += "</tr>";


                }
                rptTemplate = rptTemplate.replace('vrAlmacen', $('#idAlmacen').val());
                rptTemplate = rptTemplate.replace('vrFecha', f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                rptTemplate = rptTemplate.replace('vrTotal', total);
                rptTemplate = rptTemplate.replace('vrImagen', urlImagen);
                tablatmp = rptTemplate.replace('vrDetalle', tcompleta);
                var tmpElemento = document.createElement('a');
                var data_type = 'data:application/vnd.ms-excel';
                tabla_html = tablatmp.replace(/ /g, '%20');
                tmpElemento.href = data_type + ', ' + tabla_html;
                //Asignamos el nombre a nuestro EXCEL
                tmpElemento.download = 'Kardex.xls';
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
            MaterialBuscar.parent = Kardex;
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
        Kardex.CargarColeccionAlmacen();
        idM = id;
 
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
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Kardex.colKardex = new Backbone.Collection(data);
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
                               { title: 'Movimiento', name: 'NomTipoMOvto', filter: true, filterType: 'input' },
                               { title: 'Tipo Movimiento', name: 'TipoMovto', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'Fecha', filter: true }]
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
    Kardex.Inicial();
});