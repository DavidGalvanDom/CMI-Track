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

        if ($("form").valid()) {

            //Se hace el post para guardar la informacion
            $.post(contextPath + "Departamento/Nuevo",
                $("#NuevoDepartamentoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Departamento.colDepartamentos.add(Departamento.serializaDepartamento(data.id));
                        CMI.DespliegaInformacion('El Departamento fue guardado con el Id: ' + data.id);
                        $('#nuevo-Departamento').modal('hide');
                        if (Departamento.colDepartamentos.length === 1) {
                            Departamento.CargaGrid();
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
            $.post(contextPath + "Departamento/Actualiza",
                $("#ActualizaDepartamentoForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-Departamento').modal('hide');
                        Departamento.colDepartamentos.add(Departamento.serializaDepartamento(data.id), { merge: true });
                        CMI.DespliegaInformacion('El Departamento fue Actualizado. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al actualizar la informacion"); });
        }
    },
    Seguridad: function (idUsuairo) {

        CMI.CierraMensajes();
        var url = contextPath + "Seguridad/Modulos/" + idUsuairo; // El url del controlador      
        $.get(url, function (data) {
            $('#seguridadDepartamento').html(data);
            $('#seguridadDepartamento').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            Seguridad.Inicial(idUsuairo);
        });
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Departamento/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-Departamento').html(data);
            $('#nuevo-Departamento').modal({
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
            $('#actualiza-Departamento').html(data);
            $('#actualiza-Departamento').modal({
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
            $('#actualiza-Departamento').html(data);
            $('#actualiza-Departamento').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        Departamento.accClonar = true;
        Departamento.accEscritura = true;
        Departamento.accBorrar = true;
        
        if (Departamento.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaDepartamento: function (id) {
        return ({
            'Fecha': $('#ApePaterno').val().toUpperCase(),
            'Estatus': $('#Estatus').val(),
            'Nombre': $('#Nombre').val().toUpperCase(),           
            'id': id
        });
    },
    CargaGrid: function () {
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