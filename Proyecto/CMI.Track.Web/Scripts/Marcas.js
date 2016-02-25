//js de catalogo de Marcas.
//David Galvan
//24/Febrero/2016
var Marcas = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridMarca: {},
    colMarca: {},
    colSeries: [],
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
        $(document).on("click", '.btn-GuardaNuevo', that.onSubirArchivo);
        $(document).on("click", '.btn-ActualizarMarcas', that.onSubirArchivo);
        
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
    onGuardar: function (btn) {
        var form = Marcas.activeForm;

        if ($(form + ' #idTipoConstruccion').val() === '') {
            $(form + ' .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $(form + ' .select2-container').removeClass('has-error');
        }

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $(form + ' #idPlanoMontaje').val($('#idPlanoMontajeSelect').val());
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Marcas/Nuevo",
                $("#NuevoMarcasForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Marcas.colMarcas.add(Marcas.serializaMarcas(data.id));
                        CMI.DespliegaInformacion('El Marcas fue guardado con el Id: ' + data.id);
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
    onActualizar: function (btn) {
        var form = Marcas.activeForm;

        if ($(form + ' #idTipoConstruccion').val() === '') {
            $(form + ' .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $(form + ' .select2-container').removeClass('has-error');
        }

        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Marcas/Actualiza",
                $("#ActualizaMarcasForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-Marcas').modal('hide');
                        Marcas.colMarcas.add(Marcas.serializaMarcas(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Marcas fue Actualizado. Id:' + data.id);
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
        $('#bbGrid-Marcas')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('#idPlanoMontajeSelect').val('');
        $('#nombrePlanosMontaje').text('Plano Montaje');
        $('#FechaInicioPlanoMontaje').text('Fecha Inicio');
        $('#FechaFinPlanosMontaje').text('Fecha Fin');

        $('.btnNuevo').hide();
        $('#planosMontajeRow').hide();
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

        $('#idPlanoMontajeSelect').val('');
        $('#nombrePlanosMontaje').text('Nombre Plano Montaje');
        $('#FechaInicioPlanoMontaje').text('Fecha Inicio');
        $('#FechaFinPlanosMontaje').text('Fecha Fin');
        
        $('#planosMontajeRow').show();

    },
    AsignaPlanosMontaje: function (idPlanoMontaje, nombrePlanoMontaje,
                                    fechaInicio, fechaFin) {
        $('#idPlanoMontajeSelect').val(idPlanoMontaje);
        $('#nombrePlanosMontaje').text(nombrePlanoMontaje);
        $('#FechaInicioPlanoMontaje').text(fechaInicio);
        $('#FechaFinPlanosMontaje').text(fechaFin);
        $('#buscar-General').modal('hide');
        $('#planosDespieceRow').show();

    },
    AsignaPlanosDespiece: function (id, nombrePlanoDespiece,
                                    codigoPlanoDespiece) {


        $('#buscar-General').modal('hide');

        //Se carga el grid de Marcas asignadas a la etapa
        $('#bbGrid-Marcas')[0].innerHTML = "";
        Marcas.CargaGrid();

        ///Muestra el boton de nueva Marcas
        if (Marcas.accEscritura === true)
            $('.btnNuevo').show();
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
            Marcas.activeForm = '#NuevoMarcasForm';
            Marcas.CargarColeccionTipoConstru();
            Marcas.EventoNombreArchivo();
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
            Marcas.activeForm = '#ActualizaMarcasForm';
            Marcas.CargarColeccionTipoConstru();
            Marcas.EventoNombreArchivo();
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el Plano Despiece (' + id + ') ?') === false) return;
        var url = contextPath + "Marcas/Borrar"; // El url del controlador
        $.post(url, {
            id: id
        }, function (data) {
            if (data.Success == true) {
                Marcas.colMarcas.remove(id);
                CMI.DespliegaInformacion(data.Message + "  " + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Plano Montaje."); });
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
            Marcas.activeForm = '#NuevoMarcasForm';
            Marcas.CargarColeccionTipoConstru();
            Marcas.EventoNombreArchivo();
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
            'nombrePlanoDespiece': $(form + ' #nombrePlanoDespiece').val().toUpperCase(),
            'codigoPlanoDespiece': $(form + ' #codigoPlanoDespiece').val().toUpperCase(),
            'nombreEstatus': $('#idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Marcas/CargaMarcas?idPlanoMontaje=" + $('#idPlanoMontajeSelect').val(); // El url del controlador
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
                               { title: 'Nombre Planos Despiece', name: 'nombrePlanoDespiece', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'codigoPlanoDespiece', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Planos de Montaje registradas para la Etapa seleccionada.");
                $('#bbGrid-Marcas')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las Marcas");
        });
    },
    EventoNombreArchivo: function () {
        var form = Marcas.activeForm;
        //Se inicializan los eventos para el formulario
        $(form + ' .btn-file :file').on('fileselect', function (event, numFiles, label) {
            var input = $(this).parents('.input-group').find(':text'),
                log = numFiles > 1 ? numFiles + ' files selected' : label;

            if (input.length) {
                input.val(log);
            } else {
                if (log) console.log(log);
            }
        });

        $(document).on('change', '.btn-file :file', function () {
            var input = $(this),
                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });
    },
    CargarColeccionTipoConstru: function () {
        if (Marcas.colTipoConstruccion.length < 1) {
            var url = contextPath + "TipoConstruccion/CargaTiposConstruccionActivos"; // El url del controlador
            $.getJSON(url, function (data) {
                Marcas.colTipoConstruccion = data;
                Marcas.CargaListaTiposConstruccion();
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Tipos de Construccion");
            });
        } else {
            Marcas.CargaListaTiposConstruccion();
        }
    },
    CargaListaTiposConstruccion: function () {
        var form = Marcas.activeForm;
        var select = $(form + ' #idTipoConstruccion').empty();
        // constructs the suggestion engine               
        select.append('<option> </option>');

        $.each(Marcas.colTipoConstruccion, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.NombreTipoConstruccion
                                 + '</option>');
        });

        $(form + ' #idTipoConstruccion').val($(form + ' #tipoConstruccion').val());
        //Inicializa el combo para que pueda hacer busquedas
        $(form + " .select2").select2({ allowClear: true, placeholder: 'Tipo Contruccion' });
    },
};

$(function () {
    Marcas.Inicial();
})