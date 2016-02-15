//js de catalogo de CalidadProceso
//Juan Lopepe
//01/Febrero/2016

var CalidadProceso = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colCalidadesProceso: {},
    colTiposCalidad: [],
    colProcesos: [],
    gridCalidadesProceso: {},
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
        $(document).on("click", '.btn-ActualizarCalidadProceso', that.onActualizar);

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
            $.post(contextPath + "CalidadProceso/Nuevo",
                $("#NuevoCalidadProcesoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        CalidadProceso.colCalidadesProceso.add(CalidadProceso.serializaCalidadProceso(data.id, '#NuevoCalidadProcesoForm'));
                        CMI.DespliegaInformacion('La Relacion Calidad Proceso fue guardada con exito ');
                        $('#nuevo-CalidadProceso').modal('hide');
                        if (CalidadProceso.colCalidadesProceso.length === 1) {
                            CalidadProceso.CargaGrid();
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
            $.post(contextPath + "CalidadProceso/Actualiza",
                $("#ActualizaCalidadProcesoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-CalidadProceso').modal('hide');
                        CalidadProceso.colCalidadesProceso.add(CalidadProceso.serializaCalidadProceso(data.id, '#ActualizaCalidadProcesoForm'), { merge: true });
                        CMI.DespliegaInformacion('La Relacion Calidad Proceso fue Actualizada con exito ');
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
        var url = contextPath + "CalidadProceso/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-CalidadProceso').html(data);
            $('#nuevo-CalidadProceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            CalidadProceso.CargarColeccionTiposCalidad('#NuevoCalidadProcesoForm');
            CalidadProceso.CargarColeccionProcesos('#NuevoCalidadProcesoForm');
        });
    },
    Editar: function (idRow) {
        var idProceso, idTipoCalidad, row;
        CMI.CierraMensajes();
        //Se toma de la colleccion el renglon seleccionado
        row = CalidadProceso.colCalidadesProceso.get(idRow);
        //Se toman los valores de la coleccion
        idTipoCalidad = row.attributes.idTipoCalidad;
        idProceso = row.attributes.idProceso;
        var url = contextPath + "CalidadProceso/Actualiza"; // El url del controlador
        $.get(url, { idProceso: idProceso, idTipoCalidad: idTipoCalidad }, function (data) {
            $('#actualiza-CalidadProceso').html(data);
            $('#actualiza-CalidadProceso').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            CalidadProceso.CargarColeccionTiposCalidad('#ActualizaCalidadProcesoForm');
            CalidadProceso.CargarColeccionProcesos('#ActualizaCalidadProcesoForm');
        });
    },
    Borrar: function (idRow) {
        var idProceso, idTipoCalidad, row;
        CMI.CierraMensajes();
        //Se toma de la colleccion el renglon seleccionado
        row = CalidadProceso.colCalidadesProceso.get(idRow);
        //Se toman los valores de la coleccion
        idTipoCalidad = row.attributes.idTipoCalidad;
        idProceso = row.attributes.idProceso;
        if (confirm('¿Esta seguro que desea borrar el registro?') === false) return;
        var url = contextPath + "CalidadProceso/Borrar"; // El url del controlador
        $.post(url, { idProceso: idProceso, idTipoCalidad: idTipoCalidad }, function (data) {
            if (data.Success == true) {
                CalidadProceso.colCalidadesProceso.remove(idRow);
                CMI.DespliegaInformacion(data.Message + "  Proceso:" + idProceso + "  TipoCalidad:" + idTipoCalidad);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la Relacion Calidad Proceso post Borrar"); });
    },
    CargarColeccionTiposCalidad: function (form) {
        if (CalidadProceso.colTiposCalidad.length < 1) {
            var url = contextPath + "TipoCalidad/CargaTiposCalidadActivos"; // El url del controlador
            $.getJSON(url, function (data) {
                CalidadProceso.colTiposCalidad = data;
                CalidadProceso.CargaListaTiposCalidad(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Tipos de Calidad");
            });
        } else {
            CalidadProceso.CargaListaTiposCalidad(form);
        }
    },
    CargaListaTiposCalidad: function (form) {
        var select = $(form + ' #idTipoCalidad').empty();

        select.append('<option> </option>');

        $.each(CalidadProceso.colTiposCalidad, function (i, item) {
            select.append('<option value="' + item.id + '">' + item.nombreTipoCalidad + '</option>');
        });

        $(form + ' #idTipoCalidad').val($(form + ' #tipocalidad').val());
    },
    CargarColeccionProcesos: function (form) {
        if (CalidadProceso.colProcesos.length < 1) {
            var url = contextPath + "Proceso/CargaProcesosActivos"; // El url del controlador
            $.getJSON(url, function (data) {
                CalidadProceso.colProcesos = data;
                CalidadProceso.CargaListaProcesos(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Procesos");
            });
        } else {
            CalidadProceso.CargaListaProcesos(form);
        }
    },
    CargaListaProcesos: function (form) {
        var select = $(form + ' #idProceso').empty();

        select.append('<option> </option>');

        $.each(CalidadProceso.colProcesos, function (i, item) {
            select.append('<option value="' + item.id + '">' + item.nombreProceso + '</option>');
        });

        $(form + ' #idProceso').val($(form + ' #proceso').val());
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos;
        CalidadProceso.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        CalidadProceso.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        CalidadProceso.accClonar = false; //No se puede clonar un registro de estos

        if (CalidadProceso.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaCalidadProceso: function (id, form) {
        return ({
            'idTipoCalidad': $(form + ' #idTipoCalidad').val(),
            'secuencia': $(form + ' #secuencia').val(),
            'idProceso': $(form + ' #idProceso').val(),
            'nombreTipoCalidad': $(form + ' #idTipoCalidad option:selected').text(),
            'nombreProceso': $(form + ' #idProceso option:selected').text(),
            'estatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "CalidadProceso/CargaCalidadesProceso"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            CalidadProceso.colCalidadesProceso = new Backbone.Collection(data);
            var bolFilter = CalidadProceso.colCalidadesProceso.length > 0 ? true : false;
            if (bolFilter) {
                gridCalidadesProceso = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: CalidadProceso.accClonar,
                    editar: CalidadProceso.accEscritura,
                    borrar: CalidadProceso.accBorrar,
                    collection: CalidadProceso.colCalidadesProceso,
                    colModel: [{ title: 'Proceso', name: 'nombreProceso', filter: true, filterType: 'input' },
                               { title: 'Tipo de Calidad', name: 'nombreTipoCalidad', filter: true, filterType: 'input' },
                               { title: 'Secuencia', name: 'secuencia', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Relaciones Calidad Proceso registradas");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las Relaciones Calidad Proceso");
        });
    }
};

$(function () {
    CalidadProceso.Inicial();
});