//js de catalogo de Unidades de Medida.
//Juan Lopepe
//01/Febrero/2016

var UnidadMedida = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colUnidadesMedida: {},
    gridUnidadesMedida: {},
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
        $(document).on("click", '.btn-ActualizarUnidadMedida', that.onActualizar);

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
            $.post(contextPath + "UnidadMedida/Nuevo",
                $("#NuevoUnidadMedidaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        UnidadMedida.colUnidadesMedida.add(UnidadMedida.serializaUnidadMedida(data.id));
                        CMI.DespliegaInformacion('La Unidad de Medida fue guardada con el Id: ' + data.id);
                        $('#nuevo-UnidadMedida').modal('hide');
                        if (UnidadMedida.colUnidadesMedida.length === 1) {
                            UnidadMedida.CargaGrid();
                        }
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al guardar la informacion"); 
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        }
        else {
            CMI.botonMensaje(false, btn, 'Guardar');
        }
    },
    onActualizar: function (e) {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "UnidadMedida/Actualiza",
                $("#ActualizaUnidadMedidaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-UnidadMedida').modal('hide');
                        UnidadMedida.colUnidadesMedida.add(UnidadMedida.serializaUnidadMedida(data.id), { merge: true });
                        CMI.DespliegaInformacion('La Unidad de Medida fue Actualizada. Id:' + data.id);
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
        var url = contextPath + "UnidadMedida/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-UnidadMedida').html(data);
            $('#nuevo-UnidadMedida').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "UnidadMedida/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-UnidadMedida').html(data);
            $('#actualiza-UnidadMedida').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "UnidadMedida/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                UnidadMedida.colUnidadesMedida.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la Unidad de Medida post Borrar"); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "UnidadMedida/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-UnidadMedida').html(data);
            $('#actualiza-UnidadMedida').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            item;
        UnidadMedida.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        UnidadMedida.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        UnidadMedida.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (UnidadMedida.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaUnidadMedida: function (id) {
        return ({
            'nombreCortoUnidadMedida': $('#nombreCortoUnidadMedida').val().toUpperCase(),
            'nombreUnidadMedida': $('#nombreUnidadMedida').val().toUpperCase(),
            'estatus': $('#idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "UnidadMedida/CargaUnidadesMedida"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            UnidadMedida.colUnidadesMedida = new Backbone.Collection(data);
            var bolFilter = UnidadMedida.colUnidadesMedida.length > 0 ? true : false;
            if (bolFilter) {
                gridUnidadesMedida = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: UnidadMedida.accClonar,
                    editar: UnidadMedida.accEscritura,
                    borrar: UnidadMedida.accBorrar,
                    collection: UnidadMedida.colUnidadesMedida,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Corto', name: 'nombreCortoUnidadMedida', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreUnidadMedida', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Unidades de Medida registradas");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las Unidades de Medida");
        });
    }
};


$(function () {
    UnidadMedida.Inicial();
});