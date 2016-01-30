//js de catalogo de usuarios.
//David Galvan
//29/Enero/2016

var Usuario = {
    accClonar: false,
    accNuevo: false,
    accEditar: false,
    accBorrar: false,
    colUsuarios: {},
    gridUsuarios: {},
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
        $(document).on("click", '.btn-ActualizarUsuario', that.onActualizar);

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
            $.post(contextPath + "Usuario/Nuevo",
                $("#NuevoUsuarioForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Usuario.colUsuarios.add(Usuario.serializaUsuario(data.id));
                        CMI.DespliegaInformacion('El Usuario fue guardado con el Id: ' + data.id);
                        $('#nuevo-usuario').modal('hide');
                        if (Usuario.colUsuarios.length === 1) {
                            Usuario.CargaGrid();
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
            $.post(contextPath + "Usuario/Actualiza",
                $("#ActualizaUsuarioForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-usuario').modal('hide');
                        Usuario.colUsuarios.add(Usuario.serializaUsuario(data.id), { merge: true });
                        CMI.DespliegaInformacion('El usuario fue Actualizado. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () { CMI.DespliegaErrorDialogo("Error al actualizar la informacion"); });
        }   
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Usuario/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-usuario').html(data);           
            $('#nuevo-usuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Usuario/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-usuario').html(data);
            $('#actualiza-usuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Usuario/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Usuario.colUsuarios.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el usuario post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Usuario/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-usuario').html(data);
            $('#actualiza-usuario').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        Usuario.accNuevo = true;
        Usuario.accClonar = true;
        Usuario.accEditar = true;
        Usuario.accBorrar = true;

        if (Usuario.accNuevo === true)
            $('.btnNuevo').show();
    },
    serializaUsuario: function (id) {
        return ({
            'ApeMaterno': $('#ApeMaterno').val().toUpperCase(),
            'ApePaterno': $('#ApePaterno').val().toUpperCase(),
            'Estatus': $('#Estatus').val(),
            'Nombre': $('#Nombre').val().toUpperCase(),
            'NombreUsuario': $('#NombreUsuario').val().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Usuario/CargaUsuarios"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Usuario.colUsuarios = new Backbone.Collection(data);
            var bolFilter = Usuario.colUsuarios.length > 0 ? true : false;
            if (bolFilter) {
                gridUsuarios = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Usuario.accClonar,
                    editar: Usuario.accEditar,
                    borrar: Usuario.accBorrar,
                    collection: Usuario.colUsuarios,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Usuario', name: 'NombreUsuario', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'Nombre', filter: true, filterType: 'input' },
                               { title: 'Apellido Paterno', name: 'ApePaterno' },
                               { title: 'Apellido Materno', name: 'ApeMaterno' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Usuarios registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los usuario");
        });
    }
};


$(function () {
    Usuario.Inicial();
});