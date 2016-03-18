//js de catalogo de Planos de Montaje.
//David Galvan
//17/Febrero/2016
var PlanosMontaje = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridPlanosMontaje: {},
    colPlanosMontaje: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onSubirArchivo);
        $(document).on("click", '.btn-ActualizarPlanosMontaje', that.onSubirArchivo);
        $('#etapaRow').hide();

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
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $('#NuevoPlanosMontajeForm #idEtapa').val($('#idEtapaSelect').val());
            //Se hace el post para guardar la informacion
            $.post(contextPath + "PlanosMontaje/Nuevo",
                $("#NuevoPlanosMontajeForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        PlanosMontaje.colPlanosMontaje.add(PlanosMontaje.serializaPlanosMontaje(data.id));
                        CMI.DespliegaInformacion('El PlanosMontaje fue guardado con el Id: ' + data.id);
                        $('#nuevo-PlanosMontaje').modal('hide');
                        if (PlanosMontaje.colPlanosMontaje.length === 1) {
                            PlanosMontaje.CargaGrid();
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
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "PlanosMontaje/Actualiza",
                $("#ActualizaPlanosMontajeForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-PlanosMontaje').modal('hide');
                        PlanosMontaje.colPlanosMontaje.add(PlanosMontaje.serializaPlanosMontaje(data.id), { merge: true });
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
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
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
    onBuscarEtapa: function (){
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
            EtapaBuscar.parent = PlanosMontaje;
            EtapaBuscar.Inicial();            
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onSubirArchivo: function () {
        var filesName = PlanosMontaje.activeForm === '#NuevoPlanosMontajeForm' ? 'fPlano' : 'fPlanoAct',
            btn = this,
            form = PlanosMontaje.activeForm,
            files;

        if ($("form").valid()) {
            CMI.botonMensaje(true, btn, 'Guardar');
            files = document.getElementById(filesName).files;
            if (files.length > 0) {
                if (window.FormData !== undefined) {
                    var data = new FormData();
                    for (var count = 0; count < files.length; count++) {
                        data.append(files[count].name, files[count]);
                    }
                    $.ajax({
                        type: "POST",
                        url: '/PlanosMontaje/SubirArchivo',
                        contentType: false,
                        processData: false,
                        data: data,
                        success: function (result) {

                            if (result.Success === true) {
                                $(PlanosMontaje.activeForm + ' #archivoPlanoMontaje').val(result.Archivo);

                                if (PlanosMontaje.activeForm !== '#NuevoPlanosMontajeForm') {
                                    PlanosMontaje.onActualizar(btn);
                                } else {
                                    PlanosMontaje.onGuardar(btn);
                                }

                            } else {
                                $(PlanosMontaje.activeForm + ' #archivoPlanoMontaje').val('');
                                CMI.DespliegaErrorDialogo(result.Message);
                                CMI.botonMensaje(false, btn, 'Guardar');
                            }
                        },
                        error: function (xhr, status, p3, p4) {
                            var err = "Error " + " " + status + " " + p3 + " " + p4;
                            if (xhr.responseText && xhr.responseText[0] == "{") {
                                err = JSON.parse(xhr.responseText).Message;
                            }
                            CMI.DespliegaErrorDialogo(err);
                            CMI.botonMensaje(false, btn, 'Guardar');
                        }
                    });
                } else {
                    CMI.DespliegaErrorDialogo("Este explorador no soportado por la aplicacion favor de utilizar una version mas reciente. Chrome");
                    CMI.botonMensaje(false, btn, 'Guardar');
                }
            } else {
                if (PlanosMontaje.activeForm !== '#NuevoPlanosMontajeForm') {
                    PlanosMontaje.onActualizar(btn);
                } else {
                    $(PlanosMontaje.activeForm + ' #archivoPlanoMontaje').val('');
                    PlanosMontaje.onGuardar(btn);
                }
            }
        }
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
        $('#bbGrid-PlanosMontaje')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('.btnNuevo').hide();

        $('#etapaRow').show();       
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);       
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        //Se carga el grid de PlanosMontaje asignadas a la etapa
        $('#bbGrid-PlanosMontaje')[0].innerHTML = "";
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
            PlanosMontaje.activeForm = '#NuevoPlanosMontajeForm';
            PlanosMontaje.EventoNombreArchivo();
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
            PlanosMontaje.EventoNombreArchivo();
            PlanosMontaje.IniciaDateControls();
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el Plano de Montaje (' + id + ') ?') === false) return;
        var url = contextPath + "PlanosMontaje/Borrar"; // El url del controlador
        $.post(url, {
            id: id
        }, function (data) {
            if (data.Success == true) {
                PlanosMontaje.colPlanosMontaje.remove(id);
                CMI.DespliegaInformacion(data.Message + "  " + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Plano Montaje."); });
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
            PlanosMontaje.activeForm = '#NuevoPlanosMontajeForm';
            PlanosMontaje.EventoNombreArchivo();
            PlanosMontaje.IniciaDateControls();
        });
    },
    IniciaDateControls: function () {
        var form = PlanosMontaje.activeForm;
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
        var permisos = localStorage.modPermisos,
            modulo = PlanosMontaje;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaPlanosMontaje: function (id) {
        var form = PlanosMontaje.activeForm;
        return ({
            'nombrePlanoMontaje': $(form + ' #nombrePlanoMontaje').val().toUpperCase(),
            'fechaInicio': $(form + ' #fechaInicio').val(),
            'fechaFin': $(form + ' #fechaFin').val(),
            'nombreEstatus': $('#idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "PlanosMontaje/CargaPlanosMontaje?idEtapa=" + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            PlanosMontaje.colPlanosMontaje = new Backbone.Collection(data);
            var bolFilter = PlanosMontaje.colPlanosMontaje.length > 0 ? true : false;
            if (bolFilter) {
                gridPlanosMontaje = new bbGrid.View({
                    container: $('#bbGrid-PlanosMontaje'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: PlanosMontaje.accClonar,
                    editar: PlanosMontaje.accEscritura,
                    borrar: PlanosMontaje.accBorrar,
                    collection: PlanosMontaje.colPlanosMontaje,
                    seguridad: PlanosMontaje.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre PlanosMontaje', name: 'nombrePlanoMontaje', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'fechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'fechaFin', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Planos de Montaje registradas para la Etapa seleccionada.");
                $('#bbGrid-PlanosMontaje')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las PlanosMontaje");
        });
    },
    EventoNombreArchivo: function () {
        var form = PlanosMontaje.activeForm;
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
    }
};

$(function () {
    PlanosMontaje.Inicial();
})