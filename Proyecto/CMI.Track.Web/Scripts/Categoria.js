//js de catalogo de categorias.
//David Jasso
//02/Febrero/2016

var Categoria = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colCategorias: {},
    gridCategorias: {},
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
        $(document).on("click", '.btn-ActualizarCategoria', that.onActualizar);

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
            $.post(contextPath + "Categoria/Nuevo",
                $("#NuevoCategoriaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        Categoria.colCategorias.add(Categoria.serializaCategoria(data.id, '#NuevoCategoriaForm'));
                        CMI.DespliegaInformacion('La categoria fue guardada con el Id: ' + data.id);
                        $('#nuevo-categoria').modal('hide');
                        if (Categoria.colCategorias.length === 1) {
                            Categoria.CargaGrid();
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
            $.post(contextPath + "Categoria/Actualiza",
                $("#ActualizaCategoriaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-categoria').modal('hide');
                        Categoria.colCategorias.add(Categoria.serializaCategoria(data.id, '#ActualizaCategoriaForm'), { merge: true });
                        CMI.DespliegaInformacion('La categoria fue Actualizada. Id:' + data.id);
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
        var url = contextPath + "Categoria/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-categoria').html(data);           
            $('#nuevo-categoria').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Categoria/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-categoria').html(data);
            $('#actualiza-categoria').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            ReqMCompra.CargarColeccionUnidadMedida();
            ReqMCompra.CargarColeccionAlmacen();
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Categoria/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Categoria.colCategorias.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la categoria post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Categoria/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-categoria').html(data);
            $('#nuevo-categoria').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = Categoria;
        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaCategoria: function (id,form) {
        return ({
            'NombreCategoria': $(form + ' #NombreCategoria').val().toUpperCase(),
            'Estatus': $(form + ' #Estatus option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "Categoria/CargaCategorias"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Categoria.colCategorias = new Backbone.Collection(data);
            var bolFilter = Categoria.colCategorias.length > 0 ? true : false;
            if (bolFilter) {
                gridCategorias = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Categoria.accClonar,
                    editar: Categoria.accEscritura,
                    borrar: Categoria.accBorrar,
                    collection: Categoria.colCategorias,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Categoria', name: 'NombreCategoria', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Categorias registradas");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las categorias");
        });
    }
};

$(function () {
    Categoria.Inicial();
});