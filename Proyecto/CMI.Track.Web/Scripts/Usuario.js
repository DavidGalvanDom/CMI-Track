﻿/*global $, CMI, Backbone, bbGrid, contextPath, Seguridad*/
//js de catalogo de usuarios.
//David Galvan
//29/Enero/2016

var Usuario = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    colUsuarios: {},
    colDepartamentos: [],
    colProcesos: [],
    gridUsuarios: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarUsuario', that.onActualizar);

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

        $(document).on('click', '.accrowSeguridad', function () {
            that.Seguridad($(this).parent().parent().attr("data-modelId"));
        });

        $(document).on('change', '#NombreUsuario', that.ValidaNomUsuario);
    },
    onGuardar: function () {
        var btn = this;

        if($('#NuevoUsuarioForm #idDepartamento').val() === ''){
            $('#NuevoUsuarioForm .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $('#NuevoUsuarioForm .select2-container').removeClass('has-error');
        }

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Usuario/Nuevo",
                $("#NuevoUsuarioForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        Usuario.colUsuarios.add(Usuario.serializaUsuario(data.id, '#NuevoUsuarioForm'));
                        CMI.DespliegaInformacion('El Usuario fue guardado con el Id: ' + data.id);
                        $('#nuevo-usuario').modal('hide');
                        if (Usuario.colUsuarios.length === 1) {
                            Usuario.CargaGrid();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al guardar la informacion"); 
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Guardar');
        }
    },
    onActualizar: function () {
        var btn = this;

        if ($('#ActualizaUsuarioForm #idDepartamento').val() === '') {
            $('#ActualizaUsuarioForm .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $('#ActualizaUsuarioForm .select2-container').removeClass('has-error');
        }

        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Usuario/Actualiza",
                $("#ActualizaUsuarioForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        $('#actualiza-usuario').modal('hide');
                        Usuario.colUsuarios.add(Usuario.serializaUsuario(data.id, '#ActualizaUsuarioForm'), { merge: true });
                        CMI.DespliegaInformacion('El usuario fue Actualizado. Id:' + data.id);
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al actualizar la informacion"); 
                }).always(function () {CMI.botonMensaje(false, btn, 'Actualizar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Actualizar');
        }
    },
    Seguridad: function (idUsuairo){
        CMI.CierraMensajes();
        var url = contextPath + "Seguridad/Modulos/" + idUsuairo, // El url del controlador
            _usuario;
        $.get(url, function (data) {
            $('#seguridadUsuario').html(data);
            $('#seguridadUsuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            Seguridad.Inicial(idUsuairo);
            _usuario = Usuario.colUsuarios.get(idUsuairo);
            $('#usuarioSelec').html('<small>Seguridad - </small>' + _usuario.attributes.NombreCompleto);
        });
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Usuario/Nuevo"; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-usuario').html(data);
            $('#nuevo-usuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Usuario.CargarColeccionDepartamentos('#NuevoUsuarioForm');
            Usuario.CargarColeccionProcesos('#NuevoUsuarioForm');
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Usuario/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-usuario').html(data);
            $('#actualiza-usuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Usuario.CargarColeccionDepartamentos('#ActualizaUsuarioForm');
            Usuario.CargarColeccionProcesos('#ActualizaUsuarioForm');
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Usuario/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                Usuario.colUsuarios.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el usuario post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Usuario/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-usuario').html(data);
            $('#nuevo-usuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Usuario.CargarColeccionDepartamentos('#NuevoUsuarioForm');
            Usuario.CargarColeccionProcesos('#NuevoUsuarioForm');
        });
    },
    ValidaNomUsuario: function () {
            var that = $(this);
            var idUsuario = $('#id').val() !== undefined ? $('#id').val() : -1;
            var urlValida = contextPath + 'Usuario/ValidaLoginUsuario?loginUsuario=' + $(this).val() + '&idUsuario=' + idUsuario;
            $.getJSON(urlValida, function (data) {
                if (data.result === true) {
                    CMI.DespliegaErrorDialogo('El nombre de usuario ya existe en base de datos.');
                    that.val('');
                }
                else {
                    if (data.Message !== undefined) { CMI.DespliegaErrorDialogo(data.Message); }
                }
            });
    },
    CargarColeccionDepartamentos: function (form) {
        if (Usuario.colDepartamentos.length < 1) {
            var url = contextPath + "Departamento/CargaDepartamentos/1"; // El url del controlador
            $.getJSON(url, function (data) {
                Usuario.colDepartamentos = data;
                Usuario.CargaListaDepartamentos(form);
            }).fail(function () {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Departamentos");
            });
        } else {
            Usuario.CargaListaDepartamentos(form);
        }
    },
    CargaListaDepartamentos: function (form) {
        var select = $(form + ' #idDepartamento').empty();
        // constructs the suggestion engine 
        select.append('<option> </option>');

        $.each(Usuario.colDepartamentos, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.Nombre
                                 + '</option>');
        });

        $(form + ' #idDepartamento').val($(form + ' #departamento').val());
        //Inicializa el combo para que pueda hacer busquedas
        $(form + " .select2").select2({  allowClear: true, placeholder: 'Departamento' });
    },
    CargarColeccionProcesos: function (form) {
        if (Usuario.colProcesos.length < 1) {
            var url = contextPath + "Proceso/CargaProcesosActivos"; // 1 indica que solo activos
            $.getJSON(url, function (data) {
                Usuario.colProcesos = data;
                Usuario.CargaListaProcesos(form);
            }).fail(function () {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los procesos");
            });
        } else {
            Usuario.CargaListaProcesos(form);
        }
    },
    CargaListaProcesos: function (form) {
        var optionItem = '',
            selectDestino = $(form + ' #idProcesoDestino').empty(),
            selectOrigen = $(form + ' #idProcesoOrigen').empty();

        $.each(Usuario.colProcesos, function (i, item) {
            optionItem = '<option value="' + item.id + '">'
                                     + item.nombreProceso + '</option>';
            selectDestino.append(optionItem);
            selectOrigen.append(optionItem);
        });

        $(form + ' #idProcesoOrigen').val($(form + ' #origen').val());
        $(form + ' #idProcesoDestino').val($(form + ' #destino').val());
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = Usuario;
        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();
       
        if (localStorage.modSerdad !== null) {
            modulo.accSeguridad = localStorage.modSerdad.substr(0, 1) === '1' ? true : false;
        }
    },
    serializaUsuario: function (id, form) {
        return ({
            'fechaCreacion': $(form + ' #fechaCreacion').val(),
            'Correo': $(form + ' #Correo').val().toUpperCase(),
            'nombreEstatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'NombreCompleto': $(form + ' #Nombre').val().toUpperCase() + ' ' +
                      $(form + ' #ApePaterno').val().toUpperCase() + ' ' +
                      $(form + ' #ApeMaterno').val().toUpperCase(),
            'NombreUsuario': $(form + ' #NombreUsuario').val().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Usuario/CargaUsuarios"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Usuario.colUsuarios = new Backbone.Collection(data);
            var bolFilter = Usuario.colUsuarios.length > 0 ? true : false;
            if (bolFilter) {
                Usuario.gridUsuarios = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Usuario.accClonar,
                    editar: Usuario.accEscritura,
                    borrar: Usuario.accBorrar,
                    collection: Usuario.colUsuarios,
                    seguridad: Usuario.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Usuario', name: 'NombreUsuario', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'NombreCompleto', filter: true, filterType: 'input' },
                               { title: 'Correo', name: 'Correo', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'fechaCreacion', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Usuarios registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }           
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de los usuario");
        });
    }
};

$(function () {
    Usuario.Inicial();
});