//js de catalogo de usuarios.
//David Galvan
//01/Febrero/2016

var Seguridad = {
    colModulos: {},
    gridSeguridad: {},
    idUsuario:0,
    Inicial: function (pidUsuairo) {
       debugger
        $.ajaxSetup({ cache: false });
        Seguridad.colModulos = {};
        Seguridad.gridSeguridad = {};
        Seguridad.idUsuario = pidUsuairo;
        Seguridad.CargaGrid();
        Seguridad.Eventos();
    },
    Eventos: function () {
        var that = this;       
        $(document).on("click", '.btn-GuardaSeguridad', that.onGuardar);
    },
    onGuardar: function (e) {        
        var modulos = [],
            dataPost = {
                lstModulos: modulos,
                        idUsuario: Seguridad.idUsuario,
                        usuarioCreacion : localStorage.idUser};
        
        //Se actuliza la coleccion con la informacion seleccionada
        $("#frmSeguridad").find("input:checked").each(function (index, item) {
            var arrModel = item.id.split("-");
            var model = Seguridad.colModulos.get(arrModel[0]);
            model.attributes[arrModel[1]] = 1;
            Seguridad.colModulos.add(model, { merge: true });            
        });
        
        //Se agrega la coleccion de items.
        _.each(Seguridad.colModulos.models, function (object, index) {
            modulos.push(object.attributes);
        });
        
        //Se hace el post para guardar la informacion
        $.post(contextPath + "Seguridad/GuardaSeguridad",
            dataPost,
            function (data) {
                if (data.Success == true) {                   
                    CMI.DespliegaInformacionDialogo(data.Message);
                }
                else {
                    CMI.DespliegaErrorDialogo(data.Message);
                }
            }).fail(function () { CMI.DespliegaErrorDialogo("Error al guardar la informacion"); });
       
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
    CargaGrid: function () {
        var url = contextPath + "Seguridad/CargarModulos/" + Seguridad.idUsuario; // El url del controlador
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
                               { title: 'Lectura', name: 'lecturaPermisos', width: '8%', checkboxgen: true, textalign:true },
                               { title: 'Escritura', name: 'escrituraPermisos', width: '8%', checkboxgen: true, textalign: true },
                               { title: 'Clonar', name: 'clonadoPermisos', width: '8%', checkboxgen: true, textalign: true },
                               { title: 'Borrar', name: 'borradoPermisos', width: '8%', checkboxgen: true, textalign: true }]
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