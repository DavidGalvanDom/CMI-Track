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
        $('#rptTrasmital').click(that.onTrasmital);
        $("#rptLGPResumen").click(that.onLGPResumen);
        $("#rptLGPDetalle").click(that.onLGPDetalle);
        $("#rptOPCorte").click(function () { that.onOrdenProduccion('C',this); });
        $("#rptOPPantografo").click(function () { that.onOrdenProduccion('P',this); });
        $("#rptRGMateriales").click(that.onRGMateriales);
    },
    onTrasmital: function () {
        var idProyecto = $('#idProyectoSelect').val(),
           idEtapa = $('#idEtapaSelect').val(),
           btn = this,
           data = '',
           url = contextPath + "GenerarDocume/Trasmital"; // El url del controlador   

        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa +
               '&idUsuario=' + localStorage.idUser;

        CMI.botonMensaje(true, btn, "Trasmital");
        $.post(url, data, function (result) {
            if (result.Success === true) {
                GenDocumentos.GeneraExcelTramital(result);
            } else {
                CMI.DespliegaError(result.Message);
            }
        }).fail(function () {
            CMI.DespliegaError("No se pudo generar el Trasmital.");
        }).always(function () { CMI.botonMensaje(false, btn, ' <a href="#"><span class="fa fa-cogs"></span>  Trasmital</a>'); });
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

        CMI.botonMensaje(true, btn, "Requerimiento de Materiales");
        $.post(url, data, function (result) {
            if (result.Success === true) {
                GenDocumentos.GeneraExcelRGMateriales(result);
            } else {
                CMI.DespliegaError(result.Message);
            }

        }).fail(function () {
            CMI.DespliegaError("No se pudo generar el Requerimiento General de Materiales.");
        }).always(function () { CMI.botonMensaje(false, btn, ' <a href="#"><span class="fa fa-archive"></span>   Requerimiento de Materiales</a>'); });
    },
    onOrdenProduccion: function (tipo, btn) {
        var idProyecto = $('#idProyectoSelect').val(),
            idEtapa = $('#idEtapaSelect').val(),
            botonInfo = '',
            data = '',
            url = contextPath + "GenerarDocume/OrdenProduccion"; // El url del controlador   

        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa +
               '&clase=' + tipo;

        botonInfo = tipo === 'P' ? ' Orden produccion Pantografo' : '  Oreden produccion Corte';

        CMI.botonMensaje(true, btn, botonInfo);
        $.post(url, data, function (result) {
            if (result.Success === true) {
                GenDocumentos.GeneraExcelOrdenProduccion(result, tipo);
            } else {
                CMI.DespliegaError(result.Message);
            }
        }).fail(function () {
            CMI.DespliegaError("No se pudo generar el reporte de Orden de produccion.");
        }).always(function () {
            botonInfo = tipo === 'P' ? '<span class="fa fa-codepen"></span>  Orden produccion Pantografo' : '<span class="fa fa-scissors"></span>  Oreden produccion Corte';
            CMI.botonMensaje(false, btn, ' <a href="#">   ' + botonInfo + '</a>');
        });
    },
    onLGPDetalle: function (){
        var idProyecto = $('#idProyectoSelect').val(),
           idEtapa = $('#idEtapaSelect').val(),
           btn = this,
           data = '',
           url = contextPath + "GenerarDocume/LGPDetalle"; // El url del controlador

        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa +
               '&idUsuario=' + localStorage.idUser;

        CMI.botonMensaje(true, btn, "LGP Detalle");
        $.post(url, data, function (result) {
            if (result.Success === true) {
                GenDocumentos.GeneraExcelLGPDetalle(result);
            } else {
                CMI.DespliegaError(result.Message);
            }

        }).fail(function () {
            CMI.DespliegaError("No se pudo generar el reporte LGPDetalle.");
        }).always(function () { CMI.botonMensaje(false, btn, ' <span class="fa fa-list"></span>  LGP Detalle'); });
    },
    onLGPResumen: function(){
        var idProyecto = $('#idProyectoSelect').val(),
           idEtapa = $('#idEtapaSelect').val(),
           btn = this,
           data = '',
           url = contextPath + "GenerarDocume/LGPResumen"; // El url del controlador   

        data = 'idProyecto=' + idProyecto +
               '&idEtapa=' + idEtapa +
               '&idUsuario=' + localStorage.idUser;

        CMI.botonMensaje(true, btn, "LGP Resumen");
        $.post(url, data, function (result) {
            if (result.Success === true) {
                GenDocumentos.GeneraExcelLGPResumen(result);
            } else {
                CMI.DespliegaError(result.Message);
            }

        }).fail(function () {
            CMI.DespliegaError("No se pudo generar el reporte LGP Resumen.");
        }).always(function () { CMI.botonMensaje(false, btn, ' <span class="fa fa-list"></span>  LGP Resumen'); });
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
            CMI.DespliegaError("No se pudo cargar el modulo de Buscar proyectos");
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
            CMI.DespliegaError("No se pudo cargar el modulo de Buscar proyectos");
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

        GenDocumentos.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }

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
    GeneraExcelTramital: function( arrData ){
        var tblDataRow = '',
          tabla = '',
          total = 0,
          tcompleta = '',
          header = "<table border='2'>",
          tabla_html = '',
          etapa = $('#nombreEtapa').text().replace(/ /g, '&nbsp;');
        debugger
        if (arrData.Excel !== null) {
            for (var contador = 0; contador < arrData.Excel.length; contador++) {
                var item = arrData.Excel[contador];

                tblDataRow += "<tr>";
                tblDataRow += "<td>" + etapa + "</td>";
                tblDataRow += "<td>" + item.planoMontaje.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.claveMontaje.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.planoDespiece.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.claveDespiece.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='3' align='center'><strong> Trasmital </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='3' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + arrData.fecha + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";
        tabla = "<table><tr><td colspan='8'></td></tr></table>";
        tabla += "<table><tr><td colspan='4'>Para:</td><td>De:</td><td colspan='3' style='border-bottom:1pt solid black;'></td></tr></table>";
        tabla += "<table><tr><td colspan='4'>Ubicacion:</td><td>Puesto:</td><td colspan='3' style='border-bottom:1pt solid black;'></td></tr></table>";
        tabla += "<table><tr><td colspan='4'>Atencion:</td></tr></table>";
        tabla += "<table><tr><td colspan='8'></td></tr></table>";
        tabla += "<table><tr><td colspan='7'  style='border-top:1pt solid black;'>Tema:</td><td  style='border-top:1pt solid black;border-left:1pt solid black;border-right:1pt solid black;'> Arquitectura/Civil</td></tr></table>";
        tabla += "<table><tr><td colspan='7'></td><td style='border-left:1pt solid black;border-right:1pt solid black;'> Mecanico</td></tr></table>";
        tabla += "<table><tr><td colspan='7'></td><td style='border-left:1pt solid black;border-right:1pt solid black;'> Electrico</td></tr></table>";
        tabla += "<table><tr><td colspan='7'></td><td style='border-left:1pt solid black;border-right:1pt solid black;'> Estructura</td></tr></table>";
        tabla += "<table><tr><td colspan='7' style='border-bottom:1pt solid black;'></td><td  style='border-bottom:1pt solid black;border-left:1pt solid black;border-right:1pt solid black;'> Otro</td></tr></table>";
        tabla += "<table><tr><td colspan='6'>Que es lo que se envia</td><td style='border-left:1pt solid black;'>  Orden de Campo</td><td style='border-right:1pt solid black;'>  Dibujos</td></tr></table>";
        tabla += "<table><tr><td colspan='6'></td><td style='border-left:1pt solid black;' >   Orden de Compra</td><td style='border-right:1pt solid black;'>  Cotizacion</td></tr></table>";
        tabla += "<table><tr><td colspan='6'></td><td style='border-left:1pt solid black;'>  Ejemplo</td><td style='border-right:1pt solid black;'>   Especificaciones</td></tr></table>";
        tabla += "<table><tr><td colspan='6' align='center'>PLANOS IMPRESOS</td><td style='border-left:1pt solid black;'>  Minutas</td><td style='border-right:1pt solid black;'>   Boletin</td></tr></table>";
        tabla += "<table><tr><td colspan='6' style='border-bottom:1pt solid black;'></td><td style='border-left:1pt solid black;border-bottom:1pt solid black;'>  Otros</td><td style='border-right:1pt solid black;border-bottom:1pt solid black;'>   </td></tr></table>";

        tabla += "<table><tr><td colspan='4'>Informacion trasmital:</td></tr></table>";
        tabla += "<table  border='2' ><tr align='center'><td ><strong>Etapa</strong></td><td>" +
                "<strong>Montaje</strong></td><td ><strong>Clave</strong></td><td colspan='1'>" +
                "<strong>Despiece</strong></td><td colspan='1'><strong>Clave</strong></td>" +
                "</tr></table>";

        tcompleta = "<table border='2'><tr><td><table border='1'>";
        tcompleta += tblDataRow;
        tcompleta += "</table></td></tr></table>";
        header += tabla + tcompleta;

        header += "<table><tr><td colspan='8'></td></tr></table>";
        header += "<table><tr><td colspan='8' style='border-top:1pt solid black;'></td></tr></table>";
        header += "<table><tr><td colspan='8' style=''>Razon del trasmital</td></tr></table>";
        header += "<table><tr><td colspan='2' > Actualizar Informacion</td><td colspan='2' > Respuesta</td><td colspan='2' > Fabricacion</td><td colspan='2' style=''> Dudas de Cotizacion</td></tr></table>";
        header += "<table><tr><td colspan='2' >  Revision y Comentarios</td><td colspan='2' > Aclaracion</td><td colspan='2' > Aprobacion</td><td colspan='2' style=''> Compra</td></tr></table>";
        header += "<table><tr><td colspan='4' >  </td><td colspan='2' > Otro</td><td colspan='2' style=''> </td></tr></table>";

        header += "<table><tr><td colspan='8' > Distribuir a: </td></tr></table>";
        header += "<table><tr><td colspan='8' align='center' style='border-bottom:1pt solid black;'> TALLER </td></tr></table>";
        header += "<table><tr><td colspan='8' align='center' style='border-bottom:1pt solid black;'>  </td></tr></table>";
        header += "<table><tr><td colspan='2' >Recibido por:  </td><td colspan='3' style='border-bottom:1pt solid black;'></td><td>Firma</td><td colspan='2' style='border-bottom:1pt solid black;'></td></tr></table>";
        header += "<table><tr><td colspan='8' align='center' style='border-bottom:1pt solid black;'>  </td></tr></table>";
        header += "<table><tr><td colspan='8' > Notas/Comentarios  </td></tr></table>";
        header += "<table><tr><td colspan='8' align='center' style='border-bottom:1pt solid black;'>  </td></tr></table>";
        header += "<table><tr><td colspan='8' align='center' style='border-bottom:1pt solid black;'>  </td></tr></table>";
        header += "<table><tr><td colspan='8' align='center' style='border-bottom:1pt solid black;'>  </td></tr></table>";

        var tmpElemento = document.createElement('a'),
            data_type = 'data:application/vnd.ms-excel',
            tabla_div = header;

        tabla_html = tabla_div.replace(/ /g, '%20');
        
        tmpElemento.href = data_type + ', ' + tabla_html;
        //Asignamos el nombre a nuestro EXCEL
        tmpElemento.download = 'Trasmital.xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelLGPResumen: function (arrData){
        var tblDataRow = '',
            tabla = '',
            total = 0,
            tcompleta = '',
            header = "<table border='2'>",
            tabla_html = '',
            etapa = $('#nombreEtapa').text().replace(/ /g, '&nbsp;');

        if (arrData.Excel !== null) {
            for (var contador = 0; contador < arrData.Excel.length; contador++) {
                var item = arrData.Excel[contador];

                tblDataRow += "<tr>";
                tblDataRow += "<td>" + etapa + "</td>";
                tblDataRow += "<td>" + item.planoMontaje.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.planoDespiece.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.tipoConstruccion.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.marca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.piezaMarca + "</td>";
                tblDataRow += "<td>" + item.peso + "</td>";
                tblDataRow += "<td>" + (parseFloat(item.peso) * parseFloat(item.piezaMarca)) + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='3' align='center'><strong> Listado General de Partes Resumen</strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='3' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + arrData.fecha + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

        tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Etapa</strong></td><td rowspan='2'>" +
                "<strong>Montaje</strong></td><td rowspan='2'><strong>Despiece</strong></td><td rowspan='2' colspan='1'>" +
                "<strong>Tipo Construccion</strong></td><td rowspan='2' colspan='1'><strong>Marcan</strong></td>" + 
                "<td rowspan='2' colspan='1'><strong># Piezas</strong></td>" +                
                "<td rowspan='2'><strong>Peso C/U</strong></td><td rowspan='2'><strong>Peso Total</strong></td></tr></table>";

        tcompleta = "<table border='2'><tr><td><table border='1'>";
        tcompleta += tblDataRow;
        tcompleta += "</table></td></tr></table>";
        header += tabla + tcompleta;

        var tmpElemento = document.createElement('a'),
            data_type = 'data:application/vnd.ms-excel',
            tabla_div = header;

        tabla_html = tabla_div.replace(/ /g, '%20');

        tmpElemento.href = data_type + ', ' + tabla_html;
        //Asignamos el nombre a nuestro EXCEL
        tmpElemento.download = 'LGP Resumen.xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelLGPDetalle : function (arrData){
        var tblDataRow = '',
            tabla = '',
            tcompleta = '',
            header = "<table border='2'>",
            tabla_html = '',
            etapa = $('#nombreEtapa').text().replace(/ /g, '&nbsp;');

        if (arrData.Excel !== null) {
            for (var contador = 0; contador < arrData.Excel.length; contador++) {
                var item = arrData.Excel[contador];

                tblDataRow += "<tr>";
                tblDataRow += "<td>" + etapa + "</td>";
                tblDataRow += "<td>" + item.planoMontaje.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.planoDespiece.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.tipoConstruccion.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.marca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.piezaMarca + "</td>";
                tblDataRow += "<td>" + item.submarca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.perfil.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.piezas + "</td>";
                tblDataRow += "<td>" + item.corte + "</td>";
                tblDataRow += "<td>" + item.longitud + "</td>";
                tblDataRow += "<td>" + item.ancho + "</td>";
                tblDataRow += "<td>" + item.grado.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.kgm + "</td>";
                tblDataRow += "<td>" + item.totalLA + "</td>";
                tblDataRow += "<td>" + item.total + "</td>";
                tblDataRow += "<td>" + item.peso + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='11' align='center'><strong> Listado General de Partes Detalle </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='11' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + arrData.fecha + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

        tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Etapa</strong></td><td rowspan='2'>" +
                "<strong>Montaje</strong></td><td rowspan='2'><strong>Despiece</strong></td><td rowspan='2' colspan='1'>" +
                "<strong>Tipo Construccion</strong></td><td rowspan='2' colspan='1'><strong>Marcan</strong></td><td rowspan='2' colspan='1'><strong>Piezas</strong></td><td rowspan='2'><strong>" +
                "SubMarcas</strong></td><td rowspan='2'><strong>Perfil</strong></td><td rowspan='2'><strong>Piezas</strong></td>" +
                "<td rowspan='2'><strong>Corte</strong></td><td rowspan='2'><strong>Longitud</strong></td><td rowspan='2'><strong>" +
                "Ancho</strong></td><td rowspan='2'><strong>Grado</strong></td><td rowspan='2'><strong>Kgm</strong></td><td rowspan='2'>" +
                "<strong>Total LA</strong></td><td rowspan='2'><strong>Total</strong></td><td rowspan='2'><strong>Peso</strong></td></tr></table>";

        tcompleta = "<table border='2'><tr><td><table border='1'>";
        tcompleta += tblDataRow;
        tcompleta += "</table></td></tr></table>";
        header += tabla + tcompleta;

        var tmpElemento = document.createElement('a'),
            data_type = 'data:application/vnd.ms-excel',
            tabla_div = header;

        tabla_html = tabla_div.replace(/ /g, '%20');

        tmpElemento.href = data_type + ', ' + tabla_html;
        //Asignamos el nombre a nuestro EXCEL
        tmpElemento.download = 'LGP Detalle.xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelOrdenProduccion: function (arrData,tipo) {
        var tblDataRow = '',
             tabla = '',
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '',
             title = tipo === 'P' ? 'Pantografo' : 'Corte',
             etapa = $('#nombreEtapa').text().replace(/ /g, '&nbsp;');

        if (arrData.Excel !== null) {
            for (var contador = 0; contador < arrData.Excel.length; contador++) {
                var item = arrData.Excel[contador];

                tblDataRow += "<tr>";
                tblDataRow += "<td>" + etapa + "</td>";
                tblDataRow += "<td>" + item.planoMontaje.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.planoDespiece.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.marca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.piezaMarca + "</td>";
                tblDataRow += "<td>" + item.submarca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.perfil.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.piezas + "</td>";
                tblDataRow += "<td>" + item.corte + "</td>";
                tblDataRow += "<td>" + item.longitud + "</td>";
                tblDataRow += "<td>" + item.ancho + "</td>";               
                tblDataRow += "<td>" + item.grado.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.kgm + "</td>";
                tblDataRow += "<td>" + item.totalLA + "</td>";
                tblDataRow += "<td>" + item.total + "</td>";
                tblDataRow += "<td>" + item.peso + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='11' align='center'><strong>Orden de Produccion de " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='11' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + arrData.fecha + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

        tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Etapa</strong></td><td rowspan='2'>" + 
                "<strong>Montaje</strong></td><td rowspan='2'><strong>Despiece</strong></td><td rowspan='2' colspan='1'>" + 
                "<strong>Marca</strong></td><td rowspan='2' colspan='1'><strong>Piezas</strong></td><td rowspan='2'><strong>" + 
                "SubMarcas</strong></td><td rowspan='2'><strong>Perfil</strong></td><td rowspan='2'><strong>Piezas</strong></td>" +
                "<td rowspan='2'><strong>Corte</strong></td><td rowspan='2'><strong>Longitud</strong></td><td rowspan='2'><strong>" +
                "Ancho</strong></td><td rowspan='2'><strong>Grado</strong></td><td rowspan='2'><strong>Kgm</strong></td><td rowspan='2'>" + 
                "<strong>Total LA</strong></td><td rowspan='2'><strong>Total</strong></td><td rowspan='2'><strong>Peso</strong></td></tr></table>";

        tcompleta = "<table border='2'><tr><td><table border='1'>";
        tcompleta += tblDataRow;
        tcompleta += "</table></td></tr></table>";
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

