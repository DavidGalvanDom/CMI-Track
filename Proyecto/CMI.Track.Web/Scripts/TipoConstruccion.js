//js de catalogo de tipos de construccion.
//David Jasso
//02/Febrero/2016

var TipoConstruccion = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colTiposConstruccion: {},
    gridTiposConstruccion: {},
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
        $(document).on("click", '.btn-ActualizarTipoConstruccion', that.onActualizar);

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
            $.post(contextPath + "TipoConstruccion/Nuevo",
                $("#NuevoTipoConstruccionForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        TipoConstruccion.colTiposConstruccion.add(TipoConstruccion.serializaTipoConstruccion(data.id,'#NuevoTipoConstruccionForm'));
                        CMI.DespliegaInformacion('El Tipo de construccion fue guardado con el Id: ' + data.id);
                        $('#nuevo-tipoconstruccion').modal('hide');
                        if (TipoConstruccion.colTiposConstruccion.length === 1) {
                            TipoConstruccion.CargaGrid();
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
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "TipoConstruccion/Actualiza",
                $("#ActualizaTipoConstruccionForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-tipoconstruccion').modal('hide');
                        TipoConstruccion.colTiposConstruccion.add(TipoConstruccion.serializaTipoConstruccion(data.id, '#ActualizaTipoConstruccionForm'), { merge: true });
                        CMI.DespliegaInformacion('El Tipo de construccion fue Actualizado. Id:' + data.id);
                    } else {
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
        var url = contextPath + "TipoConstruccion/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-tipoconstruccion').html(data);           
            $('#nuevo-tipoconstruccion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "TipoConstruccion/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-tipoconstruccion').html(data);
            $('#actualiza-tipoconstruccion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "TipoConstruccion/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                TipoConstruccion.colTiposConstruccion.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el tipo de cosntruccion post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "TipoConstruccion/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-tipoconstruccion').html(data);
            $('#nuevo-tipoconstruccion').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = TipoConstruccion;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaTipoConstruccion: function (id,form) {
        return ({
            'NombreTipoConstruccion': $(from + ' #NombreTipoConstruccion').val().toUpperCase(),
            'Estatus': $(from + ' #Estatus').val(),
            'id': id
        });
        
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "TipoConstruccion/CargaTiposConstruccion"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            TipoConstruccion.colTiposConstruccion = new Backbone.Collection(data);
            var bolFilter = TipoConstruccion.colTiposConstruccion.length > 0 ? true : false;
            if (bolFilter) {
                gridTiposConstruccion = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: TipoConstruccion.accClonar,
                    editar: TipoConstruccion.accEscritura,
                    borrar: TipoConstruccion.accBorrar,
                    collection: TipoConstruccion.colTiposConstruccion,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Tipo Construccion', name: 'NombreTipoConstruccion', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Tipos de construccion registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los tipos de construccion");
        });
    }
};


$(function () {
    TipoConstruccion.Inicial();
});