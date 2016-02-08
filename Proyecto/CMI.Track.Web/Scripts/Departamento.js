//js de catalogo de Departamentos.
//David Galvan
//02/Febrero/2016

var Departamento = {
    accClonar: false,
    accEscritura: false,    
    accBorrar: false,    
    colDepartamentos: {},
    gridDepartamentos: {},
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
        
        $(document).on("click", '.btn-ActualizarDepartamento', that.onActualizar);

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
            $.post(contextPath + "Departamento/Nuevo",
                $("#NuevoDepartamentoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Departamento.colDepartamentos.add(Departamento.serializaDepartamento(data.id));
                        CMI.DespliegaInformacion('El Departamento fue guardado con el Id: ' + data.id);
                        $('#nuevo-departamento').modal('hide');
                        if (Departamento.colDepartamentos.length === 1) {
                            Departamento.CargaGrid();
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
            $.post(contextPath + "Departamento/Actualiza",
                $("#ActualizaDepartamentoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-departamento').modal('hide');
                        Departamento.colDepartamentos.add(Departamento.serializaDepartamento(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Departamento fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "Departamento/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-departamento').html(data);
            $('#nuevo-departamento').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Departamento/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-departamento').html(data);
            $('#actualiza-departamento').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Departamento/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Departamento.colDepartamentos.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Departamento post Borrar"); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Departamento/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-departamento').html(data);
            $('#nuevo-departamento').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos;
        Departamento.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        Departamento.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        Departamento.accClonar = permisos.substr(3, 1) === '1' ? true : false;
        
        if (Departamento.accEscritura === true)
            $('.btnNuevo').show();    
    },
    serializaDepartamento: function (id) {
        return ({
            'fechaCreacion': $('#fechaCreacion').val(),
            'idEstatus': $('#idEstatus').val(),
            'Nombre': $('#Nombre').val().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "Departamento/CargaDepartamentos/-1"; // El url del controlador -1 todos los departamentos sin tomar encuenta el estatus
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Departamento.colDepartamentos = new Backbone.Collection(data);
            var bolFilter = Departamento.colDepartamentos.length > 0 ? true : false;
            if (bolFilter) {
                gridDepartamentos = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Departamento.accClonar,
                    editar: Departamento.accEscritura,
                    borrar: Departamento.accBorrar,                    
                    collection: Departamento.colDepartamentos,                    
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },                               
                               { title: 'Nombre', name: 'Nombre', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'fechaCreacion', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'idEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Departamentos registrados");
                $('#bbGrid-clear')[0].innerHTML = "";                
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Departamento");
        });
    }
};


$(function () {
    Departamento.Inicial();
});