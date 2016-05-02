/*global $, CMI, Backbone, bbGrid, contextPath, EtapaBuscar, ProyectoBuscar, PlanosMontajeBuscar,MarcasBuscar, PlanosDespieceBuscar*/
//js de catalogo de SubMarcas.
//David Galvan
//01/Marzo/2016
var SubMarcas = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    estatusRevision: 0,
    activeForm: '',
    gridSubMarca: {},
    colSubMarcas: {},
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
        $('#btnBuscarMarcas').click(that.onBuscarMarcas);
        $('.btnNuevo').click(that.Nuevo);

        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarSubMarca', that.onActualizar);

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
        var form = SubMarcas.activeForm,
            btn = this;
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $(form + ' #idMarca').val($('#idMarcaSelect').val());
            $(form + ' #idOrdenProduccion').val($('#idEtapaSelect').val());
            //Se hace el post para guardar la informacion
            $.post(contextPath + "SubMarcas/Nuevo",
                $("#NuevaSubMarcaForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        SubMarcas.colSubMarcas.add(SubMarcas.serializaSubMarcas(data.id));
                        CMI.DespliegaInformacion('La SubMarcas fue guardado con el Id: ' + data.id);
                        $('#nuevo-subMarcas').modal('hide');
                        if (SubMarcas.colSubMarcas.length === 1) {
                            SubMarcas.CargaGrid();
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
        var btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "SubMarcas/Actualiza",
                $("#ActualizaSubMarcaForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        $('#actualiza-subMarcas').modal('hide');
                        SubMarcas.colSubMarcas.add(SubMarcas.serializaSubMarcas(data.id), { merge: true });
                        CMI.DespliegaInformacion('La SubMarcas fue Actualizada. Id:' + data.id);
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
            ProyectoBuscar.parent = SubMarcas;
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
            EtapaBuscar.parent = SubMarcas;
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
            PlanosMontajeBuscar.parent = SubMarcas;
            PlanosMontajeBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Planos Montaje");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarPlanosDespiece: function () {
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
            PlanosDespieceBuscar.parent = SubMarcas;
            PlanosDespieceBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Planos Despiece");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarMarcas: function (){
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Marcas/BuscarMarcas"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            MarcasBuscar.idPlanoDespiece = $('#idPlanoDespieceSelect').val();
            MarcasBuscar.parent = SubMarcas;
            MarcasBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Marcas");
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

        SubMarcas.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
            $('.btnNuevo').hide();
            SubMarcas.accBorrar = false;
            SubMarcas.accClonar = false;
            CMI.DespliegaError("La revision del proyecto esta Cerrada. La informacion es de solo lectura.");
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }
        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-subMarcas')[0].innerHTML = "";
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
        $('#idMarcaSelect').val('');
        $('#nombreMarcas').text('Nombre Marca');
        $('#codigoMarcas').text('Codigo');
        $('#piezasMarca').text('Piezas');

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
        //Se carga el grid de SubMarcas asignadas a la etapa
        $('#bbGrid-subMarcas')[0].innerHTML = "";

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

        $('#idMarcaSelect').val('');
        $('#nombreMarcas').text('Nombre Marca');
        $('#codigoMarcas').text('Codigo');
        $('#piezasMarca').text('Piezas');

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

        $('#idMarcaSelect').val('');
        $('#nombreMarcas').text('Nombre Marca');
        $('#codigoMarcas').text('Codigo');
        $('#piezasMarca').text('Piezas');

        $('#planosDespieceRow').show();

    },
    AsignaPlanosDespiece: function (idPlanoDespiece, nombrePlanoDespiece,
                                    codigoPlanoDespiece, nombreTipoConstruccion) {

        $('#idPlanoDespieceSelect').val(idPlanoDespiece);
        $('#nombrePlanosDespiece').text(nombrePlanoDespiece);
        $('#CodigoPlanoDespiece').text(codigoPlanoDespiece);
        $('#NombreTipoConstruccion').text(nombreTipoConstruccion);
        $('#buscar-General').modal('hide');

        $('#idMarcaSelect').val('');
        $('#nombreMarcas').text('Nombre Marca');
        $('#codigoMarcas').text('Codigo');
        $('#piezasMarca').text('Piezas');

        //Se carga el grid de SubMarcas asignadas a la etapa
        $('#bbGrid-subMarcas')[0].innerHTML = "";
        
        $('#marcasRow').show();
    },
    AsignaMarca: function(id, nombreMarca,
                          codigoMarca, piezas){

        $('#idMarcaSelect').val(id);
        $('#nombreMarcas').text(nombreMarca);
        $('#codigoMarcas').text(codigoMarca);
        $('#piezasMarca').text(piezas);
        $('#buscar-General').modal('hide');

        //Se carga el grid de SubMarcas asignadas a la etapa
        $('#bbGrid-subMarcas')[0].innerHTML = "";
        SubMarcas.CargaGrid();

        if (SubMarcas.estatusRevision === 1) {
            SubMarcas.ValidaPermisos();
            ///Muestra el boton de nueva SubMarca
            if (SubMarcas.accEscritura === true) {
                $('.btnNuevo').show();
            }
        }
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "SubMarcas/Nuevo"; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-subMarcas').html(data);
            $('#nuevo-subMarcas').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            SubMarcas.activeForm = '#NuevaSubMarcaForm';
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "SubMarcas/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-subMarcas').html(data);
            $('#actualiza-subMarcas').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            SubMarcas.activeForm = '#ActualizaSubMarcaForm';

            if (SubMarcas.estatusRevision !== 1) {
                $('.btn-ActualizarSubMarca').hide();
            } else {
                $('.btn-ActualizarSubMarca').show();
            }
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar la SubMarca (' + id + ') ?') === false) return;
        var url = contextPath + "SubMarcas/Borrar"; // El url del controlador
        $.post(url, {
            id: id
        }, function (data) {
            if (data.Success === true) {
                SubMarcas.colSubMarcas.remove(id);
                CMI.DespliegaInformacion(data.Message);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la subMarca."); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "SubMarcas/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-subMarcas').html(data);
            $('#nuevo-subMarcas').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            SubMarcas.activeForm = '#NuevaSubMarcaForm';
        });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = SubMarcas;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaSubMarcas: function (id) {
        var form = SubMarcas.activeForm;
        return ({
            'codigoSubMarca': $(form + ' #codigoSubMarca').val().toUpperCase(),
            'perfilSubMarca': $(form + ' #perfilSubMarca').val().toUpperCase(),
            'piezasSubMarcas': $(form + ' #piezasSubMarcas').val(),
            'corteSubMarcas': $(form + ' #corteSubMarcas').val(),
            'longitudSubMarcas': $(form + ' #longitudSubMarcas').val(),
            'anchoSubMarcas': $(form + ' #anchoSubMarcas').val(),
            'gradoSubMarcas': $(form + ' #gradoSubMarcas').val(),
            'kgmSubMarcas': $(form + ' #kgmSubMarcas').val(),
            'totalLASubMarcas': $(form + ' #totalLASubMarcas').val(),
            'pesoSubMarcas': $(form + ' #pesoSubMarcas').val(),
            'nombreEstatus': $('#idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "SubMarcas/CargaSubMarcas?idMarca=" + $('#idMarcaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            SubMarcas.colSubMarcas = new Backbone.Collection(data);
            var bolFilter = SubMarcas.colSubMarcas.length > 0 ? true : false;
            if (bolFilter) {
                SubMarcas.gridSubMarca = new bbGrid.View({
                    container: $('#bbGrid-subMarcas'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: SubMarcas.accClonar,
                    editar: SubMarcas.accEscritura,
                    borrar: SubMarcas.accBorrar,
                    collection: SubMarcas.colSubMarcas,
                    seguridad: SubMarcas.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'codigoSubMarca', filter: true, filterType: 'input' },
                               { title: 'Perfil', name: 'perfilSubMarca', filter: true, filterType: 'input' },
                               { title: 'Piezas', name: 'piezasSubMarcas', filter: true, filterType: 'input' },
                               { title: 'Corte', name: 'corteSubMarcas', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'longitudSubMarcas', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'anchoSubMarcas', filter: true, filterType: 'input' },
                               { title: 'Grado', name: 'gradoSubMarcas', filter: true, filterType: 'input' },
                               { title: 'KGM', name: 'kgmSubMarcas', filter: true, filterType: 'input' },
                               { title: 'TotalLA', name: 'totalLASubMarcas', filter: true, filterType: 'input' },
                               { title: 'Peso', name: 'pesoSubMarcas', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron SubMarcas registradas para la Marca seleccionada.");
                $('#bbGrid-subMarcas')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de las SubMarcas");
        });
    }
};

$(function () {
    SubMarcas.Inicial();
});