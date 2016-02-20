//js de catalogo de Planos de Montaje.
//David Galvan
//17/Febrero/2016

var PlanosMontaje = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridPlanosMontajes: {},
    colPlanosMontajes: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarPlanosMontaje', that.onActualizar);

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
        var btn = this;
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $('#NuevaPlanosMontajeForm #idProyecto').val($('#idProyectoSelect').val());
            $('#NuevaPlanosMontajeForm #revisionProyecto').val($('#RevisionPro').text());

            //Se hace el post para guardar la informacion
            $.post(contextPath + "PlanosMontaje/Nuevo",
                $("#NuevaPlanosMontajeForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        PlanosMontaje.colPlanosMontajes.add(PlanosMontaje.serializaPlanosMontaje(data.id));
                        CMI.DespliegaInformacion('El PlanosMontaje fue guardado con el Id: ' + data.id);
                        $('#nuevo-PlanosMontaje').modal('hide');
                        if (PlanosMontaje.colPlanosMontajes.length === 1) {
                            PlanosMontaje.CargaGrid();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Guardar');
        }
    },
    onActualizar: function (btn) {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "PlanosMontaje/Actualiza",
                $("#ActualizaPlanosMontajeForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-PlanosMontaje').modal('hide');
                        PlanosMontaje.colPlanosMontajes.add(PlanosMontaje.serializaPlanosMontaje(data.id), { merge: true });
                        CMI.DespliegaInformacion('El PlanosMontaje fue Actualizado. Id:' + data.id);
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
            $('#buscar-Proyecto').html(data);
            $('#buscar-Proyecto').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            ProyectoBuscar.Inicial();
            ProyectoBuscar.parent = PlanosMontaje;
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
        $('#buscar-Proyecto').modal('hide');

        //Se carga el grid de PlanosMontajes asignadas al proyecto
        $('#bbGrid-PlanosMontajes')[0].innerHTML = "";
        PlanosMontaje.CargaGrid();

        ///Muestra el boton de nueva PlanosMontaje
        if (PlanosMontaje.accEscritura === true)
            $('.btnNuevo').show();
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "PlanosMontaje/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-PlanosMontaje').html(data);
            $('#nuevo-PlanosMontaje').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos          
            PlanosMontaje.activeForm = '#NuevaPlanosMontajeForm';
            PlanosMontaje.IniciaDateControls();
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "PlanosMontaje/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-PlanosMontaje').html(data);
            $('#actualiza-PlanosMontaje').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            PlanosMontaje.activeForm = '#ActualizaPlanosMontajeForm';
            PlanosMontaje.IniciaDateControls();
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar la PlanosMontaje (' + id + ') ?') === false) return;
        var url = contextPath + "PlanosMontaje/Borrar"; // El url del controlador
        $.post(url, {
            id: id
        }, function (data) {
            if (data.Success == true) {
                PlanosMontaje.colPlanosMontajes.remove(id);
                CMI.DespliegaInformacion(data.Message + "  " + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la PlanosMontaje."); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "PlanosMontaje/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-PlanosMontaje').html(data);
            $('#nuevo-PlanosMontaje').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            PlanosMontaje.activeForm = '#NuevaPlanosMontajeForm';
            PlanosMontaje.IniciaDateControls();
        });
    },
    IniciaDateControls: function () {
        var form = PlanosMontaje.activeForm;
        $(form + ' #dtpFechaInicio').datetimepicker({ format: 'MM/DD/YYYY' });
        $(form + ' #dtpFechaFin').datetimepicker({
            useCurrent: false,
            format: 'MM/DD/YYYY'
        });
        $(form + ' #dtpFechaInicio').on("dp.change", function (e) {
            $('#dtpFechaFin').data("DateTimePicker").minDate(e.date);
        });
        $(form + ' #dtpFechaFin').on("dp.change", function (e) {
            $('#dtpFechaInicio').data("DateTimePicker").maxDate(e.date);
        });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = PlanosMontaje;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaPlanosMontaje: function (id) {
        var form = PlanosMontaje.activeForm;
        return ({
            'nombrePlanosMontaje': $(form + ' #nombrePlanosMontaje').val().toUpperCase(),
            'fechaInicio': $(form + ' #fechaInicio').val(),
            'fechaFin': $(form + ' #fechaFin').val(),
            'nombreEstatus': $('#estatusPlanosMontaje option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "PlanosMontaje/CargaPlanosMontajes?idProyecto=" + $('#idProyectoSelect').val() + "&revision=" + $('#RevisionPro').text(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            PlanosMontaje.colPlanosMontajes = new Backbone.Collection(data);
            var bolFilter = PlanosMontaje.colPlanosMontajes.length > 0 ? true : false;
            if (bolFilter) {
                gridPlanosMontajes = new bbGrid.View({
                    container: $('#bbGrid-PlanosMontajes'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: PlanosMontaje.accClonar,
                    editar: PlanosMontaje.accEscritura,
                    borrar: PlanosMontaje.accBorrar,
                    collection: PlanosMontaje.colPlanosMontajes,
                    seguridad: PlanosMontaje.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre PlanosMontaje', name: 'nombrePlanosMontaje', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'fechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'fechaFin', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron PlanosMontajes registradas para el proyecto seleccionado.");
                $('#bbGrid-PlanosMontajes')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las PlanosMontajes");
        });
    }
};

$(function () {
    PlanosMontaje.Inicial();
})