/*global $, jQuery, CMI, Backbone, bbGrid*/
//js de catalogo de Almacen
//Juan Lopepe
//01/Febrero/2016
var Almacen = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colAlmacenes: {},
    gridAlmacenes: {},
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
        $(document).on("click", '.btn-ActualizarAlmacen', that.onActualizar);

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
    onGuardar: function () {
        var btn = this;
       
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Almacen/Nuevo",
                $("#NuevoAlmacenForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        Almacen.colAlmacenes.add(Almacen.serializaAlmacen(data.id, '#NuevoAlmacenForm'));
                        CMI.DespliegaInformacion('El Almacen fue guardado con el Id: ' + data.id);
                        $('#nuevo-Almacen').modal('hide');
                        if (Almacen.colAlmacenes.length === 1) {
                            Almacen.CargaGrid();
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
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Almacen/Actualiza",
                $("#ActualizaAlmacenForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        $('#actualiza-Almacen').modal('hide');
                        Almacen.colAlmacenes.add(Almacen.serializaAlmacen(data.id, '#ActualizaAlmacenForm'), { merge: true });
                        CMI.DespliegaInformacion('El Almacen fue Actualizado. Id:' + data.id);
                    } else {
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
        var url = contextPath + "Almacen/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-Almacen').html(data);
            $('#nuevo-Almacen').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Almacen/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Almacen').html(data);
            $('#actualiza-Almacen').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Almacen/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                Almacen.colAlmacenes.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Almacen post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Almacen/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Almacen').html(data);
            $('#actualiza-Almacen').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos;
        Almacen.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        Almacen.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        Almacen.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (Almacen.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaAlmacen: function (id, form) {
        return ({
            'nombreAlmacen': $(form + ' #nombreAlmacen').val().toUpperCase(),
            'estatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Almacen/CargaAlmacenes"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Almacen.colAlmacenes = new Backbone.Collection(data);
            var bolFilter = Almacen.colAlmacenes.length > 0 ? true : false;
            if (bolFilter) {
                Almacen.gridAlmacenes = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Almacen.accClonar,
                    editar: Almacen.accEscritura,
                    borrar: Almacen.accBorrar,
                    collection: Almacen.colAlmacenes,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Almacen', name: 'nombreAlmacen', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Almacenes registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de los Almacenes");
        });
    }
};

$(function () {
    Almacen.Inicial();
});