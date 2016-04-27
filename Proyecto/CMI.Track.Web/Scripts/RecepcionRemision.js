/*global $, CMI, Backbone, bbGrid,EtapaBuscar, contextPath, routeUrlImages,RemisionBuscar,ProyectoBuscar*/
//js de Generacion de Reception Remision
//David Galvan
//26/Abril/2016
var RecepcionRemision = {
    activeForm: '',
    origen: '',
    estatusRevision: 0,
    saldo: 0,
    gridRemisiones: {},
    colDetalleRemision: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarRemision").click(that.onBuscarRemision);
        $('#btnBuscarCodigoBarra').click(that.onBuscarCodBarras);
        $('#codigoBarras').keypress(function (e) {
            if (e.keyCode === 13) {  // detect the enter key
                that.onBuscarCodBarras();
            }
        });

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
            ProyectoBuscar.parent = RecepcionRemision;
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
            EtapaBuscar.parent = RecepcionRemision;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Etapas");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarRemision: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Remision/BuscarRemision"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            RemisionBuscar.idProyecto = $('#idProyectoSelect').val();
            RemisionBuscar.idEtapa = $('#idEtapaSelect').val();
            RemisionBuscar.parent = RecepcionRemision;
            RemisionBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Remisiones");
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

        RecepcionRemision.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }

        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-Remision')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('.btnNuevo').hide();

        $('#etapaRow').show();
        $('#codBarras').hide();
        $('#remisionRow').hide();
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
        $('#remisionRow').show();

    },
    AsignaRemision: function (idRemision, nombreCliente,
                              transporte, fechaEnvio) {

        $('#idRemisionSelect').val(idRemision);
        $('#idRemision').text(idRemision);
        $('#nombreCliente').text(nombreCliente);
        $('#FechaEnvio').text(fechaEnvio);

        $('#buscar-General').modal('hide');
        $('#codBarras').show();
        //Se carga el grid con el detalle de las Ordenes de Embarque de la remision
        $('#bbGrid-Remision')[0].innerHTML = "";
        RecepcionRemision.CargaGrid();
    },
    onBuscarCodBarras: function () {
        var codigo = $('#codigoBarras').val(),
            marca = '',
            serie = '',
            url = contextPath + "RecepcionRemision/GenerarRecepcionRemision",
            data = '',
            marcas = [],
            tipoMarca = '',
            arrCodigo = [];

        if (codigo.length >= 6) {
            arrCodigo = codigo.split('-');
            if (arrCodigo.length === 3) {
                tipoMarca = arrCodigo[0];
                marca = parseInt(arrCodigo[1], 10);
                serie = arrCodigo[2];
                //Solo se leen Marcas
                if (tipoMarca === 'M') {
                    
                    marcas = RecepcionRemision.colDetalleRemision.where({ idMarca: marca });

                    if (marcas.length > 0) {

                        if (marcas[0].attributes.Saldo === 0) {
                            CMI.DespliegaError("La marca del codigo (" + codigo + ") ya fue completada. El saldo es cero.");
                            return;
                        }

                        data = 'idOrdenEmb=' + marcas[0].attributes.idOrdenEmbarque +
                               '&idMarca=' + marca +
                               '&serie=' + serie +
                               '&idRemision=' + marcas[0].id +
                               '&idUsuario=' + localStorage.idUser;

                        $.post(url, data, function (result) {
                            if (result.Success === true) {
                                $('#codigoBarras').val('');
                                marcas[0].set('PiezasLeidas', marcas[0].attributes.PiezasLeidas + 1);
                                marcas[0].set('Saldo', marcas[0].attributes.Saldo - 1);
                                RecepcionRemision.gridRemisiones.renderPage();
                                if (RecepcionRemision.gridRemisiones.colModel[7].total === 0) { //Encabezado de Saldo en total
                                    CMI.DespliegaInformacion("La Remision ya fue registrada en su totalidad.");
                                    $('#codBarras').hide();
                                }
                            } else {
                                CMI.DespliegaError(result.Message);
                            }
                        });

                    } else {
                        CMI.DespliegaError("La marca del codigo (" + codigo + ") no existe en la Remision.");
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
    onImprimir: function () {
        var tblDataRow = '',
            tabla = '',
            tcompleta = '',
            header = "<table border='2'>",
            tabla_html = '';

        if (RecepcionRemision.colDetalleRemision !== null) {
            for (var contador = 0; contador < RecepcionRemision.colDetalleRemision.length; contador++) {
                var item = RecepcionRemision.colDetalleRemision.at(contador).attributes;

                tblDataRow += "<tr>";
                tblDataRow += "<td>" + item.id + "</td>";
                tblDataRow += "<td>" + item.idOrdenEmbarque + "</td>";
                tblDataRow += "<td>" + item.Proyecto.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.Etapa.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.Marca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td>" + item.Piezas + "</td>";
                tblDataRow += "<td>" + item.PiezasLeidas + "</td>";
                tblDataRow += "<td>" + item.Saldo + "</td>";
                tblDataRow += "<td>" + item.PesoCU + "</td>";
                tblDataRow += "<td>" + item.PesoTotal + "</td>";
                tblDataRow += "<td>" + item.NombrePlano + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='6' align='center'><strong> Recepcion Remision </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='6' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
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

        tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Remision</strong></td><td rowspan='2'><strong>Orden Embarque</strong></td><td rowspan='2'>" +
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
        tmpElemento.download = 'Recepcion_Remision.xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    CargaGrid: function () {
        var url = contextPath + "RecepcionRemision/CargaDetalleRemision/" + $('#idRemisionSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            RecepcionRemision.colDetalleRemision = new Backbone.Collection(data);
            var bolFilter = RecepcionRemision.colDetalleRemision.length > 0 ? true : false;
            if (bolFilter) {
                RecepcionRemision.gridRemisiones = new bbGrid.View({
                    container: $('#bbGrid-Remision'),
                    enableTotal: true,
                    enableSearch: false,
                    detalle: false,
                    collection: RecepcionRemision.colDetalleRemision,
                    seguridad: false,
                    colModel: [{ title: 'Remision', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Orden Embarque', name: 'idOrdenEmbarque', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proyecto', name: 'Proyecto', filter: true, filterType: 'input' },
                               { title: 'Etapa', name: 'Etapa', filter: true, filterType: 'input' },
                               { title: 'Nombre Pieza', name: 'Marca', filter: true, filterType: 'input' },
                               { title: 'Pieza', name: 'Piezas', filter: true, filterType: 'input', total: 0 },
                               { title: 'Piezas Confir', name: 'PiezasLeidas', filter: true, filterType: 'input', total: 0 },
                               { title: 'Saldo', name: 'Saldo', filter: true, filterType: 'input', total: 0 },
                               { title: 'Peso C/U', name: 'PesoCU', filter: true, filterType: 'input' },
                               { title: 'Peso Total', name: 'PesoTotal', filter: true, filterType: 'input', total: 0 },
                               { title: 'Nombre Plano', name: 'NombrePlano', filter: true, filterType: 'input' }]
                });
                $('#cargandoInfo').hide();
                $('#divImprimir').show();
                if (RecepcionRemision.gridRemisiones.colModel[7].total === 0) {
                    CMI.DespliegaInformacion("La Remision ya fue registrada en su totalidad.");
                    $('#codBarras').hide();
                }
            }
            else {
                CMI.DespliegaInformacion("No se encontraron el detalle de la Remision seleccionada");
                $('#bbGrid-Remision')[0].innerHTML = "";
                $('#divImprimir').hide();
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de la Remision seleccionada");
        });
    }
};

$(function () {
    RecepcionRemision.Inicial();
});