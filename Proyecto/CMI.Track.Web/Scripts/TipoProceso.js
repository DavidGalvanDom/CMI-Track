//js de catalogo de tipos de proceso.
//David Jasso
//02/Febrero/2016

var TipoProceso = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colTiposProceso: {},
    gridTiposProceso: {},
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
        $(document).on("click", '.btn-ActualizarTipoProceso', that.onActualizar);

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
            $.post(contextPath + "TipoProceso/Nuevo",
                $("#NuevoTipoProcesoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        TipoProceso.colTiposProceso.add(TipoProceso.serializaTipoProceso(data.id, '#NuevoTipoProcesoForm'));
                        CMI.DespliegaInformacion('El Tipo de proceso fue guardado con el Id: ' + data.id);
                        $('#nuevo-tipoproceso').modal('hide');
                        if (TipoProceso.colTiposProceso.length === 1) {
                            TipoProceso.CargaGrid();
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
            $.post(contextPath + "TipoProceso/Actualiza",
                $("#ActualizaTipoProcesoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-tipoproceso').modal('hide');
                        TipoProceso.colTiposProceso.add(TipoProceso.serializaTipoProceso(data.id, '#ActualizaTipoProcesoForm'), { merge: true });
                        CMI.DespliegaInformacion('El Tipo de proceso fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "TipoProceso/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-tipoproceso').html(data);           
            $('#nuevo-tipoproceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "TipoProceso/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-tipoproceso').html(data);
            $('#actualiza-tipoproceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "TipoProceso/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                TipoProceso.colTiposProceso.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el tipo de proceso post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "TipoProceso/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-tipoproceso').html(data);
            $('#nuevo-tipoproceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = TipoProceso;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaTipoProceso: function (id, form) {
        return ({
            'NombreTipoProceso': $(form + ' #NombreTipoProceso').val().toUpperCase(),
            'Estatus': $(form + ' #Estatus').val(),
            'id': id
        });
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "TipoProceso/CargaTiposProceso"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            TipoProceso.colTiposProceso = new Backbone.Collection(data);
            var bolFilter = TipoProceso.colTiposProceso.length > 0 ? true : false;
            if (bolFilter) {
                gridTiposProceso = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: TipoProceso.accClonar,
                    editar: TipoProceso.accEscritura,
                    borrar: TipoProceso.accBorrar,
                    collection: TipoProceso.colTiposProceso,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Tipo Proceso', name: 'NombreTipoProceso', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Tipos de proceso registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los tipos de proceso");
        });
    }
};


$(function () {
    TipoProceso.Inicial();
});