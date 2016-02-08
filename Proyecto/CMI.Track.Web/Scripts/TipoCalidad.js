//js de catalogo de Tipo de Calidad
//Juan Lopepe
//01/Febrero/2016

var TipoCalidad = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colTiposCalidad: {},
    gridTiposCalidad: {},
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
        $(document).on("click", '.btn-ActualizarTipoCalidad', that.onActualizar);

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

        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "TipoCalidad/Nuevo",
                $("#NuevoTipoCalidadForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        TipoCalidad.colTiposCalidad.add(TipoCalidad.serializaTipoCalidad(data.id));
                        CMI.DespliegaInformacion('El Tipo de Calidad fue guardado con el Id: ' + data.id);
                        $('#nuevo-TipoCalidad').modal('hide');
                        if (TipoCalidad.colTiposCalidad.length === 1) {
                            TipoCalidad.CargaGrid();
                        }
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al guardar la informacion"); });
        }       
    },
    onActualizar: function (e) {
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "TipoCalidad/Actualiza",
                $("#ActualizaTipoCalidadForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-TipoCalidad').modal('hide');
                        TipoCalidad.colTiposCalidad.add(TipoCalidad.serializaTipoCalidad(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Tipo de Calidad fue Actualizado. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al actualizar la informacion"); });
        }   
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "TipoCalidad/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-TipoCalidad').html(data);
            $('#nuevo-TipoCalidad').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "TipoCalidad/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-TipoCalidad').html(data);
            $('#actualiza-TipoCalidad').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "TipoCalidad/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                TipoCalidad.colTiposCalidad.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Tipo de Calidad post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "TipoCalidad/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-TipoCalidad').html(data);
            $('#actualiza-TipoCalidad').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        TipoCalidad.accEscritura = true;
        TipoCalidad.accClonar = true;
        TipoCalidad.accBorrar = true;

        if (TipoCalidad.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaTipoCalidad: function (id) {
        return ({
            'nombreTipoCalidad': $('#nombreTipoCalidad').val().toUpperCase(),
            'estatus': $('#estatus').val(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "TipoCalidad/CargaTiposCalidad"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            TipoCalidad.colTiposCalidad = new Backbone.Collection(data);
            var bolFilter = TipoCalidad.colTiposCalidad.length > 0 ? true : false;
            if (bolFilter) {
                gridTiposCalidad = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: TipoCalidad.accClonar,
                    editar: TipoCalidad.accEscritura,
                    borrar: TipoCalidad.accBorrar,
                    collection: TipoCalidad.colTiposCalidad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Tipo Calidad', name: 'nombreTipoCalidad', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Tipos de Calidad registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Tipos de Calidad");
        });
    }
};


$(function () {
    TipoCalidad.Inicial();
});