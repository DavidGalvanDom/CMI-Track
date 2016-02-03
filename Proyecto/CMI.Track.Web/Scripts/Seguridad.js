//js de catalogo de usuarios.
//David Galvan
//01/Febrero/2016

var Seguridad = {
    colModulos: {},
    gridSeguridad: {},
    Inicial: function (idUsuairo) {
        $.ajaxSetup({ cache: false });
        Seguridad.colModulos = {};
        Seguridad.gridSeguridad = {};
        this.CargaGrid(idUsuairo);
        this.Eventos();
    },
    Eventos: function () {
        var that = this;
       
        $(document).on("click", '.btn-GuardaSeguridad', that.onGuardar);
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
    serializaSeguridad: function (id) {
        return ({
            'ApeMaterno': $('#ApeMaterno').val().toUpperCase(),
            'ApePaterno': $('#ApePaterno').val().toUpperCase(),
            'Estatus': $('#Estatus').val(),
            'Nombre': $('#Nombre').val().toUpperCase(),
            'NombreUsuario': $('#NombreUsuario').val().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function (idUsuario) {
        var url = contextPath + "Seguridad/CargarModulos/" + idUsuario; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Seguridad.colModulos = new Backbone.Collection(data);
            var bolFilter = Seguridad.colModulos.length > 0 ? true : false;
            if (bolFilter) {
               Seguridad.gridSeguridad = new bbGrid.View({
                   container: $('#bbGrid-seguridad'),
                    enableSearch: true,
                    actionenable: false,
                    collection: Seguridad.colModulos,
                    colModel: [{ title: 'Modulo', name: 'nombreModulo', filter: true, filterType: 'input' },
                               { title: 'Lectura', name: 'lecturaPermisos', width: '8%', checkboxgen: true },
                               { title: 'Escritura', name: 'escrituraPermisos', width: '8%', checkboxgen: true },
                               { title: 'Clonar', name: 'clonadoPermisos', width: '8%', checkboxgen: true },
                               { title: 'Borrar', name: 'borradoPermisos', width: '8%', checkboxgen: true }]
                });
            }
            else {
                CMI.DespliegaInformacionDialogo("No se encontraron Modulos en base de datos.");
                $('#bbGrid-seguridad')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Modulos");
        });
    }
};