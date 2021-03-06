﻿/*global $, CMI, contextPath, Backbone, bbGrid*/
//js de catalogo de Grupo
//Juan Lopepe
//01/Febrero/2016

var Grupo = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colGrupos: {},
    gridGrupos: {},
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
        $(document).on("click", '.btn-ActualizarGrupo', that.onActualizar);

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
    onGuardar: function () {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Grupo/Nuevo",
                $("#NuevoGrupoForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        Grupo.colGrupos.add(Grupo.serializaGrupo(data.id, '#NuevoGrupoForm'));
                        CMI.DespliegaInformacion('El Grupo fue guardado con el Id: ' + data.id);
                        $('#nuevo-Grupo').modal('hide');
                        if (Grupo.colGrupos.length === 1) {
                            Grupo.CargaGrid();
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
    onActualizar: function () {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Grupo/Actualiza",
                $("#ActualizaGrupoForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        $('#actualiza-Grupo').modal('hide');
                        Grupo.colGrupos.add(Grupo.serializaGrupo(data.id, '#ActualizaGrupoForm'), { merge: true });
                        CMI.DespliegaInformacion('El Grupo fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "Grupo/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-Grupo').html(data);
            $('#nuevo-Grupo').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Grupo/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Grupo').html(data);
            $('#actualiza-Grupo').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Grupo/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                Grupo.colGrupos.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Grupo post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Grupo/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Grupo').html(data);
            $('#actualiza-Grupo').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos;
        Grupo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        Grupo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        Grupo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (Grupo.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaGrupo: function (id,form) {
        return ({
            'nombreGrupo': $(form + ' #nombreGrupo').val().toUpperCase(),
            'estatus': $(form + ' #idEstatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Grupo/CargaGrupos"; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Grupo.colGrupos = new Backbone.Collection(data);
            var bolFilter = Grupo.colGrupos.length > 0 ? true : false;
            if (bolFilter) {
                Grupo.gridGrupos = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Grupo.accClonar,
                    editar: Grupo.accEscritura,
                    borrar: Grupo.accBorrar,
                    collection: Grupo.colGrupos,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Grupo', name: 'nombreGrupo', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Grupos registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de los Grupos");
        });
    }
};


$(function () {
    Grupo.Inicial();
});