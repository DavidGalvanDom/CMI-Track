//js de catalogo de origenes.
//David Jasso
//02/Febrero/2016

var OrigenReq = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colOrigenesReq: {},
    gridOrigenesReq: {},
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
        $(document).on("click", '.btn-ActualizarOrigenRequisicion', that.onActualizar);

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
            $.post(contextPath + "OrigenRequisicion/Nuevo",
                $("#NuevoOrigenRequisicionForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        OrigenReq.colOrigenesReq.add(OrigenReq.serializaOrigenRequisicion(data.id, '#NuevoOrigenRequisicionForm'));
                        CMI.DespliegaInformacion('El Origen Requisicion fue guardado con el Id: ' + data.id);
                        $('#nuevo-origenrequisicion').modal('hide');
                        if (OrigenReq.colOrigenesReq.length === 1) {
                            OrigenReq.CargaGrid();
                        }
                    }
                    else {
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

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "OrigenRequisicion/Actualiza",
                $("#ActualizaOrigenRequisicionForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-origenrequisicion').modal('hide');
                        OrigenReq.colOrigenesReq.add(OrigenReq.serializaOrigenRequisicion(data.id, '#ActualizaOrigenRequisicionForm'), { merge: true });
                        CMI.DespliegaInformacion('El origen fue Actualizado. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al actualizar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });

        } else {

            CMI.botonMensaje(false, btn, 'Guardar');

        
        
        }   
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "OrigenRequisicion/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-origenrequisicion').html(data);
            $('#nuevo-origenrequisicion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "OrigenRequisicion/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-origenrequisicion').html(data);
            $('#actualiza-origenrequisicion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "OrigenRequisicion/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                OrigenReq.colOrigenesReq.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el origen post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "OrigenRequisicion/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-origenrequisicion').html(data);
            $('#nuevo-origenrequisicion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = OrigenReq;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaOrigenRequisicion: function (id, form) {
        return ({
            'NombreOrigenRequisicion': $(form + ' #NombreOrigenRequisicion').val().toUpperCase(),
            'Estatus': $(form + ' #Estatus').val(),
            'id': id
        });
        
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "OrigenRequisicion/CargaOrigenesRequisicion"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            OrigenReq.colOrigenesReq = new Backbone.Collection(data);
            var bolFilter = OrigenReq.colOrigenesReq.length > 0 ? true : false;
            if (bolFilter) {
                gridOrigenesReq = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: OrigenReq.accClonar,
                    editar: OrigenReq.accEscritura,
                    borrar: OrigenReq.accBorrar,
                    collection: OrigenReq.colOrigenesReq,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Origen Requisicion', name: 'NombreOrigenRequisicion', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Origenes registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Origenes");
        });
    }
};


$(function () {
    OrigenReq.Inicial();
});