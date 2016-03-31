/*global $, CMI, ProyectoBuscar,EtapaBuscar,routeUrlImages,contextPath*/
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
    onRGMateriales: function (e) {
        var idProyecto = $('#idProyectoSelect').val(),
            idEtapa = $('#idEtapaSelect').val(),
            btn = this,
            data = '',
            url = contextPath + "GenerarDocume/RGMateriales"; // El url del controlador   
        
        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa +
              '&idUsuario=' + localStorage.idUser;

        CMI.botonMensaje(true, btn, "Requerimiento de Materiales");
        $.post(url, data, function (result) {
            if (result.Success === true) {
                GenDocumentos.GeneraExcelRGMateriales(result);
            } else {
                CMI.DespliegaErrorDialogo(result.Message);
            }
                        
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo generar el Requerimiento General de Materiales.");
        }).always(function () { CMI.botonMensaje(false, btn, ' <a href="#">   <span class="fa fa-archive"></span>   Requerimiento de Materiales</a>'); });
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
        var  tblDataRow = '',
             tabla = '',
             total = 0,
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '';
            
        if (arrData.Excel.lstDetalle !== null) {
            for (var contador = 0; contador < arrData.Excel.lstDetalle.length; contador++) {
                var item = arrData.Excel.lstDetalle[contador];

                tblDataRow += "<tr>";
                tblDataRow += "<td></td>";
                tblDataRow += "<td>" + item.piezasReqGenMat + "</td>";
                tblDataRow += "<td>PZA</td>";
                tblDataRow += "<td>" + item.perfilReqGenMat.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.gradoReqGenMat.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.anchoReqGenMat + "</td>";
                tblDataRow += "<td>" + item.longitudReqGenMat + "</td>";
                tblDataRow += "<td>" + ((parseFloat(item.anchoReqGenMat) * 0.3048) * (parseFloat(item.longitudReqGenMat) * 0.3048)) + "</td>";
                tblDataRow += "<td>" + item.kgmReqGenMat + "</td>";
                tblDataRow += "<td>" + item.piezasReqGenMat * (item.longitudReqGenMat * 0.3048) * item.kgmReqGenMat + "</td>";
                tblDataRow += "</tr>";

                total += (item.piezasReqGenMat * (item.longitudReqGenMat * 0.3048) * item.kgmReqGenMat);
            }
        }
            header += "<tr>";
            header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
            header += "<td > <table> <tr > <td colspan='2'> </td> </tr>";
            header += "<tr> <td colspan='2' align='center'><strong>REQUERIMIENTO</strong></td> </tr> ";
            header += "<tr> <td colspan='2' align='center'><strong> ETAPA #" + arrData.Excel.claveEtapa + "</strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
            header += "<tr> <td colspan='2' align='center'><strong><i> " + arrData.Excel.nombreEtapa + "</i></strong> </td> </tr> <tr> <td colspan='2' align='center'style='color:red;'><strong>Rev." + arrData.Excel.revisionProyecto + "</strong></td></tr></table></td> ";
            header += "<td> <table > <tr align='right'><td></td><td></td><td></td><td style='border:solid;border-size:2;' align='center'><strong>No.</strong></td></tr> <tr align='center'>  <td></td><td></td><td></td> <td style='border:solid;border-size:2;'><strong>" + arrData.Excel.idProyecto + "</strong></td> </tr><tr align='right'> <td  colspan='4'>FECHA:</td></tr><tr align='right'><td colspan='4'>Folio Req.</td></tr><tr align='right'> <td  colspan='4'>DEPARTAMENTO:</td></tr><tr align='right'><td  colspan='4'>SOLICITADO POR:</td></tr></table>";
            header += "</td><td><table><tr align='center'><td style='border:solid;border-size:2';>PROYECTO</td></tr><tr align='center'><td style='border:solid;border-size:2;'><strong>" + $('#nombreProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + arrData.Excel.fechaSolicitud + "</strong></td></tr>";
            header += "<tr><td  align='center'><strong>" + arrData.Excel.folioRequerimiento + "</strong></td></tr>";
            header += "<tr><td  align='center'>" + arrData.Excel.departamentoP + "</td></tr>";
            header += "<tr><td  align='center'>" + arrData.Excel.solicitado + "</td></tr></table></td></tr>";

            tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Partida</strong></td><td rowspan='2'><strong>Cantidad</strong></td><td rowspan='2'><strong>Unidad</strong></td><td rowspan='2' colspan='1'><strong>DESCRIPCION</strong></td><td rowspan='2' colspan='1'><strong>Calidad<br>de Acero</strong></td><td rowspan='2'><strong>Ancho<br>(ft.)</strong></td><td rowspan='2'><strong>Long.<br>( ft.)</strong></td><td rowspan='2'><strong>Long.(m)<br>Area (m2)</strong></td><td rowspan='2'><strong>Kg/m<br>Kg/m2</strong></td><td rowspan='2'><strong>TOTAL<br>( Kg )</strong></td></tr></table>";
            tcompleta = "<table border='2'><tr><td><table border='1'>";
            tcompleta += tblDataRow;
            tcompleta += "</table></td></tr><table><tr><td colspan='8'></td><td align='right'>TOTAL</td><td style='border:solid;border-size:2;'>" + total + "</td></tr></table></table>";
            header += tabla + tcompleta;

            var tmpElemento = document.createElement('a'),
                data_type = 'data:application/vnd.ms-excel',
                tabla_div = header;

            tabla_html = tabla_div.replace(/ /g, '%20');

            tmpElemento.href = data_type + ', ' + tabla_html;
            //Asignamos el nombre a nuestro EXCEL
            tmpElemento.download = 'RequerimientoGeneralMateriales.xls';
            // Simulamos el click al elemento creado para descargarlo
            tmpElemento.click();
    }
};

$(function () {
    GenDocumentos.Inicial();
});

