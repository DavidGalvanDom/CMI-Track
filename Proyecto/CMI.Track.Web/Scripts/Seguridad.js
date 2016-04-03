/*global _,$, CMI,bbGrid,Backbone,contextPath*/
//js de catalogo de usuarios.
//David Galvan
//01/Febrero/2016

var Seguridad = {
    colModulos: {},
    gridSeguridad: {},
    idUsuario:0,
    Inicial: function (pidUsuairo) {       
        $.ajaxSetup({ cache: false });
        Seguridad.colModulos = {};
        Seguridad.gridSeguridad = {};
        Seguridad.idUsuario = pidUsuairo;
        Seguridad.CargaGrid();
        Seguridad.Eventos();        
    },
    Eventos: function () {
        var that = this;

        if (localStorage.modSerdad !== null) {
           var accGuardar = localStorage.modSerdad.substr(1, 1) === '1' ? true : false;
           if (accGuardar === true)
               $('.btn-GuardaSeguridad').show();
        }

        $(document).on("click", '.btn-GuardaSeguridad', that.onGuardar);
        $(document).on("change", '#chkAllLectura', that.onCheckAll);
        $(document).on("change", '#chkAllEscritura', that.onCheckAll);
        $(document).on("change", '#chkAllClonar', that.onCheckAll);
        $(document).on("change", '#chkAllBorrar', that.onCheckAll);
    },
    onGuardar: function () {
        var modulos = [],
            btn = this,
            dataPost = {
                lstModulos: modulos,
                idUsuario: Seguridad.idUsuario,
                usuarioCreacion : localStorage.idUser};

        CMI.botonMensaje(true, btn, 'Guardar');

        //Se agrega la coleccion de items.
        _.each(Seguridad.colModulos.models, function (object) {
            object.attributes.lecturaPermisos = 0;
            object.attributes.escrituraPermisos = 0;
            object.attributes.clonadoPermisos = 0;
            object.attributes.borradoPermisos = 0;
        });

        //Se actuliza la coleccion con la informacion seleccionada
        $("#frmSeguridad").find("input:checked").each(function (index, item) {
            if (item.id.split("-").length > 1) {
                var arrModel = item.id.split("-");
                var model = Seguridad.colModulos.get(arrModel[0]);
                model.attributes[arrModel[1]] = 1;
                Seguridad.colModulos.add(model, { merge: true });
            }
        });
        
        //Se agrega la coleccion de items.
        _.each(Seguridad.colModulos.models, function (object) {
            modulos.push(object.attributes);
        });
        
        //Se hace el post para guardar la informacion
        $.post(contextPath + "Seguridad/GuardaSeguridad",
            dataPost,
            function (data) {
                var div;
                if (data.Success === true) {                   
                    CMI.DespliegaInformacion(data.Message);
                    $('#seguridadUsuario').modal('hide');
                } else {
                    CMI.DespliegaErrorDialogo(data.Message);
                    div = document.getElementById('divMessage');
                    if (div !== null) div.scrollIntoView();
                }
            }).fail(function () {
                CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                var div = document.getElementById('divMessage');
                if (div !== null) div.scrollIntoView();
            }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
       
    },
    onCheckAll: function () {
        var chk = this,
            item,
            text;
        if ($(chk).attr('id') === 'chkAllLectura') { item = '#chkAllLectura'; text = 'lecturaPermisos'; }
        if ($(chk).attr('id') === 'chkAllEscritura') {  item = '#chkAllEscritura'; text = 'escrituraPermisos'; }
        if ($(chk).attr('id') === 'chkAllClonar') { item = '#chkAllClonar'; text = 'clonadoPermisos'; }
        if ($(chk).attr('id') === 'chkAllBorrar') { item = '#chkAllBorrar'; text = 'borradoPermisos'; }


        var selected = [],
            id = '',
            arrId = [],
            head = $(item).prop('checked');        
        $('input[type=checkbox]').each(function () {
            selected.push($(this).attr('id'));
        });
        for (var i = 0; i < selected.length; i++) {
            id = selected[i];
            arrId = id.split("-");
            if (arrId.length > 1) {
                if (arrId[1] === text) {
                    if (head === false) {
                        $('#' + id).prop('checked', true);
                        $('#' + id).removeAttr('checked');
                    } else {
                        $('#' + id).removeAttr('checked');
                        $('#' + id).prop('checked', true);
                    }

                }
            }
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
    CargaGrid: function () {
        $('#cargandoInfoSeg').show();
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
                    colModel: [{ title: 'Modulo', name: 'nombreModulo', width: '50%' },
                               { title: 'Lectura&nbsp;<input type="checkbox" id="chkAllLectura" />', name: 'lecturaPermisos', width: '10%', checkboxgen: true, textalign:true },
                               { title: 'Escritura&nbsp;<input type="checkbox" id="chkAllEscritura" />', name: 'escrituraPermisos', width: '10%', checkboxgen: true, textalign: true },
                               { title: 'Clonar&nbsp;<input type="checkbox" id="chkAllClonar" />', name: 'clonadoPermisos', width: '10%', checkboxgen: true, textalign: true },
                               { title: 'Borrar&nbsp;<input type="checkbox" id="chkAllBorrar" />', name: 'borradoPermisos', width: '10%', checkboxgen: true, textalign: true }]
                });
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Modulos en base de datos.");
                $('#bbGrid-seguridad')[0].innerHTML = "";
            }
            $('#cargandoInfoSeg').hide();
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Modulos");
        }).always(function () { $('#cargandoInfoSeg').hide(); });
    }
};