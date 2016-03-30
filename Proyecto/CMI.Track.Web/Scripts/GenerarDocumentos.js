/*global $, CMI, Backbone, bbGrid,ProyectoBuscar,EtapaBuscar*/
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
            url = contextPath + "GenerarDocume/RGMateriales"; // El url del controlador   
        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa +
              '&idUsuario=' + localStorage.idUser;

        $(btn).attr("disabled", "disabled");
        $.post(url, data, function (result) {
            GenDocumentos.GeneraExcelRGMateriales(result);
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
        $('.acciones').hide();
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
    GeneraExcelRGMateriales: function (arrData){
        var templateURL = contextPath + "Content/template/rpt_GeneralMateriales.html",             
             tblData = '',
             tabla_html = '';
        
        $.get(templateURL, function (rptTemplate) {
           
            for (contador = 0; contador < arrData.Excel.lstDetalle.length; contador++) {
                var item = arrData.Excel.lstDetalle[contador];

                tblData += "<tr>";
                tblData += "<td></td>";
                tblData += "<td>" + item.piezasReqGenMat + "</td>";
                tblData += "<td>PZA</td>"; 
                tblData += "<td>" + item.perfilReqGenMat.replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + item.gradoReqGenMat.replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + item.anchoReqGenMat + "</td>";
                tblData += "<td>" + item.longitudReqGenMat + "</td>";
                tblData += "<td>" + ((parseFloat(item.anchoReqGenMat) * 0.3048) * (parseFloat(item.longitudReqGenMat) * 0.3048)) + "</td>";
                tblData += "<td>" + item.kgmReqGenMat + "</td>";
                tblData += "<td></td>";
                tblData += "</tr>";
            }

            rptTemplate = rptTemplate.replace('&idProyecto&', arrData.Excel.idProyecto);
            rptTemplate = rptTemplate.replace('&NomProyecto&', $('#nombreProyecto').text());
            rptTemplate = rptTemplate.replace('&FechaDoc&', arrData.Excel.fechaSolicitud);
            rptTemplate = rptTemplate.replace('&FolioReq&', arrData.Excel.folioRequerimiento);
            rptTemplate = rptTemplate.replace('&NomEtapa&', arrData.Excel.nombreEtapa);            
            rptTemplate = rptTemplate.replace('&Depto&', arrData.Excel.departamentoP);
            rptTemplate = rptTemplate.replace('&claveEtapa&', arrData.Excel.claveEtapa);
            rptTemplate = rptTemplate.replace('&solicitado&', arrData.Excel.solicitado);
            
            tabla_html = rptTemplate.replace('&renglones&', tblData);
            console.log(tabla_html);
            var tmpElemento = document.createElement('a');
            var data_type = 'data:application/vnd.ms-excel';
            tmpElemento.href = data_type + ', ' + tabla_html;
            tmpElemento.download = 'ReporteGeneralMateriales.xls';
            tmpElemento.click();
        });       
    }
};

$(function () {
    GenDocumentos.Inicial();
});

