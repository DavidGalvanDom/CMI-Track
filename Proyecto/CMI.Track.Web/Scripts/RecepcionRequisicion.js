﻿/*global $, CMI, Backbone, bbGrid, contextPath,ProyectoBuscar, EtapaBuscar,RequisicionesBuscar, RequerimientoBuscar*/
//js de Recepcion Requisicion de compra
//David Jasso
//28/Marzo/2016

var RecepecionCompra = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    valInicial: 0,
    gridRecepcionCompra: {},
    colRecepecionCompra: {},
    colOrigenReq: [],
    colUnidadMedida: [],
    colAlmacen: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarReq").click(that.onBuscarRequerimiento);
        $("#btnBuscarRequisicion").click(that.onBuscarRequisicion);
        $("#btn-GuardaNew").click(that.onConfirmar);
        $('#groupGuardar').hide();
        $('#etapaRow').hide();
        $('#btnCollapse').hide();
    },
    onBuscarProyecto: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/BuscarProyecto"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            ProyectoBuscar.Inicial();
            ProyectoBuscar.parent = RecepecionCompra;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarEtapa: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Etapa/BuscarEtapa"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            EtapaBuscar.idProyecto = $('#idProyectoSelect').val();
            EtapaBuscar.revisionProyecto = $('#RevisionPro').text();
            EtapaBuscar.parent = RecepecionCompra;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarRequerimiento: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "ReqGralMaterial/BuscarRequerimientos"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            RequerimientoBuscar.idEtapa = $('#idEtapaSelect').val();
            RequerimientoBuscar.idProyecto = $('#idProyectoSelect').val();
            RequerimientoBuscar.parent = RecepecionCompra;
            RequerimientoBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Requerimientos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarRequisicion: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "ReqManualCompra/BuscarRequisiciones"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            RequisicionesBuscar.idEtapa = $('#idEtapaSelect').val();
            RequisicionesBuscar.idProyecto = $('#idProyectoSelect').val();
            RequisicionesBuscar.idRequerimiento = $('#idRequerimientoSelect').val();
            RequisicionesBuscar.parent = RecepecionCompra;
            RequisicionesBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Requisiciones");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onConfirmar: function () {
        var btn = this,
            dataPost = '',
            mat = [];

        CMI.botonMensaje(true, btn, 'Guardar');
        dataPost = $("Index *").serialize();

        if ($('#SerieFac').val() !== '' && $('#FacturaReq').val() !== '' &&
            $('#ProveedorFac').val() !== '' && $('#FechaFactura').val() !== '') {

            $.each(RecepecionCompra.colRecepecionCompra.models, function (index, value) {
                mat = RecepecionCompra.colRecepecionCompra.where({ id: value.id });
                if (mat[0].attributes.Existencia !== 0 ) {
                    if (parseFloat(document.getElementById(value.id).value) <= mat[0].attributes.Existencia &&
                        parseFloat(document.getElementById(value.id).value) >= 0) {
                        dataPost = dataPost + '&lstMS=' + mat[0].attributes.idMaterial + ',' +
                                    parseFloat(document.getElementById(value.id).value) + ',' +
                                    $('#SerieFac').val() + ',' + $('#FacturaReq').val() + ',' +
                                    $('#ProveedorFac').val() + ',' + $('#FechaFactura').val() + ',' +
                                    $('#idRequerimientoSelect').val() + ',' + $('#idRequisicionSelect').val() + ',' +
                                    value.id + ',' + localStorage.idUser;
                    } else {
                       $('#' + value.id).addClass('input-validation-error');
                        dataPost = '';
                        return false;
                    }
                }
            });
            
            if (dataPost === '') { CMI.botonMensaje(false, btn, 'Guardar'); CMI.DespliegaError("Favor de validar la información."); return; }
            //Se hace el post para guardar la informacion
            $.post(contextPath + "RecepcionRequisicion/Actualiza",
                dataPost,
                function (data) {
                    if (data.Success === true) {
                        CMI.DespliegaInformacion(data.Message);
                        $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = '';
                        RecepecionCompra.CargaGrid();
                        dataPost = '';
                    } else {
                        CMI.DespliegaError(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaError("Error al guardar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        } else {
            CMI.DespliegaError("La información de la factura esta incompleta");
            CMI.botonMensaje(false, btn, 'Guardar');
        }
        dataPost = '';
    },
    AsignaProyecto: function (idProyecto, Revision,
                             NombreProyecto, CodigoProyecto,
                             FechaInicio, FechaFin) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        //Se inicializa la informacion seleccionada a vacio
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');
        $('#idRequisicion').text('Requisicion');
        $('#SerieFac').text('Serie');
        $('#FacturaReq').text('Factura');
        $('#ProveedorFac').text('Proveedor');
        $('#FechaFactura').text('Fecha Factura');
        $('#groupGuardar').hide();
        $('#btnCollapse').hide();
        $('#requerimientoRow').hide();
        $('#requisicionRow').hide();
        $('#DatosFactura').hide();
        $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";
        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');
        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');
        $('#idRequisicion').text('Requisicion');
        $('#SerieFac').text('Serie');
        $('#FacturaReq').text('Factura');
        $('#ProveedorFac').text('Proveedor');
        $('#FechaFactura').text('Fecha Factura');

        $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";
        $('#groupGuardar').hide();
        $('#btnCollapse').hide();
        $('#DatosFactura').hide();
        $('#requisicionRow').hide();
        $('#requerimientoRow').show();

    },
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento, fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');
        $('#idRequisicion').text('Requisicion');
        $('#SerieFac').text('Serie');
        $('#FacturaReq').text('Factura');
        $('#ProveedorFac').text('Proveedor');
        $('#FechaFactura').text('Fecha Factura');

        $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";
        $('#groupGuardar').hide();
        $('#btnCollapse').hide();
        $('#DatosFactura').hide();
        $('#requisicionRow').show();
    },
    AsignaRequisicion: function (id, NombreOrigen,
                                Causa, Estatus,
                                Serie, Factura,
                                Proveedor, FechaFac) {

        $('#idRequisicion').text(id);
        $('#idRequisicionSelect').val(id);
        $('#OrigenReq').text(NombreOrigen);
        $('#Causa').text(Causa);
        $('#Estatus').text(Estatus);
        $('#SerieFac').val(Serie);
        $('#FacturaReq').val(Factura);
        $('#ProveedorFac').val(Proveedor);
        $('#FechaFactura').val(FechaFac);
        $('#buscar-General').modal('hide');

        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";

        RecepecionCompra.CargaGrid();
        RecepecionCompra.IniciaDateControls();

        $('#myCollapsible').collapse('hide');
        $('#groupGuardar').show();
        $('#btnCollapse').show();
        $('#requisicionRow').show();

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = RecepecionCompra;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    IniciaDateControls: function () {
        var form = RecepecionCompra.activeForm;
        $(form + ' #dtpFechaFactura').datetimepicker({ format: 'MM/DD/YYYY' });
    },
    focusOut: function (input){
        var total = 0;
        //Actuliza el total 
        if (RecepecionCompra.valInicial !== input.value) {
            total = parseFloat($('#lblTotalReci').text());
            total = total + (input.value - RecepecionCompra.valInicial);
            $('#lblTotalReci').text(total);
        }
    },
    focusIn: function (input) {
        RecepecionCompra.valInicial = input.value;
    },
    CargaGrid: function () {
        var url = contextPath + "RecepcionRequisicion/CargaDetalleRequisicion?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val() + '&idRequerimiento=' + $('#idRequerimientoSelect').val() + '&idRequisicion=' + $('#idRequisicionSelect').val(),
            total = 0,
            validar = 0; // El url del controlador
        $('#cargandoInfo').show();
        $.getJSON(url, function (data) {
            $('#DatosFactura').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); $('#cargandoInfo').hide(); return; }

            $.each(data, function (index, value) {
                total = total + parseFloat(value.cantidadRecibida);
                if (value.Existencia != 0) {
                    validar = 1;
                }
                if (value.Existencia === 0) {
                    value.cantidadRecibida = " <input disabled onblur='RecepecionCompra.focusOut(this);' onFocus='RecepecionCompra.focusIn(this);' id='" + value.id + "' type=\"number\" class=\"form-control\" tabindex='" + index + "'  value='" + value.cantidadRecibida + "' /> ";
                } else {
                    value.cantidadRecibida = " <input onblur='RecepecionCompra.focusOut(this);' onFocus='RecepecionCompra.focusIn(this);' id='" + value.id + "' type=\"number\" class=\"form-control\" tabindex='" + index + "'  value='" + value.cantidadRecibida + "' /> ";
                }
            });
            $('#lblTotalReci').text(total);
            $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";
            RecepecionCompra.colRecepecionCompra = new Backbone.Collection(data);
            var bolFilter = RecepecionCompra.colRecepecionCompra.length > 0 ? true : false;
            if (bolFilter) {

                if (RecepecionCompra.accEscritura === true)
                    $('#groupGuardar').show();

                RecepecionCompra.gridRecepcionCompra = new bbGrid.View({
                    container: $('#bbGrid-DetalleRequisicionCompras'),
                    enableTotal: true,
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: RecepecionCompra.accClonar,
                    editar: RecepecionCompra.accEscritura,
                    borrar: RecepecionCompra.accBorrar,
                    collection: RecepecionCompra.colRecepecionCompra,
                    seguridad: RecepecionCompra.accSeguridad,
                    colModel: [{ title: 'Item', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterial', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Unidad', name: 'UM', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'Cantidad Solicitada', name: 'cantidadSol', filter: true, filterType: 'input', total: 0 },
                               { title: 'Saldo', name: 'Existencia', filter: true, filterType: 'input', total: 0 },
                               { title: 'Recibido', name: 'cantidadRecibida'},
                               { title: ' Long(m)-Area(m2)', name: 'LongArea', filter: true, filterType: 'input', total: 0 },
                               { title: 'kg/m-kg/m2', name: 'Peso', filter: true, filterType: 'input', total: 0 },
                               { title: 'Total', name: 'Total', total: 0 }]
                });
                $('#cargandoInfo').hide();
                if (validar === 1) {
                    $('#btn-GuardaNew').show();
                } else {
                    $('#btn-GuardaNew').hide();
                }
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales registradas para la requisición seleccionada.");
                $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de las ReqManualCompras");
        });
    }
};

$(function () {
    RecepecionCompra.Inicial();
});