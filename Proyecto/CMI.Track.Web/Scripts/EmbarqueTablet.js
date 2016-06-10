/*global $, CMI, Backbone, bbGrid,EtapaBuscar, contextPath, routeUrlImages,ProyectoBuscar,OrdenEmbarqueBuscar*/
//js de Generacion de Embarque Tablet
//David Galvan
//20/Abril/2016
var EmbarqueTablet = {
    activeForm: '',
    origen : '',
    estatusRevision: 0,
    saldo : 0,
    gridEmbarque: {},
    colEmbarques: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.origen = $('#origentablet').val();
        this.Eventos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarOrdenEmbarque").click(that.onBuscarOrdenEmbarque);
        $('#btnBuscarCodigoBarra').click(that.onBuscarCodBarras);
        $('#codigoBarras').keypress(function (e) {
            if (e.keyCode === 13) {  // detect the enter key
                that.onBuscarCodBarras();
            }
        });

        $('#etapaRow').hide();
    },
    onImprimir: function () {
        var tblDataRow = '',
            tabla = '',
            tcompleta = '',
            header = "<table border='2'>",
            tabla_html = '';
        
        if (EmbarqueTablet.colEmbarques !== null) {
            for (var contador = 0; contador < EmbarqueTablet.colEmbarques.length; contador++) {
                var item = EmbarqueTablet.colEmbarques.at(contador).attributes;

                tblDataRow += "<tr>";
                tblDataRow += "<td>" + item.idOrdenEmbarque + "</td>";
                tblDataRow += "<td>" + item.nombreProyecto.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.claveEtapa.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.nombreMarca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.piezas + "</td>";
                tblDataRow += "<td>" + item.piezasLeidas + "</td>";
                tblDataRow += "<td>" + item.Saldo + "</td>";
                tblDataRow += "<td>" + item.peso + "</td>";
                tblDataRow += "<td>" + item.pesoTotal + "</td>";
                tblDataRow += "<td>" + item.nombrePlano + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='5' align='center'><strong> Embarque Tablet </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='5' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + $('#fecha').val() + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr>";

        tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Orden Embarque</strong></td><td rowspan='2'>" +
                "<strong>Proyecto</strong></td><td rowspan='2'><strong>Etapa</strong></td><td rowspan='2' colspan='1'>" +
                "<strong>Nombre Pieza</strong></td><td rowspan='2' colspan='1'><strong>Pieza</strong></td>" +
                "<td rowspan='2' colspan='1'><strong>Piezas Confir</strong></td>" +
                "<td rowspan='2'><strong>Saldo</strong></td>" +
                "<td rowspan='2'><strong>Peso C/U</strong></td>" +
                "<td rowspan='2'><strong>Peso Total</strong></td>" +
                "<td rowspan='2'><strong>Nombre Plano</strong></td></tr></table>";

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
        tmpElemento.download = 'GenerarEmbarque.xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
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
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Etapas");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarOrdenEmbarque: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/BuscarOrdenEmbarque?sinRemision=false"; // El url del controlador
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
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Orden Embarque");
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
        $('#codBarras').hide();
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
        $('#codBarras').hide();
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
        $('#codBarras').show();
        //Se carga el grid de EmbarqueTablet asignadas a la Orden
        $('#bbGrid-Embarques')[0].innerHTML = "";
        EmbarqueTablet.CargaGrid();
    },
    onBuscarCodBarras : function (){
        var codigo = $('#codigoBarras').val(),
            marca = '',
            serie = '',
            url = contextPath + "GenerarEmbarque/GenerarEmbarque",
            data = '',
            marcas = [],
            tipoMarca = '',
            arrCodigo = [];

        if (codigo.length >= 6) {
            arrCodigo = codigo.split('-');
            if (arrCodigo.length === 3) {
                tipoMarca = arrCodigo[0];
                marca = parseInt(arrCodigo[1],10);
                serie = arrCodigo[2];
                //Solo se leen Marcas
                if (tipoMarca === 'M') {

                    marcas = EmbarqueTablet.colEmbarques.where({ idMarca: marca });

                    if (marcas.length > 0) {

                        if (marcas[0].attributes.Saldo === 0) {
                            CMI.DespliegaError("La marca del codigo (" + codigo + ") ya fue completada. El saldo es cero.");
                            return;
                        }

                        data = 'idOrdenEmbarque=' + marcas[0].attributes.idOrdenEmbarque +
                               '&idMarca=' + marca +
                               '&serie=' + serie +
                               '&origen=' + EmbarqueTablet.origen +
                               '&idUsuario=' + localStorage.idUser;

                        $.post(url, data, function (result) {
                            if (result.Success === true) {
                                $('#codigoBarras').val('');
                                marcas[0].set('piezasLeidas', marcas[0].attributes.piezasLeidas + 1);
                                marcas[0].set('Saldo', marcas[0].attributes.Saldo - 1);
                                EmbarqueTablet.gridEmbarque.renderPage();
                                if (EmbarqueTablet.gridEmbarque.colModel[6].total === 0) { //Encabezado de Saldo en total
                                    CMI.DespliegaInformacion("La Orden de Embarque ya fue registrada en su totalidad.");
                                    $('#codBarras').hide();
                                } else {
                                    CMI.DespliegaInformacion("Se registro el codigo ( " + codigo + ")");
                                }
                            } else {
                                CMI.DespliegaError(result.Message);
                            }
                        });

                    } else {
                        CMI.DespliegaError("La marca del codigo (" + codigo + ") no existe en la Orden de Embarque.");
                    }
                } else {
                    CMI.DespliegaError("El codigo (" + codigo + ") no es valido. Sole se permiten leer Marcas.");
                }

            } else {
                CMI.DespliegaError("El codigo (" + codigo + ") no es valido.");
            }
        } else {
            CMI.DespliegaError("El codigo (" + codigo + ") no es valido.");
        }
    },
    CargaGrid: function () {
        var url = contextPath + "GenerarEmbarque/CargaDetalleOrden?id=" + $('#idOrdenEmbarSelect').val() + "&tipo=" + EmbarqueTablet.origen; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            EmbarqueTablet.colEmbarques = new Backbone.Collection(data);
            var bolFilter = EmbarqueTablet.colEmbarques.length > 0 ? true : false;
            if (bolFilter) {
               EmbarqueTablet.gridEmbarque = new bbGrid.View({
                    container: $('#bbGrid-Embarques'),
                    enableTotal : true,
                    enableSearch: false,
                    detalle: false,
                    collection: EmbarqueTablet.colEmbarques,
                    seguridad: false,
                    colModel: [{ title: 'Orden Embarque', name: 'idOrdenEmbarque', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proyecto', name: 'nombreProyecto', filter: true, filterType: 'input' },
                               { title: 'Etapa', name: 'claveEtapa', filter: true, filterType: 'input' },
                               { title: 'Nombre Pieza', name: 'nombreMarca', filter: true, filterType: 'input' },
                               { title: 'Pieza', name: 'piezas', filter: true, filterType: 'input', total:0 },
                               { title: 'Piezas Confir', name: 'piezasLeidas', filter: true, filterType: 'input', total: 0 },
                               { title: 'Saldo', name: 'Saldo', filter: true, filterType: 'input', total: 0 },
                               { title: 'Peso C/U', name: 'peso', filter: true, filterType: 'input' },
                               { title: 'Peso Total', name: 'pesoTotal', filter: true, filterType: 'input', total: 0 },
                               { title: 'Nombre Plano', name: 'nombrePlano', filter: true, filterType: 'input' }]
               });
               $('#cargandoInfo').hide();
               $('#divImprimir').show();
               if (EmbarqueTablet.gridEmbarque.colModel[6].total === 0) {
                    CMI.DespliegaInformacion("La Orden de Embarque ya fue registrada en su totalidad.");
                    $('#codBarras').hide();
                    $('#divImprimir').hide();
                }
            }
            else {
                CMI.DespliegaInformacion("No se encontraron el detalle de la orden de Embarque seleccionada");
                $('#bbGrid-Embarques')[0].innerHTML = "";
                $('#divImprimir').hide();
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de la Orden de Embarque");
        });
    }
};

$(function () {
    EmbarqueTablet.Inicial();
});