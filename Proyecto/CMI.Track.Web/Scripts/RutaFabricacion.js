//js de catalogo de RutaFabricacion
//Juan Lopepe
//01/Febrero/2016

var RutaFabricacion = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colRutasFabricacion: {},
    colCategorias: [],
    colProcesos: [],
    gridRutasFabricacion: {},
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
        $(document).on("click", '.btn-ActualizarRutaFabricacion', that.onActualizar);

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
    onGuardar: function (e) {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "RutaFabricacion/Nuevo",
                $("#NuevoRutaFabricacionForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        RutaFabricacion.colRutasFabricacion.add(RutaFabricacion.serializaRutaFabricacion(data.id, '#NuevoRutaFabricacionForm'));
                        CMI.DespliegaInformacion('La Ruta de Fabricacion fue guardads con el Id: ' + data.id);
                        $('#nuevo-RutaFabricacion').modal('hide');
                        if (RutaFabricacion.colRutasFabricacion.length === 1) {
                            RutaFabricacion.CargaGrid();
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
    onActualizar: function (e) {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "RutaFabricacion/Actualiza",
                $("#ActualizaRutaFabricacionForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-RutaFabricacion').modal('hide');
                        RutaFabricacion.colRutasFabricacion.add(RutaFabricacion.serializaRutaFabricacion(data.id, '#ActualizaRutaFabricacionForm'), { merge: true });
                        CMI.DespliegaInformacion('La Ruta de Fabricacion fue Actualizada. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al actualizar la informacion"); 
                }).always(function () { CMI.botonMensaje(false, btn, 'Actualizar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Actualizar');
        }
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "RutaFabricacion/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-RutaFabricacion').html(data);
            $('#nuevo-RutaFabricacion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            RutaFabricacion.CargarColeccionCategorias('#NuevoRutaFabricacionForm');
            RutaFabricacion.CargarColeccionProcesos('#NuevoRutaFabricacionForm');
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "RutaFabricacion/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-RutaFabricacion').html(data);
            $('#actualiza-RutaFabricacion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            RutaFabricacion.CargarColeccionCategorias('#ActualizaRutaFabricacionForm');
            RutaFabricacion.CargarColeccionProcesos('#ActualizaRutaFabricacionForm');
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "RutaFabricacion/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                RutaFabricacion.colRutasFabricacion.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la Ruta de Fabricacion post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "RutaFabricacion/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-RutaFabricacion').html(data);
            $('#actualiza-RutaFabricacion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            RutaFabricacion.CargarColeccionCategorias('#ActualizaRutaFabricacionForm');
            RutaFabricacion.CargarColeccionProcesos('#ActualizaRutaFabricacionForm');
        });

    },
    CargarColeccionCategorias: function (form) {
        if (RutaFabricacion.colCategorias.length < 1) {
            var url = contextPath + "Categoria/CargaCategoriasActivas"; // El url del controlador
            $.getJSON(url, function (data) {
                RutaFabricacion.colCategorias = data;
                RutaFabricacion.CargaListaCategorias(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Categorias");
            });
        } else {
            RutaFabricacion.CargaListaCategorias(form);
        }
    },
    CargaListaCategorias: function (form) {
        var select = $(form + ' #idCategoria').empty();

        select.append('<option> </option>');

        $.each(RutaFabricacion.colCategorias, function (i, item) {
            select.append('<option value="' + item.id + '">' + item.NombreCategoria + '</option>');
        });

        $(form + ' #idCategoria').val($(form + ' #categoria').val());
    },
    CargarColeccionProcesos: function (form) {
        if (RutaFabricacion.colProcesos.length < 1) {
            var url = contextPath + "Proceso/CargaProcesosActivos"; // El url del controlador
            $.getJSON(url, function (data) {
                RutaFabricacion.colProcesos = data;
                RutaFabricacion.CargaListaProcesos(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Procesos");
            });
        } else {
            RutaFabricacion.CargaListaProcesos(form);
        }
    },
    CargaListaProcesos: function (form) {
        var select = $(form + ' #idProceso').empty();

        select.append('<option> </option>');

        $.each(RutaFabricacion.colProcesos, function (i, item) {
            select.append('<option value="' + item.id + '">' + item.nombreProceso + '</option>');
        });

        $(form + ' #idProceso').val($(form + ' #proceso').val());
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            item;
        RutaFabricacion.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        RutaFabricacion.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        RutaFabricacion.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (RutaFabricacion.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaRutaFabricacion: function (id,form) {
        return ({
            'nombreCategoria': $(form + ' #idCategoria option:selected').text().toUpperCase(),
            'secuencia': $(form + ' #secuencia').val(),
            'nombreProceso': $(form + ' #idProceso option:selected').text().toUpperCase(),
            'estatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "RutaFabricacion/CargaRutasFabricacion"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            RutaFabricacion.colRutasFabricacion = new Backbone.Collection(data);
            var bolFilter = RutaFabricacion.colRutasFabricacion.length > 0 ? true : false;
            if (bolFilter) {
                gridRutasFabricacion = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: RutaFabricacion.accClonar,
                    editar: RutaFabricacion.accEscritura,
                    borrar: RutaFabricacion.accBorrar,
                    collection: RutaFabricacion.colRutasFabricacion,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Categoria', name: 'nombreCategoria', filter: true, filterType: 'input' },
                               { title: 'Secuencia', name: 'secuencia', filter: true, filterType: 'input'},
                               { title: 'Proceso', name: 'nombreProceso', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Rutas de Fabricacion registradas");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las Rutas de Fabricacion");
        });
    }
};

$(function () {
    RutaFabricacion.Inicial();
});