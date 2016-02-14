//js de catalogo de materiales.
//David Jasso
//02/Febrero/2016

var Material = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    colMateriales: {},
    colUnidadMedidaLargo: [],
    colUnidadMedidaAncho: [],
    colUnidadMedidaPeso: [],
    colTipoMaterial: [],
    colGrupo: [],
    gridMateriales: {},
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
        $(document).on("click", '.btn-ActualizarMaterial', that.onActualizar);

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

            $.post(contextPath + "Material/Nuevo",
                $("#NuevoMaterialForm *").serialize(),
                function (data) {
                    var ser = $("#NuevoMaterialForm *").serialize();
                    alert(ser);
                    if (data.Success == true) {
                        Material.colMateriales.add(Material.serializaMaterial(data.id, '#NuevoMaterialForm'));
                        CMI.DespliegaInformacion('El material fue guardado con el Id: ' + data.id);
                        $('#nuevo-material').modal('hide');
                        if (Material.colMateriales.length === 1) {
                            Material.CargaGrid();
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
            $.post(contextPath + "Material/Actualiza",
                $("#ActualizaMaterialForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-material').modal('hide');
                        Material.colMateriales.add(Material.serializaMaterial(data.id, '#ActualizaMaterialForm'), { merge: true });
                        CMI.DespliegaInformacion('Elmaterial fue Actualizado. Id:' + data.id);
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
        var url = contextPath + "Material/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-material').html(data);           
            $('#nuevo-material').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            $('#AnchoMaterial').val('');
            $('#LargoMaterial').val('');
            $('#PesoMaterial').val('');
            Material.CargarColeccionUnidadMedidaAncho('#NuevoMaterialForm');
            Material.CargarColeccionUnidadMedidaLargo('#NuevoMaterialForm');
            Material.CargarColeccionUnidadMedidaPeso('#NuevoMaterialForm');
            Material.CargarColeccionTipoMaterial('#NuevoMaterialForm');
            Material.CargarColeccionGrupo('#NuevoMaterialForm');
           // Material.CargarColeccionTipoMaterial();
           // Material.CargarColeccionGrupo();
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Material/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-material').html(data);
            $('#actualiza-material').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            Material.CargarColeccionUnidadMedidaAncho('#ActualizaMaterialForm');
            Material.CargarColeccionUnidadMedidaLargo('#ActualizaMaterialForm');
            Material.CargarColeccionUnidadMedidaPeso('#ActualizaMaterialForm');
            Material.CargarColeccionTipoMaterial('#ActualizaMaterialForm');
            Material.CargarColeccionGrupo('#ActualizaMaterialForm');
           // Material.CargarColeccionTipoMaterial();
           // Material.CargarColeccionGrupo();
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Material/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                Material.colMateriales.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Material post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Material/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-material').html(data);
            $('#nuevo-material').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            Material.CargarColeccionUnidadMedidaAncho('#NuevoMaterialForm');
            Material.CargarColeccionUnidadMedidaLargo('#NuevoMaterialForm');
            Material.CargarColeccionUnidadMedidaPeso('#NuevoMaterialForm');
            Material.CargarColeccionTipoMaterial('#NuevoMaterialForm');
            Material.CargarColeccionGrupo('#NuevoMaterialForm');
           // Material.CargarColeccionTipoMaterial();
          //  Material.CargarColeccionGrupo();
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    CargarColeccionUnidadMedidaAncho: function (form) {
        if (Material.colUnidadMedidaAncho.length < 1) {
            var url = contextPath + "UnidadMedida/CargaUnidadesMedidaActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                Material.colUnidadMedidaAncho = data;
                Material.CargaListaUnidadesAncho(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            Material.CargaListaUnidadesAncho(form);
        }
    },
    CargaListaUnidadesAncho: function (form) {
        var select = $(form + ' #AnchoUM').empty();

        select.append('<option> </option>');

        $.each(Material.colUnidadMedidaAncho, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreCortoUnidadMedida
                                 + '</option>');
        });

        $(form + ' #AnchoUM').val($(form + ' #AnchoUM').val());
    },
    CargarColeccionUnidadMedidaLargo: function (form) {
        if (Material.colUnidadMedidaLargo.length < 1) {
            var url = contextPath + "UnidadMedida/CargaUnidadesMedidaActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                Material.colUnidadMedidaLargo = data;
                Material.CargaListaUnidadesLargo(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            Material.CargaListaUnidadesLargo(form);
        }
    },
    CargaListaUnidadesLargo: function (form) {
        var select = $(form + ' #LargoUM').empty();

        select.append('<option> </option>');

        $.each(Material.colUnidadMedidaLargo, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreCortoUnidadMedida
                                 + '</option>');
        });

        $(form + ' #LargoUM').val($(form + ' #LargoUM').val());
    },
    CargarColeccionUnidadMedidaPeso: function (form) {
        if (Material.colUnidadMedidaPeso.length < 1) {
            var url = contextPath + "UnidadMedida/CargaUnidadesMedidaActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                Material.colUnidadMedidaPeso = data;
                Material.CargaListaUnidadesPeso(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            Material.CargaListaUnidadesPeso(form);
        }
    },
    CargaListaUnidadesPeso: function (form) {
        var select = $(form + ' #PesoUM').empty();

        select.append('<option> </option>');

        $.each(Material.colUnidadMedidaPeso, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreCortoUnidadMedida
                                 + '</option>');
        });

        $(form + ' #PesoUM').val($(form + ' #PesoUM').val());
    },
    CargarColeccionTipoMaterial: function (form) {
        if (Material.colTipoMaterial.length < 1) {
            var url = contextPath + "TipoMaterial/CargaTiposMaterialActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                Material.colTipoMaterial = data;
                Material.CargaListaTiposMaterial(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los tipos de materiales");
            });
        } else {
            Material.CargaListaTiposMaterial(form);
        }
    },
    CargaListaTiposMaterial: function (form) {
        var select = $(form + ' #TipoMaterial').empty();

        select.append('<option> </option>');

        $.each(Material.colTipoMaterial, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreTipoMaterial
                                 + '</option>');
        });

        $(form + ' #TipoMaterial').val($(form + ' #TipoMaterial').val());
    },
    CargarColeccionGrupo: function (form) {
        if (Material.colGrupo.length < 1) {
            var url = contextPath + "Grupo/CargaGruposActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                Material.colGrupo = data;
                Material.CargaListaGrupos(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los grupos");
            });
        } else {
            Material.CargaListaGrupos(form);
        }
    },
    CargaListaGrupos: function (form) {
        var select = $(form + ' #Grupo').empty();

        select.append('<option> </option>');

        $.each(Material.colGrupo, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreGrupo
                                 + '</option>');
        });

        $(form + ' #Grupo').val($(form + ' #Grupo').val());
    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = Material;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
        
        if (modulo.accEscritura === true)
            $('.btnNuevo').show();
    },
    serializaMaterial: function (id, from) {
        return ({
            'NombreMaterial': $(from + ' #NombreMaterial').val().toUpperCase(),
            'AnchoMaterial': $(from + ' #AnchoMaterial').val(),
            'AnchoUM': $(from + ' #AnchoUM').val(),
            'LargoMaterial': $(from + ' #LargoMaterial').val(),
            'LargoUM': $(from + ' #LargoUM').val(),
            'PesoMaterial': $(from + ' #PesoMaterial').val(),
            'PesoUM': $(from + ' #PesoUM').val(),
            'CalidadMaterial': $(from + ' #CalidadMaterial').val().toUpperCase(),
            'TipoMaterial': $(from + ' #TipoMaterial').val(),
            'Grupo': $(from + ' #Grupo').val(),
            'Observaciones': $(from + ' #Observaciones').val().toUpperCase(),
            'Estatus': $(from + ' #Estatus').val(),
            'id': id
        });        
    },
    CargaGrid: function () {
        $('#cargandoInfo').show();
        var url = contextPath + "Material/CargaMateriales"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Material.colMateriales = new Backbone.Collection(data);
            var bolFilter = Material.colMateriales.length > 0 ? true : false;
            if (bolFilter) {
                gridMateriales = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: true,
                    detalle: false,
                    clone: Material.accClonar,
                    editar: Material.accEscritura,
                    borrar: Material.accBorrar,
                    collection: Material.colMateriales,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Material', name: 'NombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'AnchoMaterial', filter: true },
                               { title: 'Ancho UM', name: 'AnchoUM', filter: true },
                               { title: 'Largo', name: 'LargoMaterial', filter: true },
                               { title: 'Largo UM', name: 'LargoUM', filter: true },
                               { title: 'Peso', name: 'PesoMaterial', filter: true },
                               { title: 'Peso UM', name: 'PesoUM', filter: true },
                               { title: 'Calidad', name: 'CalidadMaterial', filter: true, filterType: 'input' },
                               { title: 'Tipo Material', name: 'TipoMaterial', filter: true },
                               { title: 'Grupo', name: 'Grupo', filter: true },
                               { title: 'Observaciones', name: 'Observaciones', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'Estatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Materiales registrados");
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Materiales");
        });
    }
};

$(function () {
    Material.Inicial();
});