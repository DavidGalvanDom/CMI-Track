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

        $('.btnNuevo').show();
    },
    Eventos: function () {
        var that = this;
        $('.btnNuevo').click(that.Nuevo);                
        $(document).on("click", '.btn-GuardaNuevo', that.onSubirArchivo);
        $(document).on("click", '.btn-ActualizarProyecto', that.onActualizar);
        
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
            $('#ProyectoCreacion').val(localStorage.idUser);
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
    onActualizar: function (e) {
        var btn = this;
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
        var files = document.getElementById('fPlano').files,
            btn = this,
            form = Proyecto.activeForm;

        //Agrega la clase de mandatorio cuando no ha seleccionado un cliente.
        if ($(form + ' #idCliente').val() === "0") {
            $(form + ' #nombreCliente').addClass('input-validation-error');
        }

        if ($("form").valid()) { 
            CMI.botonMensaje(true, btn, 'Guardar');
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
                            Proyecto.onGuardar(btn);
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

            $('#btnBuscarCliente').click(Proyecto.onBuscarCliente);
            Proyecto.activeForm = '#NuevoProyectoForm';
            Proyecto.EventoNombreArchivo();
            Proyecto.IniciaDateControls();
            Proyecto.CargarColeccionCategorias();            
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Proyecto').html(data);
            $('#actualiza-Proyecto').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proyecto.activeForm = '#ActualizaProyectoForm';
            Proyecto.EventoNombreArchivo();
            Proyecto.CargarColeccionCategorias();
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Proyecto/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Proyecto.colProyectos.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Proyecto post Borrar"); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-Proyecto').html(data);
            $('#nuevo-Proyecto').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proyecto.activeForm = '#NuevoProyectoForm';
            Proyecto.CargarColeccionCategorias();
            Proyecto.CargarColeccionClientes();
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
    CargarColeccionClientes: function () {
        var form = Proyecto.activeForm;
        if (Proyecto.colProcesos.length < 1) {
            var url = contextPath + "Proceso/CargaProceso/1"; // 1 indica que solo activos
            $.getJSON(url, function (data) {
                Proyecto.colProcesos = data;
                Proyecto.CargaListaProcesos(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los procesos");
            });
        } else {
            Proyecto.CargaListaProcesos(form);
        }
    },
    CargaListaProcesos: function (form) {
        var optionItem = '<option> </option>',
            selectDestino = $(form + ' #idProcesoDestino').empty(),
            selectOrigen = $(form + ' #idProcesoOrigen').empty();

        selectDestino.append(optionItem);
        selectOrigen.append(optionItem);

        $.each(Proyecto.colDepartamentos, function (i, item) {
            optionItem = '<option value="' + item.id + '">'
                                     + item.Nombre + '</option>';
            selectDestino.append(optionItem);
            selectOrigen.append(optionItem);
        });
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
        return ({
            'fechaCreacion': $('#fechaCreacion').val(),
            'Correo': $('#Correo').val().toUpperCase(),
            'idEstatus': $('#idEstatus').val(),
            'NombreCompleto': $('#Nombre').val().toUpperCase() + ' ' +
                      $('#ApePaterno').val().toUpperCase() + ' ' +
                      $('#ApeMaterno').val().toUpperCase(),
            'NombreProyecto': $('#NombreProyecto').val().toUpperCase(),
            'id': id
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
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Proyecto', name: 'NombreProyecto', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'NombreCompleto', filter: true, filterType: 'input' },
                               { title: 'Correo', name: 'Correo', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'fechaCreacion', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'idEstatus', filter: true }]
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