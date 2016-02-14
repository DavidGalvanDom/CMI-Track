//js de catalogo de Tipos de Material.
//Juan Lopepe
//01/Febrero/2016

var TipoMaterial = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colTiposMaterial: {},
    gridTiposMaterial: {},
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
        $(document).on("click", '.btn-ActualizarTipoMaterial', that.onActualizar);

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
            $.post(contextPath + "TipoMaterial/Nuevo",
                $("#NuevoTipoMaterialForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        TipoMaterial.colTiposMaterial.add(TipoMaterial.serializaTipoMaterial(data.id, '#NuevoTipoMaterialForm'));
                        CMI.DespliegaInformacion('El Tipo de Material fue guardado con el Id: ' + data.id);
                        $('#nuevo-TipoMaterial').modal('hide');
                        if (TipoMaterial.colTiposMaterial.length === 1) {
                            TipoMaterial.CargaGrid();
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
            $.post(contextPath + "TipoMaterial/Actualiza",
                $("#ActualizaTipoMaterialForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-TipoMaterial').modal('hide');
                        TipoMaterial.colTiposMaterial.add(TipoMaterial.serializaTipoMaterial(data.id, '#ActualizaTipoMaterialForm'), { merge: true });
                        CMI.DespliegaInformacion('El Tipo de Material fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "TipoMaterial/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-TipoMaterial').html(data);
            $('#nuevo-TipoMaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "TipoMaterial/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-TipoMaterial').html(data);
            $('#actualiza-TipoMaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "TipoMaterial/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                TipoMaterial.colTiposMaterial.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Tipo de Material post Borrar"); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "TipoMaterial/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-TipoMaterial').html(data);
            $('#actualiza-TipoMaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
                    item;
        TipoMaterial.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        TipoMaterial.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        TipoMaterial.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (TipoMaterial.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaTipoMaterial: function (id, form) {
        return ({
            'nombreTipoMaterial': $(form + ' #nombreTipoMaterial').val().toUpperCase(),
            'estatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "TipoMaterial/CargaTiposMaterial"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            TipoMaterial.colTiposMaterial = new Backbone.Collection(data);
            var bolFilter = TipoMaterial.colTiposMaterial.length > 0 ? true : false;
            if (bolFilter) {
                gridTiposMaterial = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: TipoMaterial.accClonar,
                    editar: TipoMaterial.accEscritura,
                    borrar: TipoMaterial.accBorrar,
                    collection: TipoMaterial.colTiposMaterial,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreTipoMaterial', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Tipos de Material registradas");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Tipos de Material");
        });
    }
};

$(function () {
    TipoMaterial.Inicial();
});