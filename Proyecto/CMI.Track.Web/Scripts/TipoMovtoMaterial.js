//js de catalogo de tipos de movimientos de material.
//David Jasso
//02/Febrero/2016

var TipoMovtoMaterial = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colTiposMovtoMaterial: {},
    gridTiposMovtoMaterial: {},
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
        $(document).on("click", '.btn-ActualizarTipoMovtoMaterial', that.onActualizar);

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
            $.post(contextPath + "TipoMovtoMaterial/Nuevo",
                $("#NuevoTipoMovtoMaterialForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        TipoMovtoMaterial.colTiposMovtoMaterial.add(TipoMovtoMaterial.serializaTipoMovtoMaterial(data.id));
                        CMI.DespliegaInformacion('El Tipo de movimiento de material fue guardado con el Id: ' + data.id);
                        $('#nuevo-tipomovtomaterial').modal('hide');
                        if (TipoMovtoMaterial.colTiposMovtoMaterial.length === 1) {
                            TipoMovtoMaterial.CargaGrid();
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
            $.post(contextPath + "TipoMovtoMaterial/Actualiza",
                $("#ActualizaTipoMovtoMaterialForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-tipomovtomaterial').modal('hide');
                        TipoMovtoMaterial.colTiposMovtoMaterial.add(TipoMovtoMaterial.serializaTipoMovtoMaterial(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Tipo de Movimiento de Material fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "TipoMovtoMaterial/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-tipomovtomaterial').html(data);           
            $('#nuevo-tipomovtomaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "TipoMovtoMaterial/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-tipomovtomaterial').html(data);
            $('#actualiza-tipomovtomaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "TipoMovtoMaterial/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                TipoMovtoMaterial.colTiposMovtoMaterial.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el tipo de movimiento de material post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "TipoMovtoMaterial/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-tipomovtomaterial').html(data);
            $('#nuevo-tipomovtomaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos;

        var modulo = TipoMovtoMaterial;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;

        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;

        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;



        if (modulo.accEscritura === true)

            $('.btnNuevo').show();

    },
    serializaTipoMovtoMaterial: function (id) {
        return ({
            'NombreTipoMovtoMaterial': $('#NombreTipoMovtoMaterial').val().toUpperCase(),
            'TipoMovimiento': $('#TipoMovimiento').val().toUpperCase(),
            'Estatus': $('#Estatus').val(),
            'id': id
        });
        
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "TipoMovtoMaterial/CargaTiposMovtoMaterial"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            TipoMovtoMaterial.colTiposMovtoMaterial = new Backbone.Collection(data);
            var bolFilter = TipoMovtoMaterial.colTiposMovtoMaterial.length > 0 ? true : false;
            if (bolFilter) {
                gridTiposMovtoMaterial = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: TipoMovtoMaterial.accClonar,
                    editar: TipoMovtoMaterial.accEscritura,
                    borrar: TipoMovtoMaterial.accBorrar,
                    collection: TipoMovtoMaterial.colTiposMovtoMaterial,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Tipo Movimiento', name: 'NombreTipoMovtoMaterial', filter: true, filterType: 'input' },
                               { title: 'Tipo Movimiento', name: 'TipoMovimiento', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Tipos de Movimientos de Materiales registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los tipos de movimeintos de material");
        });
    }
};


$(function () {
    TipoMovtoMaterial.Inicial();
});