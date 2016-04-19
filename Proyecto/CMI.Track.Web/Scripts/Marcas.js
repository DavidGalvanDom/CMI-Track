//js de catalogo de Marcas.
//David Galvan
//24/Febrero/2016
var Marcas = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    estatusRevision : 0,
    gridMarca: {},
    colMarcas: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $('#btnBuscarPlanosMontaje').click(that.onBuscarPlanosMontaje);
        $('#btnBuscarPlanosDespiece').click(that.onBuscarPlanosDespiece);
        $('.btnNuevo').click(that.Nuevo);

        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarMarca', that.onActualizar);
        
        //Eventos de los botones de Acciones del grid
        $(document).on('click', '.accrowEdit', function () {
            that.Editar($(this).parent().parent().attr("data-modelId"));
        });

        $(document).on('click', '.accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
        });

        $(document).on('click', '.accrowClonar', function () {
            that.Clonar($(this).parent().parent().attr("data-modelId"));
        });
    },
    onGuardar: function () {
        var form = Marcas.activeForm,
            btn = this;
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            debugger
            if (parseInt($(form + ' #piezas').val()) > 1295) {
                CMI.DespliegaErrorDialogo("El valor de piezas no puede ser mayor a 1295.");
                $(form + ' #piezas').focus();
                CMI.botonMensaje(false, btn, 'Guardar');
                $("form").valid();
                return;
            } else {
                $(form + ' #piezas').removeClass('has-error');
            }
            
            $(form + ' #idPlanoDespiece').val($('#idPlanoDespieceSelect').val());
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Marcas/Nuevo",
                $("#NuevaMarcaForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        Marcas.colMarcas.add(Marcas.serializaMarcas(data.id));
                        CMI.DespliegaInformacion('La Marcas fue guardado con el Id: ' + data.id);
                        $('#nuevo-Marcas').modal('hide');
                        if (Marcas.colMarcas.length === 1) {
                            Marcas.CargaGrid();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                        CMI.botonMensaje(false, btn, 'Guardar');
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Guardar');
        }
    },
    onActualizar: function () {
        var form = Marcas.activeForm,
            btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            if (parseInt($(form + ' #piezas').val()) > 1295) {
                CMI.DespliegaErrorDialogo("El valor de piezas no puede ser mayor a 1295.");
                $(form + ' #piezas').focus();
                CMI.botonMensaje(false, btn, 'Actualizar');
                $("form").valid();
                return;
            } else {
                $(form + ' #piezas').removeClass('has-error');
            }
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Marcas/Actualiza",
                $("#ActualizaMarcaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-Marcas').modal('hide');
                        Marcas.colMarcas.add(Marcas.serializaMarcas(data.id), { merge: true });
                        CMI.DespliegaInformacion('La Marcas fue Actualizada. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al actualizar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Actualizar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Actualizar');
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
            ProyectoBuscar.parent = Marcas;
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
            EtapaBuscar.parent = Marcas;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Etapas");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarPlanosMontaje: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "PlanosMontaje/BuscarPlanosMontaje"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            PlanosMontajeBuscar.idEtapa = $('#idEtapaSelect').val();
            PlanosMontajeBuscar.parent = Marcas;
            PlanosMontajeBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Planos Montaje");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarPlanosDespiece: function (){
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "PlanosDespiece/BuscarPlanosDespiece"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            PlanosDespieceBuscar.idPlanoMontaje = $('#idPlanoMontajeSelect').val();
            PlanosDespieceBuscar.parent = Marcas;
            PlanosDespieceBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Planos Despiece");
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

        Marcas.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
            $('.btnNuevo').hide();
            Marcas.accBorrar = false;
            Marcas.accClonar = false;
            CMI.DespliegaError("La revision del proyecto esta Cerrada. La informacion es de solo lectura.");
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }

        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-Marcas')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('#idPlanoMontajeSelect').val('');
        $('#nombrePlanosMontaje').text('Plano Montaje');
        $('#FechaInicioPlanoMontaje').text('Fecha Inicio');
        $('#FechaFinPlanosMontaje').text('Fecha Fin');
        $('#idPlanoDespieceSelect').val('');
        $('#nombrePlanosDespiece').text('Plano Despiece');
        $('#CodigoPlanoDespiece').text('Codigo');
        $('#NombreTipoConstruccion').text('Tipo Construccion');

        $('.btnNuevo').hide();
        $('#planosMontajeRow').hide();
        $('#planosDespieceRow').hide();
        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');
        //Se carga el grid de Marcas asignadas a la etapa
        $('#bbGrid-Marcas')[0].innerHTML = "";

        $('.btnNuevo').hide();
        $('#planosDespieceRow').hide();

        $('#idPlanoMontajeSelect').val('');
        $('#nombrePlanosMontaje').text('Nombre Plano Montaje');
        $('#FechaInicioPlanoMontaje').text('Fecha Inicio');
        $('#FechaFinPlanosMontaje').text('Fecha Fin');

        $('#idPlanoDespieceSelect').val('');
        $('#nombrePlanosDespiece').text('Plano Despiece');
        $('#CodigoPlanoDespiece').text('Codigo');
        $('#NombreTipoConstruccion').text('Tipo Construccion');
        
        $('#planosMontajeRow').show();

    },
    AsignaPlanosMontaje: function (idPlanoMontaje, nombrePlanoMontaje,
                                    fechaInicio, fechaFin) {
        $('#idPlanoMontajeSelect').val(idPlanoMontaje);
        $('#nombrePlanosMontaje').text(nombrePlanoMontaje);
        $('#FechaInicioPlanoMontaje').text(fechaInicio);
        $('#FechaFinPlanosMontaje').text(fechaFin);
        $('#buscar-General').modal('hide');

        $('#idPlanoDespieceSelect').val('');
        $('#nombrePlanosDespiece').text('Plano Despiece');
        $('#CodigoPlanoDespiece').text('Codigo');
        $('#NombreTipoConstruccion').text('Tipo Construccion');

        $('#planosDespieceRow').show();

    },
    AsignaPlanosDespiece: function (idPlanoDespiece, nombrePlanoDespiece,
                                    codigoPlanoDespiece, nombreTipoConstruccion) {

        $('#idPlanoDespieceSelect').val(idPlanoDespiece);
        $('#nombrePlanosDespiece').text(nombrePlanoDespiece);
        $('#CodigoPlanoDespiece').text(codigoPlanoDespiece);
        $('#NombreTipoConstruccion').text(nombreTipoConstruccion);
        $('#buscar-General').modal('hide');
        
        //Se carga el grid de Marcas asignadas a la etapa
        $('#bbGrid-Marcas')[0].innerHTML = "";
        Marcas.CargaGrid();

        if (Marcas.estatusRevision === 1) {
            Marcas.ValidaPermisos();
            ///Muestra el boton de nueva Marca
            if (Marcas.accEscritura === true) {
                $('.btnNuevo').show();
            }
        }
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Marcas/Nuevo"; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-Marcas').html(data);
            $('#nuevo-Marcas').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Marcas.activeForm = '#NuevaMarcaForm';
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Marcas/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Marcas').html(data);
            $('#actualiza-Marcas').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Marcas.activeForm = '#ActualizaMarcaForm';

            if (Marcas.estatusRevision !== 1) {
                $('.btn-ActualizarMarca').hide();
            } else {
                $('.btn-ActualizarMarca').show();
            }
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar la Marca (' + id + ') ?') === false) return;
        var url = contextPath + "Marcas/Borrar"; // El url del controlador
        $.post(url, {
            id: id
        }, function (data) {
            if (data.Success == true) {
                Marcas.colMarcas.remove(id);
                CMI.DespliegaInformacion(data.Message);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la Marca."); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Marcas/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-Marcas').html(data);
            $('#nuevo-Marcas').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Marcas.activeForm = '#NuevaMarcaForm';
        });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = Marcas;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaMarcas: function (id) {
        var form = Marcas.activeForm;
        return ({
            'nombreMarca': $(form + ' #nombreMarca').val().toUpperCase(),
            'codigoMarca': $(form + ' #codigoMarca').val().toUpperCase(),
            'nombreEstatus': $('#idEstatus option:selected').text().toUpperCase(),
            'Piezas': $('#piezas').val().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Marcas/CargaMarcas?idPlanoDespiece=" + $('#idPlanoDespieceSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Marcas.colMarcas = new Backbone.Collection(data);
            var bolFilter = Marcas.colMarcas.length > 0 ? true : false;
            if (bolFilter) {
                gridMarcas = new bbGrid.View({
                    container: $('#bbGrid-Marcas'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: Marcas.accClonar,
                    editar: Marcas.accEscritura,
                    borrar: Marcas.accBorrar,
                    collection: Marcas.colMarcas,
                    seguridad: Marcas.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMarca', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'codigoMarca', filter: true, filterType: 'input' },
                               { title: 'Piezas', name: 'Piezas', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Marcas registradas para el Plano despiece seleccionado.");
                $('#bbGrid-Marcas')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las Marcas");
        });
    }
};

$(function () {
    Marcas.Inicial();
})