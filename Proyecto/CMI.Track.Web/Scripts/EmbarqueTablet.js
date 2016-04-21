/*global $, CMI, Backbone, bbGrid*/
//js de Generacion de Embarque Tablet
//David Galvan
//20/Abril/2016
var EmbarqueTablet = {
    activeForm: '',
    estatusRevision: 0,
    gridEmbarque: {},
    colEmbarques: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarOrdenEmbarque").click(that.onBuscarOrdenEmbarque);
        $('.btnNuevo').click(that.Nuevo);
        $('#etapaRow').hide();
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
            ProyectoBuscar.parent = EmbarqueTablet;
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
            EtapaBuscar.parent = EmbarqueTablet;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarOrdenEmbarque: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/BuscarOrdenEmbarque/"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            OrdenEmbarqueBuscar.idProyecto = $('#idProyectoSelect').val();
            OrdenEmbarqueBuscar.revisionProyecto = $('#RevisionPro').text();
            OrdenEmbarqueBuscar.idEtapa = $('#idEtapaSelect').val();
            OrdenEmbarqueBuscar.parent = EmbarqueTablet;
            OrdenEmbarqueBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaProyecto: function (idProyecto, Revision,
                             NombreProyecto, CodigoProyecto,
                             FechaInicio, FechaFin,
                             idEstatusRevision) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        EmbarqueTablet.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }

        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-Embarques')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('.btnNuevo').hide();

        $('#etapaRow').show();
        $('#ordenEmbarqueRow').hide();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        $('#idOrdenEmbarSelect').val(0);
        $('#idOrdenEmbarque').text('Orden Embarque');
        $('#idOrdenProduccion').text('Orden Produccion');
        $('#FechaCreacionOE').text('Fecha Creacion');
        $('#Observacion').text('Observacion');

        $('#ordenEmbarqueRow').show();

    },
    AsignaOrdenEmbarque: function (idOrdenEmbarque, idOrdenProduccion, 
                                    observacion, fecha){

        $('#idOrdenEmbarSelect').val(idOrdenEmbarque);
        $('#idOrdenEmbarque').text(idOrdenEmbarque);
        $('#idOrdenProduccion').text(idOrdenProduccion);
        $('#FechaCreacionOE').text(fecha);
        $('#Observacion').text(observacion);
        $('#buscar-General').modal('hide');
        //Se carga el grid de EmbarqueTablet asignadas a la Orden
        $('#bbGrid-Embarques')[0].innerHTML = "";
        //EmbarqueTablet.CargaGrid();

    },
    IniciaDateControls: function () {
        var form = EmbarqueTablet.activeForm;
        $(form + ' #dtpFechaInicio').datetimepicker({ format: 'DD/MM/YYYY' });
        $(form + ' #dtpFechaFin').datetimepicker({
            useCurrent: false,
            format: 'DD/MM/YYYY'
        });
        $(form + ' #dtpFechaInicio').on("dp.change", function (e) {
            $('#dtpFechaFin').data("DateTimePicker").minDate(e.date);
        });
        $(form + ' #dtpFechaFin').on("dp.change", function (e) {
            $('#dtpFechaInicio').data("DateTimePicker").maxDate(e.date);
        });
    },
    serializaEmbarqueTablet: function (id) {
        var form = EmbarqueTablet.activeForm;
        return ({
            'nombrePlanoMontaje': $(form + ' #nombrePlanoMontaje').val().toUpperCase(),
            'fechaInicio': $(form + ' #fechaInicio').val(),
            'fechaFin': $(form + ' #fechaFin').val(),
            'nombreEstatus': $('#idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "GenerarEmbarque/CargaDetalleOrden?idEtapa=" + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            EmbarqueTablet.colEmbarques = new Backbone.Collection(data);
            var bolFilter = EmbarqueTablet.colEmbarques.length > 0 ? true : false;
            if (bolFilter) {
                gridPlanosMontaje = new bbGrid.View({
                    container: $('#bbGrid-Embarques'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    collection: PlanosMontaje.colEmbarques,
                    seguridad: PlanosMontaje.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre PlanosMontaje', name: 'nombrePlanoMontaje', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'fechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'fechaFin', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron el detalle de la orden de Embarque seleccionada");
                $('#bbGrid-Embarques')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de la Orden de Embarque");
        });
    }
};

$(function () {
    EmbarqueTablet.Inicial();
})