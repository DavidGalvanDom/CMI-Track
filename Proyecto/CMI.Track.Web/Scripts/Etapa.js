//js de catalogo de Etapas.
//David Galvan
//17/Febrero/2016

var Etapa = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',   
    gridEtapas: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        //this.CargaGrid();
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarEtapa', that.onActualizar);

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
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Etapa/Nuevo",
                $("#NuevoEtapaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Etapa.colEtapas.add(Etapa.serializaEtapa(data.id));
                        CMI.DespliegaInformacion('El Etapa fue guardado con el Id: ' + data.id);
                        $('#nuevo-Etapa').modal('hide');
                        if (Etapa.colEtapas.length === 1) {
                            Etapa.CargaGrid();
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
            $.post(contextPath + "Etapa/Actualiza",
                $("#ActualizaEtapaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-Etapa').modal('hide');
                        Etapa.colEtapas.add(Etapa.serializaEtapa(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Etapa fue Actualizado. Id:' + data.id);
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
            ProyectoBuscar.parent = Etapa;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaProyecto: function (idProyecto, Revision,
                             NombreProyecto, CodigoProyecto,
                             FechaInicio, FechaFin) {        
        $('#idProyecto').val(idProyecto);
        $('#Revision').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        $('#nombreProyecto').removeClass('input-validation-error');
        ///Se cierra la ventana de Proyectos
        $('#buscar-Proyecto').modal('hide');
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Etapa/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-Etapa').html(data);
            $('#nuevo-Etapa').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos          
            Etapa.activeForm = '#NuevoEtapaForm';
            $(Etapa.activeForm + ' #btnBuscarCliente').click(Etapa.onBuscarCliente);            
            Etapa.IniciaDateControls();
            Etapa.CargarColeccionCategorias();
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var Etapa = Etapa.colEtapas.get(id);
        var url = contextPath + "Etapa/Actualiza?idEtapa=" + Etapa.attributes.idEtapa + '&revision=' + Etapa.attributes.Revision; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Etapa').html(data);
            $('#actualiza-Etapa').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Etapa.activeForm = '#ActualizaEtapaForm';
            $(Etapa.activeForm + ' #btnBuscarCliente').click(Etapa.onBuscarCliente);
            Etapa.IniciaDateControls();
            Etapa.CargarColeccionCategorias();
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        var Etapa = Etapa.colEtapas.get(id);
        if (confirm('¿Esta seguro que desea borrar el Etapa (' + Etapa.attributes.NombreEtapa + ') ?') === false) return;
        var url = contextPath + "Etapa/Borrar"; // El url del controlador
        $.post(url, {
            idEtapa: Etapa.attributes.idEtapa,
            revision: Etapa.attributes.Revision
        }, function (data) {
            if (data.Success == true) {
                Etapa.colEtapas.remove(id);
                CMI.DespliegaInformacion(data.Message + "  " + Etapa.attributes.NombreEtapa);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Etapa post Borrar"); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var Etapa = Etapa.colEtapas.get(id);
        var url = contextPath + "Etapa/Clonar?idEtapa=" + Etapa.attributes.idEtapa + '&revision=' + Etapa.attributes.Revision; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-Etapa').html(data);
            $('#nuevo-Etapa').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Etapa.activeForm = '#NuevoEtapaForm';
            $(Etapa.activeForm + ' #btnBuscarCliente').click(Etapa.onBuscarCliente);
            Etapa.IniciaDateControls();
            Etapa.CargarColeccionCategorias();
        });
    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = Etapa;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaEtapa: function (id) {
        var form = Etapa.activeForm;
        return ({
            'idEtapa': id,
            'NombreEtapa': $(form + ' #nombreEtapa').val().toUpperCase(),
            'Revision': $(form + ' #revisionEtapa').val().toUpperCase(),
            'CodigoEtapa': $(form + ' #codigoEtapa').val().toUpperCase(),
            'FechaInicio': $(form + ' #fechaInicio').val(),
            'FechaFin': $(form + ' #fechaFin').val(),
            'nombreEstatus': $('#estatusEtapa option:selected').text().toUpperCase(),
            'id': id + $('#revisionEtapa').val().toUpperCase()
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Etapa/CargaEtapas"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Etapa.colEtapas = new Backbone.Collection(data);
            var bolFilter = Etapa.colEtapas.length > 0 ? true : false;
            if (bolFilter) {
                gridEtapas = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Etapa.accClonar,
                    editar: Etapa.accEscritura,
                    borrar: Etapa.accBorrar,
                    collection: Etapa.colEtapas,
                    seguridad: Etapa.accSeguridad,
                    colModel: [{ title: 'Id', name: 'idEtapa', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Etapa', name: 'NombreEtapa', filter: true, filterType: 'input' },
                               { title: 'Revision', name: 'Revision', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'CodigoEtapa', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'FechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'FechaFin', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Etapas registradas");
                $('#bbGrid-clear')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las Etapas");
        });
    }
   
};

$(function () {
    Etapa.Inicial();
})