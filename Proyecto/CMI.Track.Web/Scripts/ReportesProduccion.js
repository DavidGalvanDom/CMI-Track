/*global $, CMI, ProyectoBuscar,routeUrlImages,contextPath,bbGrid,Backbone*/
//js Reportes de Produccion
//Juan Lopepe
//04/Abril/2016
var ReportesProduccion = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridReportesProduccion: {},
    colReportesProduccion: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
        this.IniciaDateControls();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnImprimir").click(that.onImprimir);
        $("#btnVerReporte").click(that.onVerReporte);
        $("#tipoReporte").change(that.onTipoReporteChange);
    },
    onImprimir: function () {//FALTA
        //Asignacion de variables
        var btn = this;
        var tipoReporte = $('#tipoReporte').val();
        var fechaIni = $('#txtFechaInicio').val();
        var fechaFin = $('#txtFechaFin').val();
        var idProyecto = $('#idProyectoSelect').val(),
            url = '';

        switch (tipoReporte) {
            case 'Calidad':
                // REPORTE DE CALIDAD
                CMI.botonMensaje(true, btn, "Imprimir");
                url = contextPath + "ReportesProduccion/CargarReporteProduccionCalidad?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success === false) {
                        CMI.DespliegaError(data.Message); return;
                    } else {
                        ReportesProduccion.GeneraExcelReporteCalidad(data);
                    }
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Imprimir");
                });
                break;
            case 'ProduccionPersona':
                // PRODUCCION POR PERSONA
                CMI.botonMensaje(true, btn, "Imprimir");
                url = contextPath + "ReportesProduccion/CargarReporteProduccionPorPersona?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success === false) {
                        CMI.DespliegaError(data.Message); return;
                    } else {
                        ReportesProduccion.GeneraExcelReportePorPersona(data);
                    }
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Imprimir");
                });
                break;
            case 'ProduccionSemanal':
                // PRODUCCION SEMANAL
                CMI.botonMensaje(true, btn, "Imprimir");
                url = contextPath + "ReportesProduccion/CargarReporteProduccionSemanal?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success === false) {
                        CMI.DespliegaError(data.Message); return;
                    } else {
                        ReportesProduccion.GeneraExcelReporteSemanal(data);
                    }
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Imprimir");
                });
                break;
            case 'DiasProceso':
                // DIAS PROCESO
                CMI.botonMensaje(true, btn, "Imprimir");
                url = contextPath + "ReportesProduccion/CargarReporteProduccionDiasProceso?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success === false) {
                        CMI.DespliegaError(data.Message); return;
                    } else {
                        ReportesProduccion.GeneraExcelReporteDiasProceso(data);
                    }
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Imprimir");
                });
                break;
            case 'EstatusProyecto':
                // ESTATUS PROYECTO
                CMI.botonMensaje(true, btn, "Imprimir");
                url = contextPath + "ReportesProduccion/CargarReporteProduccionEstatusProyecto?idProyecto=" + idProyecto; // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success === false) {
                        CMI.DespliegaError(data.Message); return;
                    } else {
                        ReportesProduccion.GeneraExcelReporteEstatusProyecto(data);
                    }
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Imprimir");
                });
                break;
            case 'AvanceProyecto':
                // AVANCE PROYECTO
                CMI.botonMensaje(true, btn, "Imprimir");
                url = contextPath + "ReportesProduccion/CargarReporteProduccionAvanceProyecto?idProyecto=" + idProyecto; // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success === false) {
                        CMI.DespliegaError(data.Message); return;
                    } else {
                        ReportesProduccion.GeneraExcelReporteAvanceProyecto(data);
                    }
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Imprimir");
                });
                break;
        }
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
            ProyectoBuscar.parent = ReportesProduccion;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onVerReporte: function () {
        var btn = this;
        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
        $('#Imprimir').hide();
        ReportesProduccion.CargaGrid(btn);
    },
    onTipoReporteChange: function () {
        var tipoReporte = $('#tipoReporte').val();
        switch (tipoReporte) {
            case 'Calidad':
                $("#dtpFechaInicio").show();
                $("#dtpFechaFin").show();
                break;
            case 'ProduccionPersona':
                $("#dtpFechaInicio").show();
                $("#dtpFechaFin").show();
                break;
            case 'ProduccionSemanal':
                $("#dtpFechaInicio").show();
                $("#dtpFechaFin").show();
                break;
            case 'DiasProceso':
                $("#dtpFechaInicio").show();
                $("#dtpFechaFin").show();
                break;
            case 'EstatusProyecto':
                $("#dtpFechaInicio").hide();
                $("#dtpFechaFin").hide();
                break;
            case 'AvanceProyecto':
                $("#dtpFechaInicio").hide();
                $("#dtpFechaFin").hide();
                break;
        }
        var nombreReporte = $('#tipoReporte option:selected').text();
        var tipoReporte = $('#tipoReporte').val();
        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
        $('#Imprimir').hide();
    },
    AsignaProyecto: function (idProyecto, Revision, NombreProyecto, CodigoProyecto, FechaInicio, FechaFin) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        }
        $('#Imprimir').hide();

        $('#tipoReporteRow').show();
    },
    IniciaDateControls: function () {
        var form = ReportesProduccion.activeForm;
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
    ValidaPermisos: function () {
        var modulo = ReportesProduccion;

        modulo.accEscritura = false;
        modulo.accBorrar = false;
        modulo.accClonar = false;
    },
    CargaGrid: function (btn) {
        //Asignacion de variables
        var tipoReporte = $('#tipoReporte').val();
        var nombreReporte = $('#tipoReporte option:selected').text();
        var fechaIni = $('#txtFechaInicio').val();
        var fechaFin = $('#txtFechaFin').val();
        var idProyecto = $('#idProyectoSelect').val(),
            url = '';
        CMI.botonMensaje(true, btn, "Ver Reporte");

        switch (tipoReporte) {
            case 'Calidad':
                // REPORTE DE CALIDAD
                url = contextPath + "ReportesProduccion/CargarReporteProduccionCalidad?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    $('#cargandoInfo').show();
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    ReportesProduccion.colReportesProduccion = new Backbone.Collection(data);
                    var bolFilter = ReportesProduccion.colReportesProduccion.length > 0 ? true : false;
                    if (bolFilter) {
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                         ReportesProduccion.gridReportesProduccion = new bbGrid.View({
                            container: $('#bbGrid-ReporteProduccion'),
                            rows: 10,
                            rowList: [5, 10, 25, 50, 100],
                            enableSearch: false,
                            actionenable: false,
                            detalle: false,
                            clone: ReportesProduccion.accClonar,
                            editar: ReportesProduccion.accEscritura,
                            borrar: ReportesProduccion.accBorrar,
                            collection: ReportesProduccion.colReportesProduccion,
                            seguridad: ReportesProduccion.accSeguridad,
                            colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                                      { title: 'Fecha', name: 'fecha' },
                                      { title: 'Proyecto', name: 'proyecto' },
                                      { title: 'Etapa', name: 'etapa' },
                                      { title: 'Marca', name: 'marca' },
                                      { title: 'Serie', name: 'serie' },
                                      { title: 'Piezas', name: 'piezas' },
                                      { title: 'Peso', name: 'peso' },
                                      { title: 'Usuario', name: 'usuario' },
                                      { title: 'L', name: 'longitud' },
                                      { title: 'B', name: 'barrenacion' },
                                      { title: 'P', name: 'placa' },
                                      { title: 'S', name: 'soldadura' },
                                      { title: 'PI', name: 'pintura' },
                                      { title: 'Estatus', name: 'estatus' },
                                      { title: 'Observaciones', name: 'observaciones' }]
                        });
                        $('#cargandoInfo').hide();
                        $('#Imprimir').show();
                        //Asigno el titulo del reporte
                        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
                    }
                    else {
                        CMI.DespliegaInformacion("No se encontraron Datos.");
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                        $('#Imprimir').hide();
                    }
                    //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Ver Reporte");
                });
                break;
            case 'ProduccionPersona':
                // PRODUCCION POR PERSONA
                url = contextPath + "ReportesProduccion/CargarReporteProduccionPorPersona?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    $('#cargandoInfo').show();
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    ReportesProduccion.colReportesProduccion = new Backbone.Collection(data);
                    var bolFilter = ReportesProduccion.colReportesProduccion.length > 0 ? true : false;
                    if (bolFilter) {
                        ReportesProduccion.gridReportesProduccion = new bbGrid.View({
                            container: $('#bbGrid-ReporteProduccion'),
                            rows: 10,
                            rowList: [5, 10, 25, 50, 100],
                            enableSearch: false,
                            actionenable: false,
                            detalle: false,
                            clone: ReportesProduccion.accClonar,
                            editar: ReportesProduccion.accEscritura,
                            borrar: ReportesProduccion.accBorrar,
                            collection: ReportesProduccion.colReportesProduccion,
                            seguridad: ReportesProduccion.accSeguridad,
                            colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                                      { title: 'Fecha', name: 'fecha' },
                                      { title: 'Usuario', name: 'usuario' },
                                      { title: 'Proyecto', name: 'proyecto' },
                                      { title: 'Etapa', name: 'etapa' },
                                      { title: 'Clase', name: 'clase', width: '8%' },
                                      { title: 'Codigo', name: 'elemento', width: '8%' },
                                      { title: 'Serie', name: 'idSerie', width: '4%' },
                                      { title: 'Proceso', name: 'proceso', width: '4%' },
                                      { title: 'Piezas', name: 'piezas', width: '4%'},
                                      { title: 'Peso', name: 'peso', width: '4%' }]
                        });
                        $('#cargandoInfo').hide();
                        $('#Imprimir').show();
                        //Asigno el titulo del reporte
                        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
                    }
                    else {
                        CMI.DespliegaInformacion("No se encontraron Datos.");
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                        $('#Imprimir').hide();
                    }
                    //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Ver Reporte");
                });
                break;
            case 'ProduccionSemanal':
                // PRODUCCION SEMANAL
                url = contextPath + "ReportesProduccion/CargarReporteProduccionSemanal?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    $('#cargandoInfo').show();
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    ReportesProduccion.colReportesProduccion = new Backbone.Collection(data);
                    var bolFilter = ReportesProduccion.colReportesProduccion.length > 0 ? true : false;
                    if (bolFilter) {
                        ReportesProduccion.gridReportesProduccion = new bbGrid.View({
                            container: $('#bbGrid-ReporteProduccion'),
                            rows: 10,
                            rowList: [5, 10, 25, 50, 100],
                            enableSearch: false,
                            actionenable: false,
                            detalle: false,
                            clone: ReportesProduccion.accClonar,
                            editar: ReportesProduccion.accEscritura,
                            borrar: ReportesProduccion.accBorrar,
                            collection: ReportesProduccion.colReportesProduccion,
                            seguridad: ReportesProduccion.accSeguridad,
                            colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                                      { title: 'Fecha', name: 'fecha' },
                                      { title: 'Proyecto', name: 'proyecto' },
                                      { title: 'Etapa', name: 'etapa' },
                                      { title: 'Clase', name: 'clase', width: '8%' },
                                      { title: 'Codigo', name: 'elemento', width: '8%' },
                                      { title: 'Serie', name: 'idSerie', width: '4%' },
                                      { title: 'Proceso', name: 'proceso', width: '4%' },
                                      { title: 'Piezas', name: 'piezas', width: '4%' },
                                      { title: 'Peso', name: 'peso', width: '4%' }]
                        });
                        $('#cargandoInfo').hide();
                        $('#Imprimir').show();
                        //Asigno el titulo del reporte
                        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
                    }
                    else {
                        CMI.DespliegaInformacion("No se encontraron Datos.");
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                        $('#Imprimir').hide();
                    }
                    //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Ver Reporte");
                });
                break;
            case 'DiasProceso':
                // DIAS PROCESO
                url = contextPath + "ReportesProduccion/CargarReporteProduccionDiasProceso?idProyecto=" + idProyecto + "&fechaInicio=" + fechaIni + "&fechaFin=" + fechaFin; // El url del controlador
                $.getJSON(url, function (data) {
                    $('#cargandoInfo').show();
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    ReportesProduccion.colReportesProduccion = new Backbone.Collection(data);
                    var bolFilter = ReportesProduccion.colReportesProduccion.length > 0 ? true : false;
                    if (bolFilter) {
                        ReportesProduccion.gridReportesProduccion = new bbGrid.View({
                            container: $('#bbGrid-ReporteProduccion'),
                            rows: 10,
                            rowList: [5, 10, 25, 50, 100],
                            enableSearch: false,
                            actionenable: false,
                            detalle: false,
                            clone: ReportesProduccion.accClonar,
                            editar: ReportesProduccion.accEscritura,
                            borrar: ReportesProduccion.accBorrar,
                            collection: ReportesProduccion.colReportesProduccion,
                            seguridad: ReportesProduccion.accSeguridad,
                            colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                                      { title: 'Proyecto', name: 'proyecto' },
                                      { title: 'Etapa', name: 'etapa' },
                                      { title: 'Clase', name: 'clase' },
                                      { title: 'Codigo', name: 'elemento' },
                                      { title: 'Serie', name: 'idSerie' },
                                      { title: 'Piezas', name: 'piezas' },
                                      { title: 'Dias', name: 'diasProceso' },
                                      { title: 'Fecha Ini', name: 'fechaInicio' },
                                      { title: 'Corte', name: 'corte' },
                                      { title: 'Pantografo', name: 'pantografo' },
                                      { title: 'Ensamble', name: 'ensamble' },
                                      { title: 'C. Ensamble', name: 'calidadEnsamble' },
                                      { title: 'Soldadura', name: 'soldadura' },
                                      { title: 'C. Soldadura', name: 'calidadSoldadura' },
                                      { title: 'Limpieza', name: 'limpieza' },
                                      { title: 'Pintura', name: 'pintura' },
                                      { title: 'C. Final', name: 'calidadFinal' }]
                        });
                        $('#cargandoInfo').hide();
                        $('#Imprimir').show();
                        //Asigno el titulo del reporte
                        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
                    }
                    else {
                        CMI.DespliegaInformacion("No se encontraron Datos.");
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                        $('#Imprimir').hide();
                    }
                    //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Ver Reporte");
                });
                break;
            case 'EstatusProyecto':
                // ESTATUS PROYECTO
                url = contextPath + "ReportesProduccion/CargarReporteProduccionEstatusProyecto?idProyecto=" + idProyecto; // El url del controlador
                $.getJSON(url, function (data) {
                    $('#cargandoInfo').show();
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    ReportesProduccion.colReportesProduccion = new Backbone.Collection(data);
                    var bolFilter = ReportesProduccion.colReportesProduccion.length > 0 ? true : false;
                    if (bolFilter) {
                        ReportesProduccion.gridReportesProduccion = new bbGrid.View({
                            container: $('#bbGrid-ReporteProduccion'),
                            rows: 10,
                            rowList: [5, 10, 25, 50, 100],
                            enableSearch: false,
                            actionenable: false,
                            detalle: false,
                            clone: ReportesProduccion.accClonar,
                            editar: ReportesProduccion.accEscritura,
                            borrar: ReportesProduccion.accBorrar,
                            collection: ReportesProduccion.colReportesProduccion,
                            seguridad: ReportesProduccion.accSeguridad,
                            colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                                      { title: 'Proceso', name: 'proceso' },
                                      { title: 'Categoria', name: 'categoria' },
                                      { title: 'Proyecto', name: 'proyecto' },
                                      { title: 'Etapa', name: 'etapa' },
                                      { title: 'Plano Montaje', name: 'planoMontaje' },
                                      { title: 'Plano Despiece', name: 'planoDespiece' },
                                      { title: 'Marca', name: 'marca' },
                                      { title: 'Serie', name: 'serie' },
                                      { title: 'Dias', name: 'diasProceso' },
                                      { title: 'Piezas', name: 'piezas' },
                                      { title: 'Peso', name: 'peso' }]
                        });
                        $('#cargandoInfo').hide();
                        $('#Imprimir').show();
                        //Asigno el titulo del reporte
                        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
                    }
                    else {
                        CMI.DespliegaInformacion("No se encontraron Datos.");
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                        $('#Imprimir').hide();
                    }
                    //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Ver Reporte");
                });
                break;
            case 'AvanceProyecto':
                // AVANCE PROYECTO
                url = contextPath + "ReportesProduccion/CargarReporteProduccionAvanceProyecto?idProyecto=" + idProyecto; // El url del controlador
                $.getJSON(url, function (data) {
                    $('#cargandoInfo').show();
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    ReportesProduccion.colReportesProduccion = new Backbone.Collection(data);
                    var bolFilter = ReportesProduccion.colReportesProduccion.length > 0 ? true : false;
                    if (bolFilter) {
                        ReportesProduccion.gridReportesProduccion = new bbGrid.View({
                            container: $('#bbGrid-ReporteProduccion'),
                            rows: 10,
                            rowList: [5, 10, 25, 50, 100],
                            enableSearch: false,
                            actionenable: false,
                            detalle: false,
                            clone: ReportesProduccion.accClonar,
                            editar: ReportesProduccion.accEscritura,
                            borrar: ReportesProduccion.accBorrar,
                            collection: ReportesProduccion.colReportesProduccion,
                            seguridad: ReportesProduccion.accSeguridad,
                            colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                                      { title: 'Etapa', name: 'etapa' },
                                      { title: 'Plano Montaje', name: 'planoMontaje' },
                                      { title: 'Avance', name: 'avance' },
                                      { title: 'Fecha Inicial', name: 'fechaIni' },
                                      { title: 'Fecha Final', name: 'fechaFin' }]
                        });
                        $('#cargandoInfo').hide();
                        $('#Imprimir').show();
                        //Asigno el titulo del reporte
                        $('#nombreTipoReporte').html(tipoReporte !== "" ? " - " + nombreReporte : "");
                    }
                    else {
                        CMI.DespliegaInformacion("No se encontraron Datos.");
                        $('#bbGrid-ReporteProduccion')[0].innerHTML = "";
                        $('#Imprimir').hide();
                    }
                    //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Reporte");
                }).always(function () {
                    CMI.botonMensaje(false, btn, "Ver Reporte");
                });
                break;
            default:
                CMI.DespliegaError("Seleccione un reporte");
                CMI.botonMensaje(false, btn, "Ver Reporte");
                break;
        }
    },
    GeneraExcelReporteCalidad: function (arrData) {
        var tblDataRow = '',
             tabla = '',
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '',
             title = 'REPORTE&nbsp;DE&nbsp;CALIDAD',
             proyecto = $('#nombreProyecto').text().replace(/ /g, '&nbsp;'),
             fechaReporte = CMI.MuestraFechaActual();

        var excludeArray = ["id"],
            name;
        
        var imprimeCols = 0;
        for (var contador = 0; contador < arrData.length; contador++) {
            var item = arrData[contador];
            if (imprimeCols === 0) {
                tabla = "<table  border='2' ><tr align='center'>";
                for (name in item) {
                    if (excludeArray.indexOf(name) === -1) {
                        tabla += "<td rowspan='2'><strong>" + name.toUpperCase() + "</strong></td>";
                    }
                }
                tabla += "</tr></table>";
                imprimeCols = 1;
            }
            tblDataRow += "<tr>";
            for (name in item) {
                if (excludeArray.indexOf(name) === -1) {
                    tblDataRow += "<td>" + item[name].replace(/ /g, '&nbsp;') + "</td>";
                }
            }
            tblDataRow += "</tr>";
        }

        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='11' align='center'><strong> " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='11' align='center'><strong> " + proyecto + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + fechaReporte + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

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
        tmpElemento.download = 'Reporte_Produccion_Calidad-('+fechaReporte.replace(/ /g,'-')+').xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelReportePorPersona: function (arrData) {
        var tblDataRow = '',
             tabla = '',
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '',
             title = 'REPORTE&nbsp;DE&nbsp;PRODUCCION&nbsp;POR&nbsp;PERSONA',
             proyecto = $('#nombreProyecto').text().replace(/ /g, '&nbsp;'),
             fechaReporte = CMI.MuestraFechaActual();

        var excludeArray = ["id","idUsuario","idProyecto"],
            name;

        var imprimeCols = 0;
        for (var contador = 0; contador < arrData.length; contador++) {
            var item = arrData[contador];
            if (imprimeCols === 0) {
                tabla = "<table  border='2' ><tr align='center'>";
                for (name in item) {
                    if (excludeArray.indexOf(name) === -1) {
                        if (name === "elemento") name = "codigo";
                        if (name === "idSerie") name = "serie";
                        tabla += "<td rowspan='2'><strong>" + name.toUpperCase() + "</strong></td>";
                    }
                }
                tabla += "</tr></table>";
                imprimeCols = 1;
            }
            tblDataRow += "<tr>";
            for (name in item) {
                if (excludeArray.indexOf(name) === -1) {
                    tblDataRow += "<td>" + item[name] + "</td>";
                }
            }
            tblDataRow += "</tr>";
        }

        header += "<tr>";
        header += "<td colspan='2'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='6' align='center'><strong> " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='6' align='center'><strong> " + proyecto + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + fechaReporte + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

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
        tmpElemento.download = 'Reporte_Produccion_Por_Persona-(' + fechaReporte.replace(/ /g, '-') + ').xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelReporteSemanal: function (arrData) {
        var tblDataRow = '',
             tabla = '',
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '',
             title = 'REPORTE&nbsp;DE&nbsp;PRODUCCION&nbsp;SEMANAL',
             proyecto = $('#nombreProyecto').text().replace(/ /g, '&nbsp;'),
             fechaReporte = CMI.MuestraFechaActual();

        var excludeArray = ["id", "idProyecto"],
            name;

        var imprimeCols = 0;
        for (var contador = 0; contador < arrData.length; contador++) {
            var item = arrData[contador];
            if (imprimeCols === 0) {
                tabla = "<table  border='2' ><tr align='center'>";
                for (name in item) {
                    if (excludeArray.indexOf(name) === -1) {
                        if (name === "elemento") name = "codigo";
                        if (name === "idSerie") name = "serie";
                        tabla += "<td rowspan='2'><strong>" + name.toUpperCase() + "</strong></td>";
                    }
                }
                tabla += "</tr></table>";
                imprimeCols = 1;
            }
            tblDataRow += "<tr>";
            for (name in item) {
                if (excludeArray.indexOf(name) === -1) {
                    tblDataRow += "<td>" + item[name] + "</td>";
                }
            }
            tblDataRow += "</tr>";
        }

        header += "<tr>";
        header += "<td colspan='2'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='5' align='center'><strong> " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='5' align='center'><strong> " + proyecto + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + fechaReporte + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

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
        tmpElemento.download = 'Reporte_Produccion_Semanal-(' + fechaReporte.replace(/ /g, '-') + ').xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelReporteDiasProceso: function (arrData) {
        var tblDataRow = '',
             tabla = '',
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '',
             title = 'REPORTE&nbsp;DE&nbsp;DIAS&nbsp;DE&nbsp;PROCESO',
             proyecto = $('#nombreProyecto').text().replace(/ /g, '&nbsp;'),
             fechaReporte = CMI.MuestraFechaActual();

        var excludeArray = ["id", "idProyecto", "idEtapa", "idElemento"],
            name;

        var imprimeCols = 0;
        for (var contador = 0; contador < arrData.length; contador++) {
            var item = arrData[contador];
            if (imprimeCols === 0) {
                tabla = "<table  border='2' ><tr align='center'>";
                for (name in item) {
                    if (excludeArray.indexOf(name) === -1) {
                        if (name === "elemento") name = "codigo";
                        if (name === "idSerie") name = "serie";
                        tabla += "<td rowspan='2'><strong>" + name.toUpperCase() + "</strong></td>";
                    }
                }
                tabla += "</tr></table>";
                imprimeCols = 1;
            }
            tblDataRow += "<tr>";
            for (name in item) {
                if (excludeArray.indexOf(name) === -1) {
                    tblDataRow += "<td>" + item[name] + "</td>";
                }
            }
            tblDataRow += "</tr>";
        }

        header += "<tr>";
        header += "<td colspan='2'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='14' align='center'><strong> " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='14' align='center'><strong> " + proyecto + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + fechaReporte + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

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
        tmpElemento.download = 'Reporte_Produccion_Dias_Proceso-(' + fechaReporte.replace(/ /g, '-') + ').xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelReporteEstatusProyecto: function (arrData) {
        var tblDataRow = '',
             tabla = '',
             tcompleta = '',
             header = "<table border='2'>",
             tabla_html = '',
             title = 'REPORTE&nbsp;DE&nbsp;ESTATUS&nbsp;DE&nbsp;PROYECTO',
             proyecto = $('#nombreProyecto').text().replace(/ /g, '&nbsp;'),
             fechaReporte = CMI.MuestraFechaActual();

        var excludeArray = ["id"],
            name;

        var imprimeCols = 0;
        for (var contador = 0; contador < arrData.length; contador++) {
            var item = arrData[contador];
            if (imprimeCols === 0) {
                tabla = "<table  border='2' ><tr align='center'>";
                for (name in item) {
                    if (excludeArray.indexOf(name) === -1) {
                        tabla += "<td rowspan='2'><strong>" + name.toUpperCase() + "</strong></td>";
                    }
                }
                tabla += "</tr></table>";
                imprimeCols = 1;
            }
            tblDataRow += "<tr>";
            for (name in item) {
                if (excludeArray.indexOf(name) === -1) {
                    tblDataRow += "<td>" + item[name] + "</td>";
                }
            }
            tblDataRow += "</tr>";
        }

        header += "<tr>";
        header += "<td colspan='2'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='7' align='center'><strong> " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='7' align='center'><strong> " + proyecto + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + fechaReporte + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr> ";

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
        tmpElemento.download = 'Reporte_Produccion_Estatus_Proyecto-(' + fechaReporte.replace(/ /g, '-') + ').xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    },
    GeneraExcelReporteAvanceProyecto: function (arrData) {
    var tblDataRow = '',
         tabla = '',
         tcompleta = '',
         header = "<table border='2'>",
         tabla_html = '',
         title = 'REPORTE&nbsp;DE&nbsp;AVANCE&nbsp;DE&nbsp;PROYECTO',
         proyecto = $('#nombreProyecto').text().replace(/ /g, '&nbsp;'),
         fechaReporte = CMI.MuestraFechaActual();

        var excludeArray = ["id"],
            name;

    var imprimeCols = 0;
    for (var contador = 0; contador < arrData.length; contador++) {
        var item = arrData[contador];
        if (imprimeCols === 0) {
            tabla = "<table  border='2' ><tr align='center'>";
            for (name in item) {
                if (excludeArray.indexOf(name) === -1) {
                    tabla += "<td rowspan='2'><strong>" + name.toUpperCase() + "</strong></td>";
                }
            }
            tabla += "</tr></table>";
            imprimeCols = 1;
        }
        tblDataRow += "<tr>";
        for (name in item) {
            if (excludeArray.indexOf(name) === -1) {
                tblDataRow += "<td>" + item[name] + "</td>";
            }
        }
        tblDataRow += "</tr>";
    }

    header += "<tr>";
    header += "<td colspan='1'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
    header += "<td > <table> ";
    header += "        <tr> <td colspan='2' align='center'><strong> " + title + " </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
    header += "        <tr> <td colspan='2' align='center'><strong> " + proyecto + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
    header += "      </table>";
    header += " </td> ";
    header += "<td> ";
    header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'> <td >Fecha:</td></tr><tr><td></td></tr></table>";
    header += "</td>";
    header += "<td> ";
    header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
    header += "      <tr><td  align='center'><strong>" + fechaReporte + "</strong></td></tr>";
    header += "    </table>";
    header += "</td>";
    header += "</tr> ";

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
    tmpElemento.download = 'Reporte_Produccion_Avance_Proyecto-(' + fechaReporte.replace(/ /g, '-') + ').xls';
        // Simulamos el click al elemento creado para descargarlo
    tmpElemento.click();
}
};

$(function () {
    ReportesProduccion.Inicial();
});