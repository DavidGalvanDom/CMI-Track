//js de catalogo de clientes.
//David Jasso
//02/Febrero/2016

var Cliente = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colClientes: {},
    gridClientes: {},
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
        $(document).on("click", '.btn-ActualizarCliente', that.onActualizar);

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
            $.post(contextPath + "Cliente/Nuevo",
                $("#NuevoClienteForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Cliente.colClientes.add(Cliente.serializaCliente(data.id, '#NuevoClienteForm'));
                        CMI.DespliegaInformacion('El cliente fue guardado con el Id: ' + data.id);
                        $('#nuevo-cliente').modal('hide');
                        if (Cliente.colClientes.length === 1) {
                            Cliente.CargaGrid();
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
            $.post(contextPath + "Cliente/Actualiza",
                $("#ActualizaClienteForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-cliente').modal('hide');
                        Cliente.colClientes.add(Cliente.serializaCliente(data.id, '#ActualizaClienteForm'), { merge: true });
                        CMI.DespliegaInformacion('El cliente fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "Cliente/Nuevo"; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-cliente').html(data);
            $('#nuevo-cliente').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            $('#CpCliente').val('');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Cliente/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-cliente').html(data);
            $('#actualiza-cliente').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Cliente/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Cliente.colClientes.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el cliente post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Cliente/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-cliente').html(data);
            $('#nuevo-cliente').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = Cliente;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaCliente: function (id, from) {
        return ({
            'NombreCliente': $(from + ' #NombreCliente').val().toUpperCase(),
            'DireccionEntrega': $(from + ' #DireccionEntrega').val().toUpperCase(),
            'ColoniaCliente': $(from + ' #ColoniaCliente').val().toUpperCase(),
            'CpCliente': $(from + ' #CpCliente').val(),
            'ContactoCliente': $(from + ' #ContactoCliente').val().toUpperCase(),
            'CiudadCliente': $(from + ' #CiudadCliente').val().toUpperCase(),
            'EstadoCliente': $(from + ' #EstadoCliente').val().toUpperCase(),
            'PaisCliente': $(from + ' #PaisCliente').val().toUpperCase(),
            'Estatus': $(from + ' #Estatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "Cliente/CargaClientes"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Cliente.colClientes = new Backbone.Collection(data);
            var bolFilter = Cliente.colClientes.length > 0 ? true : false;
            if (bolFilter) {
                gridClientes = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Cliente.accClonar,
                    editar: Cliente.accEscritura,
                    borrar: Cliente.accBorrar,
                    collection: Cliente.colClientes,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Cliente', name: 'NombreCliente', filter: true, filterType: 'input' },
                               { title: 'Direccion', name: 'DireccionEntrega', filter: true, filterType: 'input' },
                               { title: 'Colonia', name: 'ColoniaCliente', filter: true, filterType: 'input' },
                               { title: 'CP', name: 'CpCliente', filter: true, filterType: 'input' },
                               { title: 'Contacto', name: 'ContactoCliente', filter: true, filterType: 'input' },
                               { title: 'Ciudad', name: 'CiudadCliente', filter: true, filterType: 'input' },
                               { title: 'Estado', name: 'EstadoCliente', filter: true, filterType: 'input' },
                               { title: 'Pais', name: 'PaisCliente', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Clientes registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los clientes");
        });
    }
};

$(function () {
    Cliente.Inicial();
});