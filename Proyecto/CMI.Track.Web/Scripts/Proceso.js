//js de catalogo de Proceso
//Juan Lopepe
//01/Febrero/2016

var Proceso = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colProcesos: {},
    colTiposProceso: [],
    gridProcesos: {},
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
        $(document).on("click", '.btn-ActualizarProceso', that.onActualizar);

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
            $.post(contextPath + "Proceso/Nuevo",
                $("#NuevoProcesoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Proceso.colProcesos.add(Proceso.serializaProceso(data.id, '#NuevoProcesoForm'));
                        CMI.DespliegaInformacion('El Proceso fue guardado con el Id: ' + data.id);
                        $('#nuevo-Proceso').modal('hide');
                        if (Proceso.colProcesos.length === 1) {
                            Proceso.CargaGrid();
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
            $.post(contextPath + "Proceso/Actualiza",
                $("#ActualizaProcesoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-Proceso').modal('hide');
                        Proceso.colProcesos.add(Proceso.serializaProceso(data.id, '#ActualizaProcesoForm'), { merge: true });
                        CMI.DespliegaInformacion('El Proceso fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "Proceso/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-Proceso').html(data);
            $('#nuevo-Proceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proceso.CargarColeccionTiposProceso('#NuevoProcesoForm');
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Proceso/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Proceso').html(data);
            $('#actualiza-Proceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proceso.CargarColeccionTiposProceso('#ActualizaProcesoForm');
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Proceso/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Proceso.colProcesos.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Proceso post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Proceso/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Proceso').html(data);
            $('#actualiza-Proceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Proceso.CargarColeccionTiposProceso('#NuevoProcesoForm');
        });

    },
    CargarColeccionTiposProceso: function (form) {
        if (Proceso.colTiposProceso.length < 1) {
            var url = contextPath + "TipoProceso/CargaTiposProcesoActivos"; // El url del controlador
            $.getJSON(url, function (data) {
                Proceso.colTiposProceso = data;
                Proceso.CargaListaTiposProceso(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Tipos de Proceso");
            });
        } else {
            Proceso.CargaListaTiposProceso(form);
        }
    },
    CargaListaTiposProceso: function (form) {
        var select = $(form + ' #idTipoProceso').empty();

        select.append('<option> </option>');

        $.each(Proceso.colTiposProceso, function (i, item) {
            select.append('<option value="' + item.id + '">' + item.NombreTipoProceso + '</option>');
        });

        $(form + ' #idTipoProceso').val($(form + ' #tipoproceso').val());
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            item;
        Proceso.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        Proceso.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        Proceso.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (Proceso.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaProceso: function (id,form) {
        return ({
            'nombreProceso': $(form + ' #nombreProceso').val().toUpperCase(),
            'idTipoProceso': $(form + ' #idTipoProceso').val(),
            'estatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Proceso/CargaProcesos"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Proceso.colProcesos = new Backbone.Collection(data);
            var bolFilter = Proceso.colProcesos.length > 0 ? true : false;
            if (bolFilter) {
                gridProcesos = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Proceso.accClonar,
                    editar: Proceso.accEscritura,
                    borrar: Proceso.accBorrar,
                    collection: Proceso.colProcesos,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proceso', name: 'nombreProceso', filter: true, filterType: 'input' },
                               { title: 'TipoProceso', name: 'nombreTipoProceso', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Procesos registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Procesos");
        });
    }
};

$(function () {
    Proceso.Inicial();
});