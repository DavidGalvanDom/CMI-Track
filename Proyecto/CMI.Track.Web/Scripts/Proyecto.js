//js de catalogo de Proyectos.
//David Galvan
//29/Enero/2016

var Proyecto = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    colProyectos: {},
    colCategorias: [],
    gridProyectos: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onSubirArchivo);
        $(document).on("click", '.btn-ActualizarProyecto', that.onSubirArchivo);
        
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
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Proyecto/Nuevo",
                $("#NuevoProyectoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Proyecto.colProyectos.add(Proyecto.serializaProyecto(data.id));
                        CMI.DespliegaInformacion('El Proyecto fue guardado con el Id: ' + data.id);
                        $('#nuevo-Proyecto').modal('hide');
                        if (Proyecto.colProyectos.length === 1) {
                            Proyecto.CargaGrid();
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
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Proyecto/Actualiza",
                $("#ActualizaProyectoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-Proyecto').modal('hide');
                        Proyecto.colProyectos.add(Proyecto.serializaProyecto(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Proyecto fue Actualizado. Id:' + data.id);
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
    onSubirArchivo: function () { 
        var filesName = Proyecto.activeForm === '#NuevoProyectoForm' ? 'fPlano' : 'fPlanoAct',
            btn = this,
            form = Proyecto.activeForm,
            files;

        //Agrega la clase de mandatorio cuando no ha seleccionado un cliente.
        if ($(form + ' #idCliente').val() === "0") {
            $(form + ' #nombreCliente').addClass('input-validation-error');
        }

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
                        url: '/Proyecto/SubirArchivo',
                        contentType: false,
                        processData: false,
                        data: data,
                        success: function (result) {
                            
                            if (result.Success === true) {
                                $(Proyecto.activeForm + ' #archivoPlanoProyecto').val(result.Archivo);

                                if (Proyecto.activeForm !== '#NuevoProyectoForm') {
                                    Proyecto.onActualizar(btn);
                                } else {
                                    Proyecto.onGuardar(btn);
                                }
                                   
                            } else {
                                $(Proyecto.activeForm + ' #archivoPlanoProyecto').val('');
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
                if (Proyecto.activeForm !== '#NuevoProyectoForm') {
                    Proyecto.onActualizar(btn);
                } else {
                    $(Proyecto.activeForm + ' #archivoPlanoProyecto').val('');
                    Proyecto.onGuardar(btn);
                }
            }
        }
    },
    onBuscarCliente: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Cliente/BuscarCliente"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-Cliente').html(data);
            $('#buscar-Cliente').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            ClienteBuscar.Inicial();
            ClienteBuscar.parent = Proyecto;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar clietnes");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onNuevaRevison: function(btn) {
        CMI.botonMensaje(true, btn, 'Nueva Revision');
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/NuevaRevision/" + $("#ActualizaProyectoForm #id").val(); // El url del controlador
        $.post(url, function (data) {
            if (data.Success === true) {
                $('#idEstatusRevision').val(data.Data.Estatus);
                $('#fechaRevision').val(data.Data.Fecha);
                $('#revisionProyecto').val(data.Data.Codigo);
                $('#btnNuevaRevicion').hide();
                CMI.DespliegaInformacionDialogo("Se genero la nueva revision.");
            } else {
                CMI.DespliegaErrorDialogo(data.Message);
            }

            CMI.botonMensaje(false, btn, 'Nueva Revision');
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo generar la nueva revision.");
        }).always(function () { CMI.botonMensaje(false, btn, 'Nueva Revision');});
    },
    AsignaCliente: function (idCliente, nombreClietne,
                             direccionEntrega, contactoCliente) {
        var that = Proyecto;
        $(that.activeForm + ' #idCliente').val(idCliente);
        $(that.activeForm + ' #contacto').text(contactoCliente);
        $(that.activeForm + ' #direccion').text(direccionEntrega);
        $(that.activeForm + ' #nombreCliente').text(nombreClietne);
        $(that.activeForm + ' #nombreCliente').removeClass('input-validation-error');
        ///Se cierra la ventana de Clientes
        $('#buscar-Cliente').modal('hide');
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-Proyecto').html(data);
            $('#nuevo-Proyecto').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proyecto.activeForm = '#NuevoProyectoForm';
            $(Proyecto.activeForm + ' #btnBuscarCliente').click(Proyecto.onBuscarCliente);
            Proyecto.EventoNombreArchivo();
            Proyecto.IniciaDateControls();
            Proyecto.CargarColeccionCategorias();
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var proyecto = Proyecto.colProyectos.get(id);
        var url = contextPath + "Proyecto/Actualiza?idProyecto=" + proyecto.attributes.idProyecto + '&revision=' + proyecto.attributes.Revision; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Proyecto').html(data);
            $('#actualiza-Proyecto').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proyecto.activeForm = '#ActualizaProyectoForm';
            $(Proyecto.activeForm + ' #btnBuscarCliente').click(Proyecto.onBuscarCliente);
            Proyecto.EventoNombreArchivo();
            Proyecto.IniciaDateControls();
            Proyecto.CargarColeccionCategorias();
            if ($(Proyecto.activeForm + ' #idEstatusRevision').val() === '0') {
                $('#btnNuevaRevicion').show();
            }
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        var proyecto = Proyecto.colProyectos.get(id);
        if (confirm('¿Esta seguro que desea borrar el proyecto (' + proyecto.attributes.NombreProyecto + ') ?') === false) return;
        var url = contextPath + "Proyecto/Borrar"; // El url del controlador
        $.post(url, {
            idProyecto: proyecto.attributes.idProyecto,
            revision: proyecto.attributes.Revision
        }, function (data) {
            if (data.Success == true) {
                Proyecto.colProyectos.remove(id);
                CMI.DespliegaInformacion(data.Message + "  " + proyecto.attributes.NombreProyecto);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Proyecto post Borrar"); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var proyecto = Proyecto.colProyectos.get(id);
        var url = contextPath + "Proyecto/Clonar?idProyecto=" + proyecto.attributes.idProyecto + '&revision=' + proyecto.attributes.Revision; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-Proyecto').html(data);
            $('#nuevo-Proyecto').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proyecto.activeForm = '#NuevoProyectoForm';
            $(Proyecto.activeForm + ' #btnBuscarCliente').click(Proyecto.onBuscarCliente);
            Proyecto.EventoNombreArchivo();
            Proyecto.IniciaDateControls();
            Proyecto.CargarColeccionCategorias();
        });
    },   
    CargarColeccionCategorias: function () {
        var form = Proyecto.activeForm;
        if (Proyecto.colCategorias.length < 1) {
            var url = contextPath + "Categoria/CargaCategoriasActivas"; // El url del controlador
            $.getJSON(url, function (data) {
                Proyecto.colCategorias = data;
                Proyecto.CargaListaCategorias(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Categorias");
            });
        } else {
            Proyecto.CargaListaCategorias(form);
        }
    },
    CargaListaCategorias: function (form) {
        var select = $(form + ' #idCategoria').empty();

        select.append('<option> </option>');

        $.each(Proyecto.colCategorias, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.NombreCategoria
                                 + '</option>');
        });

        $(form + ' #idCategoria').val($(form + ' #categoria').val());
    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = Proyecto;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaProyecto: function (id) {
        var form = Proyecto.activeForm;
        return ({
            'idProyecto': id,
            'NombreProyecto': $(form + ' #nombreProyecto').val().toUpperCase(),
            'Revision': $(form + ' #revisionProyecto').val().toUpperCase(),
            'CodigoProyecto': $(form + ' #codigoProyecto').val().toUpperCase(),
            'FechaInicio': $(form + ' #fechaInicio').val(),
            'FechaFin': $(form + ' #fechaFin').val(),
            'nombreEstatus': $('#estatusProyecto option:selected').text().toUpperCase(),
            'id': id + $('#revisionProyecto').val().toUpperCase()
        });
    },
    IniciaDateControls: function () {
        var form = Proyecto.activeForm;
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
    CargaGrid: function () {
        var url = contextPath + "Proyecto/CargaProyectos"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Proyecto.colProyectos = new Backbone.Collection(data);
            var bolFilter = Proyecto.colProyectos.length > 0 ? true : false;
            if (bolFilter) {
                gridProyectos = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Proyecto.accClonar,
                    editar: Proyecto.accEscritura,
                    borrar: Proyecto.accBorrar,
                    collection: Proyecto.colProyectos,
                    seguridad: Proyecto.accSeguridad,
                    colModel: [{ title: 'Id', name: 'idProyecto', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Proyecto', name: 'NombreProyecto', filter: true, filterType: 'input' },
                               { title: 'Revision', name: 'Revision', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'CodigoProyecto', filter: true, filterType: 'input' },
                               { title: 'Fecha Inicio', name: 'FechaInicio', filter: true, filterType: 'input' },
                               { title: 'Fecha Fin', name: 'FechaFin', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Proyectos registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Proyecto");
        });
    },
    EventoNombreArchivo: function () {
        var form = Proyecto.activeForm;
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
    Proyecto.Inicial();
})