//js Modulo de Generacion de documentos
//David Galvan
//22/Marzo/2016
var GenDocumentos = {
    accEscritura: false,
    accSeguridad: false,    
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);

        $("#rptLGPResumen").click(that.onLGPResumen);
        $("#rptLGPDespiece").click(that.onLGPDespiece);
        $("#rptOPCorte").click(that.onOPCorte);
        $("#rptOPPantografo").click(that.onOPPantografo);
        $("#rptRGMateriales").click(that.onRGMateriales);
        
    },
    onRGMateriales: function () {
        var idProyecto = $('#idProyectoSelect').val(),
            idEtapa = $('#idEtapaSelect').val(),
            btn = this,
            data = '',
            url = contextPath + "GenerarDocumentos/RGMateriales"; // El url del controlador   
        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa;

        $(btn).attr("disabled", "disabled");
        $.post(url, data, function (result) {
            console.log(result);
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo generar el Requerimiento General de Materiales.");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onOPPantografo: function () {

    },
    onOPCorte: function(){

    },
    onLGPDespiece: function (){

    },
    onLGPResumen: function(){
        var idProyecto = $('#idProyectoSelect').val(),
            idEtapa = $('#idEtapaSelect').val(),
            data = '',
            btn = this,
            url = contextPath + "GenerarDocumentos/LGPResumen"; // El url del controlador   

        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa;

        $(btn).attr("disabled", "disabled");
        $.post(url, data, function (result) {
            console.log(result);
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo generar el Resumen de la lista general de partes.");
        }).always(function () { $(btn).removeAttr("disabled"); });
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
            ProyectoBuscar.parent = GenDocumentos;
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
            EtapaBuscar.parent = GenDocumentos;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
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
        $('#frmListaPartes').hide();

        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {
        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        ///Mestra los botones de genera reportes
        $('.acciones').show();
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = GenDocumentos;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    ExportarExcel: function (csvInfo) {
        //Generate a file name
        var fileName = "Lista_Partes_Err";

        //inicializa el formato del archivo csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + escape(csvInfo);

        //Se genera un tag temporal <a /> 
        var link = document.createElement("a");
        link.href = uri;

        //se oculta el link
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";

        //Dispara el evento para mostrar el archivo con los datos
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
};

$(function () {
    GenDocumentos.Inicial();
})

