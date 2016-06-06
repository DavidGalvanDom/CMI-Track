/*global $, CMI, ProyectoBuscar,EtapaBuscar,bbGrid,Backbone,contextPath*/
//js de Avances
//Juan Lopepe
//25/Marzo/2016
var Avance = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridAvance: {},
    colAvance: {},
    colUsuarios: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarCodigoBarra").click(that.onBuscarCodigoBarra);
//        $("#btnResumenOFF").click(that.onResumen);
//        $("#btnResumenON").click(that.onResumen);
        $(document).on('click', '#btnDarAvance', that.onDarAvance);
        $(document).on('click', '#btnDarRegistroCalidad', that.onDarRegistroCalidad);
        $(document).on('click', '.btnInfo-DarAvance', that.onClickDarAvance);
        $(document).on('click', '.btnInfo-DarRevision', that.onClickDarRevision);
        $('#codigoBarras').keypress(function (e) {
            if (e.which === 13) {
                that.onEnterCodigoBarras();
            }
        });
    },
    onEnterCodigoBarras: function () {
        $('#codigoBarras').val($('#codigoBarras').val().toUpperCase());
        
        if ($('#codigoBarras').val().length > 0) {
            CMI.CierraMensajes();

            var idTipoProceso = $('#idTipoProceso').val();
            if (idTipoProceso === '1') {//PRODUCTIVO
                var url = contextPath + "Avance/CargarAvance?idEtapa=" + $('#idEtapaSelect').val() + "&idProceso=" + $('#selectProcesoActual').val() + "&codigoBarras=" + $('#codigoBarras').val(); // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    if (data.length != 1) { CMI.DespliegaError("No se encontro el elemento " + $('#codigoBarras').val() + " en el proceso " + $('#selectProcesoActual').text()); return; }
                    
                    //Click Dar Avance
                    if ($('#selectUsuarioFabrico').val() === '') {
                        $('.select2-container').addClass('has-error');
                        $("form").valid();
                        return;
                    } else {
                        $('.select2-container').removeClass('has-error');
                    }

                    var id = $('#codigoBarras').val();
                    var clase = id.split("-")[0];
                    var idMarca_Submarca = id.split("-")[1];
                    var idSerie = id.split("-")[2];
                    var elemento = clase === 'S' ? "SubMarca " + idMarca_Submarca : "Marca " + idMarca_Submarca + " y Serie " + idSerie;
                    var mensaje = "¿Desea dar el avance a la " + elemento + "?";

                    CMI.CierraMensajes();

                    var url = contextPath + "Avance/MostrarDarAvance"; // El url del controlador      
                    $.get(url, function (data) {
                        $('#buscar-General').html(data);
                        $('#buscar-General').modal({
                            backdrop: 'static',
                            keyboard: true
                        }, 'show');

                        if ($('#selectProcesoActual').text() === 'PANTOGRAFO') {
                            $('#rowPiezas').show();
                            var darClick = false;
                        } else {
                            $('#piezas').val(1);
                            $('#rowPiezas').hide();
                            var darClick = true;
                        }

                        $('#tipo').val('P');
                        $('#clase').val(clase);
                        $('#idSubmarca').val((clase === 'S' ? idMarca_Submarca : 0));
                        $('#idMarca').val((clase === 'M' ? idMarca_Submarca : 0));
                        $('#idSerie').val((clase === 'M' ? idSerie : '00'));
                        $('#idUsuarioFabrico').val($('#selectUsuarioFabrico').val());
                        $('#observaciones').val('');
                        $('#longitud').val(false);
                        $('#barrenacion').val(false);
                        $('#placa').val(false);
                        $('#soldadura').val(false);
                        $('#pintura').val(false);
                        $('#usuarioCreacion').val(localStorage.idUser);

                        $('#msgConfirmacion').text(mensaje);

                        if (darClick) {
                            btn = document.getElementById('btnDarAvance');
                            CMI.botonMensaje(true, btn, 'Dar Avance');
                            Avance.onDarAvance();
                        }

                    }).fail(function () {
                        CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Dar Avance");
                    }).always(function () { });
                    //End Click Dar Avance
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Avance");
                });
            } else {//CALIDAD
                var url = contextPath + "Avance/CargarRevision?idEtapa=" + $('#idEtapaSelect').val() + "&idProceso=" + $('#selectProcesoActual').val() + "&codigoBarras=" + $('#codigoBarras').val(); // El url del controlador
                $.getJSON(url, function (data) {
                    if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
                    if (data.length != 1) { CMI.DespliegaError("No se encontro el elemento " + $('#codigoBarras').val() + " en el proceso " + $('#selectProcesoActual').text()); return; }

                    //Click Dar Revision
                    if ($('#selectUsuarioFabrico').val() === '') {
                        $('.select2-container').addClass('has-error');
                        $("form").valid();
                        return;
                    } else {
                        $('.select2-container').removeClass('has-error');
                    }

                    var id = $('#codigoBarras').val();
                    var clase = id.split("-")[0];
                    var idMarca_Submarca = id.split("-")[1];
                    var idSerie = id.split("-")[2];

                    CMI.CierraMensajes();

                    var url = contextPath + "Avance/MostrarDarRegistroCalidad"; // El url del controlador      
                    $.get(url, function (data) {
                        $('#buscar-General').html(data);
                        $('#buscar-General').modal({
                            backdrop: 'static',
                            keyboard: true
                        }, 'show');

                        $('#tipo').val('C');
                        $('#clase').val(clase);
                        $('#idSubmarca').val((clase === 'S' ? idMarca_Submarca : 0));
                        $('#idMarca').val((clase === 'M' ? idMarca_Submarca : 0));
                        $('#idSerie').val((clase === 'M' ? idSerie : '00'));
                        $('#piezas').val(1);
                        $('#idUsuarioFabrico').val(localStorage.idUser);
                        $('#observaciones').val('');
                        $('#usuarioCreacion').val(localStorage.idUser);

                    }).fail(function () {
                        CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Registro de Calidad");
                    }).always(function () { });

                //getJSON fail
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion de la Revision");
                });
            }
        }
    },
    onBuscarCodigoBarra: function () {
        $('#codigoBarras').val($('#codigoBarras').val().toUpperCase());
        $('#bbGrid-Avance')[0].innerHTML = "";
        CMI.CierraMensajes();
        
        var idTipoProceso = $('#idTipoProceso').val();
        if (idTipoProceso === '1') {//PRODUCTIVO
            Avance.CargaGridAvance();
        } else {//CALIDAD
            Avance.CargaGridRevision();
        }
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
            EtapaBuscar.parent = Avance;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
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
            ProyectoBuscar.parent = Avance;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onDarAvance: function () {
        var btn = this;

        CMI.botonMensaje(true, btn, 'Dar Avance');

        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Avance/InsertarActividadProduccion",
                $("#NuevoActividadForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        $('#buscar-General').modal('hide');
                        $('#bbGrid-Avance')[0].innerHTML = "";
                        Avance.CargaGridAvance();
                        CMI.DespliegaInformacion('Avance realizado.');
                        $('#codigoBarras').val('');
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al dar Avance.");
                }).always(function () { CMI.botonMensaje(false, btn, 'Dar Avance'); });
        } else {
            CMI.botonMensaje(false, btn, 'Dar Avance');
        }
    },
    onDarRegistroCalidad: function () {
        var btn = this;

        CMI.botonMensaje(true, btn, 'Registrar');

        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Avance/InsertarActividadProduccion",
                $("#NuevoActividadForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        $('#buscar-General').modal('hide');
                        $('#bbGrid-Avance')[0].innerHTML = "";
                        Avance.CargaGridRevision();
                        CMI.DespliegaInformacion('Registro de Calidad realizado.');
                        $('#codigoBarras').val('');
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al dar Registro de Calidad.");
                }).always(function () { CMI.botonMensaje(false, btn, 'Registrar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Registrar');
        }
    },
    onResumen: function () {
        //$("#divProyecto").slideToggle("fast");
        //$("#divResumen").slideToggle("fast");
    },
    onClickDarAvance: function () {
        if($('#selectUsuarioFabrico').val() === ''){
            $('.select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $('.select2-container').removeClass('has-error');
        }

        var btn = this;
        var id = $(btn).attr("data-id");
        var clase = id.split("-")[0];
        var idMarca_Submarca = id.split("-")[1];
        var idSerie = id.split("-")[2];
        var elemento = clase === 'S' ? "SubMarca " + idMarca_Submarca : "Marca " + idMarca_Submarca + " y Serie " + idSerie;
        var mensaje = "¿Desea dar el avance a la " + elemento + "?";

        CMI.CierraMensajes();

        CMI.botonMensaje(true, btn, 'Dar Avance');
        var url = contextPath + "Avance/MostrarDarAvance"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            if ($('#selectProcesoActual').text() === 'PANTOGRAFO') {
                $('#rowPiezas').show();
            } else {
                $('#piezas').val(1);
                $('#rowPiezas').hide();
            }

            $('#tipo').val('P');
            $('#clase').val(clase);
            $('#idSubmarca').val((clase === 'S' ? idMarca_Submarca : 0));
            $('#idMarca').val((clase === 'M' ? idMarca_Submarca : 0));
            $('#idSerie').val((clase === 'M' ? idSerie : '00'));
            $('#idUsuarioFabrico').val($('#selectUsuarioFabrico').val());
            $('#observaciones').val('');
            $('#longitud').val(false);
            $('#barrenacion').val(false);
            $('#placa').val(false);
            $('#soldadura').val(false);
            $('#pintura').val(false);
            $('#usuarioCreacion').val(localStorage.idUser);

            $('#msgConfirmacion').text(mensaje);

        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Dar Avance");
        }).always(function () { CMI.botonMensaje(false, btn, 'Dar Avance'); });
    },
    onClickDarRevision: function () {
        var btn = this;
        var id = $(btn).attr("data-id");
        var clase = id.split("-")[0];
        var idMarca_Submarca = id.split("-")[1];
        var idSerie = id.split("-")[2];
        
        CMI.CierraMensajes();

        CMI.botonMensaje(true, btn, 'Revision');
        var url = contextPath + "Avance/MostrarDarRegistroCalidad"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            $('#tipo').val('C');
            $('#clase').val(clase);
            $('#idSubmarca').val((clase === 'S' ? idMarca_Submarca : 0));
            $('#idMarca').val((clase === 'M' ? idMarca_Submarca : 0));
            $('#idSerie').val((clase === 'M' ? idSerie : '00'));
            $('#piezas').val(1);
            $('#idUsuarioFabrico').val(localStorage.idUser);
            $('#observaciones').val('');
            $('#usuarioCreacion').val(localStorage.idUser);

        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Registro de Calidad");
        }).always(function () { CMI.botonMensaje(false, btn, 'Revision'); });
    },
    AsignaEtapa: function (idEtapa, NombreEtapa, FechaInicio, FechaFin) {

        // Se cargan los valoes
        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);

        //Valores Resumen
        $('#etapaResumen').text(NombreEtapa);
        $('#btnResumenON').show();

        $('#buscar-General').modal('hide');
        $('.btnNuevo').hide();

        $('#procesoRow').show();

        //Avance.onResumen();

        $('#bbGrid-Avance')[0].innerHTML = "";

        var idTipoProceso = $('#idTipoProceso').val();
        if (idTipoProceso === '1') {//PRODUCTIVO
            Avance.CargaGridAvance();
        } else {//CALIDAD
            Avance.CargaGridRevision();
        }
        Avance.CargaDivUsuarioFabrico();

    },
    AsignaProyecto: function (idProyecto, Revision, NombreProyecto, CodigoProyecto, FechaInicio, FechaFin) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);

        ///Se asignan los valores a Resumen
        $('#proyectoResumen').text(NombreProyecto + ".- Rev: " + Revision);
        $('#proyectoResumen').attr("title", idProyecto + ". [" + CodigoProyecto + "] - " + NombreProyecto + " - Rev: " + Revision);

        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        //Se inicializa la informacion seleccionada a vacio
        //$('#bbGrid-OrdenProduccion')[0].innerHTML = "";

        $('#idEtapaSelect').val(0);
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        }

        $('#etapaRow').show();

        // Se cargan los valores a los combos de Procesos
        Avance.CargaCombosProcesos();
    },
    CargaCombosProcesos: function () {
        var usuario = localStorage.idUser,
            proyecto = $('#idProyectoSelect').val(),
            url = contextPath + "Usuario/CargarProcesoAvanceProduccion?idProyecto=" + proyecto + "&idUsuario=" + usuario; // El url del controlador
        $.getJSON(url, function (json) {
            if (json.id !== undefined) {
                $('#selectProcesoActual')
                    .empty()
                    .append($('<option>', {
                        value: json.id,
                        text: json.nombreProceso
                    }));
                $('#idTipoProceso').val(json.idTipoProceso);
                //Carga Combo con el proceso siguiente
                url = contextPath + "RutaFabricacion/CargarSiguienteProcesoRutaFabricacion?idProyecto=" + proyecto + "&idProceso=" + json.id; // El url del controlador
                $.getJSON(url, function (json2) {
                    if (json2.id !== undefined) {
                        $('#selectProcesoSiguiente').append($('<option>', {
                            value: json2.id,
                            text: json2.nombreProceso
                        }));
                    }
                    $("#btnBuscarEtapa").prop("disabled", false);
                }).fail(function () {
                    CMI.DespliegaError("No se pudo cargar la informacion del Proceso Destino.<br />Revise la Ruta de Fabricacion para la Categoria del Proyecto seleccionado.");
                    $("#btnBuscarEtapa").prop("disabled", true);
                });
            }
            else {
                CMI.DespliegaInformacion("No se encontro un Proceso para este Usuario en este Proyecto.");
            }
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion del Proceso Origen.<br />Revise el Proceso Origen del Usuario y la Ruta de Fabricacion para la Categoria del Proyecto seleccionado.");
            $("#btnBuscarEtapa").prop("disabled", true);
        });
    },
    CargaDivUsuarioFabrico: function () {
        var idTipoProceso = $('#idTipoProceso').val();
        $('#selectUsuarioFabrico').empty();
        if (idTipoProceso === '1') {//PRODUCTIVO
            var url = contextPath + "Usuario/CargaUsuarios"; // El url del controlador
            $.getJSON(url, function (json) {
                Avance.colUsuarios = json;
                if (Avance.colUsuarios.length > 0) {
                    $.each(Avance.colUsuarios, function (i, item) {
                        if (item.id !== undefined) {
                            $('#selectUsuarioFabrico')
                            .append($('<option>', {
                                value: item.id,
                                text: item.NombreCompleto
                            }));
                        }
                    });
                    $(".select2").select2({ allowClear: true, placeholder: 'Departamento' });
                }
                else {
                    CMI.DespliegaInformacion("No se encontraron Usuarios.");
                }
            }).fail(function () {
                CMI.DespliegaError("No se pudo cargar la informacion de los Usuarios.");
            });
            $("[data-colsize]").removeClass("col-sm-3");
            $("[data-colsize]").addClass("col-sm-2");
            $('#usuarioFabricoDiv').show();
        } else {//CALIDAD
            $("[data-colsize]").removeClass("col-sm-2");
            $("[data-colsize]").addClass("col-sm-3");
            $('#usuarioFabricoDiv').hide();
        }
    },
    CargaGridAvance: function () {
        var url = contextPath + "Avance/CargarAvance?idEtapa=" + $('#idEtapaSelect').val() + "&idProceso=" + $('#selectProcesoActual').val() + "&codigoBarras="; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Avance.colAvance = new Backbone.Collection(data);
            var bolFilter = Avance.colAvance.length > 0 ? true : false;
            if (bolFilter) {
                $('#bbGrid-Avance')[0].innerHTML = "";
                Avance.gridAvance = new bbGrid.View({
                    container: $('#bbGrid-Avance'),
                    rows: 10,
                    rowList: [5, 10, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: Avance.accClonar,
                    editar: Avance.accEscritura,
                    borrar: Avance.accBorrar,
                    collection: Avance.colAvance,
                    colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                              { title: 'Codigo de Barras', name: 'codigoBarra' },
                              { title: 'Tipo', name: 'tipo' },
                              { title: 'Perfil', name: 'perfil' },
                              { title: 'Clase', name: 'clase' },
                              { title: 'Estatus Calidad', name: 'estatusCalidad' },
                              { title: 'Proceso Actual', name: 'procesoActual' },
                              { title: ' ', name: 'link', width: '90px' }],
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Datos de Elementos para Avance.");
                $('#bbGrid-Avance')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion del Avance");
        });
    },
    CargaGridRevision: function () {
        var url = contextPath + "Avance/CargarRevision?idEtapa=" + $('#idEtapaSelect').val() + "&idProceso=" + $('#selectProcesoActual').val() + "&codigoBarras="; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Avance.colAvance = new Backbone.Collection(data);
            var bolFilter = Avance.colAvance.length > 0 ? true : false;
            if (bolFilter) {
                $('#bbGrid-Avance')[0].innerHTML = "";
                Avance.gridAvance = new bbGrid.View({
                    container: $('#bbGrid-Avance'),
                    rows: 10,
                    rowList: [5, 10, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: Avance.accClonar,
                    editar: Avance.accEscritura,
                    borrar: Avance.accBorrar,
                    collection: Avance.colAvance,
                    colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                              { title: 'Codigo de Barras', name: 'codigoBarra' },
                              { title: 'Tipo', name: 'tipo' },
                              { title: 'Perfil', name: 'perfil' },
                              { title: 'Clase', name: 'clase' },
                              { title: 'Estatus Calidad', name: 'estatusCalidad' },
                              { title: 'Proceso Actual', name: 'procesoActual' },
                              { title: ' ', name: 'link', width: '70px' }],
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Datos de Elementos para Revision.");
                $('#bbGrid-Avance')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de la Revision");
        });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = Avance;
        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = false;
        modulo.accClonar = false;
    }
};

$(function () {
    Avance.Inicial();
});