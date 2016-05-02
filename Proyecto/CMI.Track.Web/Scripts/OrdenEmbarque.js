/*global $, CMI, Backbone, bbGrid, contextPath, ProyectoBuscar, EtapaBuscar, routeUrlImages*/
//js de catalogo de Ordenes de Embarque.
//David Galvan
//30/Abril/2016
var OrdenEmbarque = {
    lstMarcasSelect : null,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridOrdenEmbarque: {},
    gridMarca: {},
    rowSelected: null,
    colOrdenEmbarque: {},
    colOrden: [],
    colMarcas: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnImprimir").click(that.onImprimir);
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarOE', that.onActualizar);

        $('#etapaRow').hide();
        $('#btnCollapse').hide();
        $('#Imprimir').hide();

        //Eventos de los botones de Acciones del grid
        $(document).on('click', '.accrowEdit', function () {
            that.Editar($(this).parent().parent().attr("data-modelId"));
        });

        $(document).on('click', '.accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
        });
    },
    onActualizar: function (){
        var btn = this,
            dataPost = '';
        CMI.botonMensaje(true, btn, 'Actulizando');
        if ($("form").valid()) {
            $('#ActualizaOrdenEmbarqueForm #usuarioCreacion').val(localStorage.idUser);
            dataPost = $("#ActualizaOrdenEmbarqueForm *").serialize();

            if (OrdenEmbarque.gridMarca.selectedRows.length < 1) {
                CMI.DespliegaErrorDialogo('Debe seleccionar por lo menos una Marca de la lista.');
                CMI.botonMensaje(false, btn, 'Actualizar');
                return;
            } else {
                //Se agregen los Nuevo registros accion = 1
                $.each(OrdenEmbarque.gridMarca.selectedRows, function (index, value) {
                    var existeVal = false;
                    //1 se agrega como nuevo
                    $.each(OrdenEmbarque.lstMarcasSelect, function (indexSel, valueSel) {
                        if (valueSel.id === value) { existeVal = true; }
                    });

                    if (existeVal === false) {
                        dataPost = dataPost + '&lstMS=' + value + '|1';
                    }
                });

                //Se agregan los que se tiene que borrar de base de datos 0
                $.each(OrdenEmbarque.lstMarcasSelect, function (index, value) {
                    var existeVal = false;
                    //1 se agrega como nuevo
                    $.each(OrdenEmbarque.gridMarca.selectedRows, function (indexSel, valueSel) {
                        if (valueSel === value.id) { existeVal = true; }
                    });

                    if (existeVal === false) {
                        dataPost = dataPost + '&lstMS=' + value.id + '|0';
                    }
                });
            }
            //Se hace el post para guardar la informacion
            $.post(contextPath + "OrdenEmbarque/Actualiza",
                dataPost,
                function (data) {
                    if (data.Success === true) {
                        OrdenEmbarque.colOrdenEmbarque.add(OrdenEmbarque.serializaOrdenEmbarque(data.id), {merge: true});
                        CMI.DespliegaInformacion('La Orden de embarque se actualizo correctamente. ');
                        $('#editar-OrdenEmbarque').modal('hide');
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Actulizar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Actulizar');
            $("#Obervaciones").focus();
        }
    },
    onGuardar: function () {
        var btn = this,
            dataPost = '';

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#NuevoOrdenEmbarqueForm #usuarioCreacion').val(localStorage.idUser);
            $('#NuevoOrdenEmbarqueForm #idEtapa').val($('#idEtapaSelect').val());
            $('#NuevoOrdenEmbarqueForm #idProyecto').val($('#idProyectoSelect').val());
            dataPost = $("#NuevoOrdenEmbarqueForm *").serialize();

            if (OrdenEmbarque.gridMarca.selectedRows.length < 1) {
                CMI.DespliegaErrorDialogo('Debe seleccionar por lo menos una Marca de la lista.');
                CMI.botonMensaje(false, btn, 'Guardar');
                return;
            } else {
                $.each(OrdenEmbarque.gridMarca.selectedRows, function (index, value) {
                    dataPost = dataPost + '&lstMS=' + value;
                });
            }
            //Se hace el post para guardar la informacion
            $.post(contextPath + "OrdenEmbarque/Nuevo",
                dataPost,
                function (data) {
                    if (data.Success === true) {
                        OrdenEmbarque.colOrdenEmbarque.add(OrdenEmbarque.serializaOrdenEmbarque(data.id));
                        CMI.DespliegaInformacion('La Orden de embarque se genero con el Id: ' + data.id);
                        $('#nuevo-OrdenEmbarque').modal('hide');
                        if (OrdenEmbarque.colOrdenEmbarque.length === 1) {
                            OrdenEmbarque.CargarGridEmbarques();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Guardar');
            $("#Obervaciones").focus();
        }
    },
    onBuscarProyecto: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/BuscarProyecto"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            ProyectoBuscar.Inicial();
            ProyectoBuscar.parent = OrdenEmbarque;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarEtapa: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Etapa/BuscarEtapa"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            EtapaBuscar.idProyecto = $('#idProyectoSelect').val();
            EtapaBuscar.revisionProyecto = $('#RevisionPro').text();
            EtapaBuscar.parent = OrdenEmbarque;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/Nuevo"; // El url del controlador   
        $.get(url, function (data) {
            $('#nuevo-OrdenEmbarque').html(data);
            $('#nuevo-OrdenEmbarque').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos 
            $('#NuevoOrdenEmbarqueForm #lblNuevoProyecto').text($('#nombreProyecto').text());
            $('#NuevoOrdenEmbarqueForm #lblNuevoEtapa').text($('#nombreEtapa').text());
            OrdenEmbarque.activeForm = '#NuevoOrdenEmbarqueForm';
            OrdenEmbarque.lstMarcasSelect = [];
            OrdenEmbarque.CargaGridMarcas();
        }).fail(function () { CMI.DespliegaError("No se pudo Crear una nueva Orden de embarque"); });
    },
    Editar: function(id){
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/Actualiza/" + id; // El url del controlador   
        $.get(url, function (data) {
            $('#editar-OrdenEmbarque').html(data);
            $('#editar-OrdenEmbarque').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos 
            $('#ActualizaOrdenEmbarqueForm #lblNuevoProyecto').text($('#nombreProyecto').text());
            $('#ActualizaOrdenEmbarqueForm #lblNuevoEtapa').text($('#nombreEtapa').text());
            OrdenEmbarque.activeForm = '#ActualizaOrdenEmbarqueForm';
            OrdenEmbarque.CargaGridMarcas(true);
        }).fail(function () { CMI.DespliegaError("No se pudo Editar la Orden de embarque"); });
    },
    Borrar: function(id){
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "OrdenEmbarque/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                OrdenEmbarque.colOrdenEmbarque.remove(id);
                CMI.DespliegaInformacion("Se borro la Orden de embarque con  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la Orden de Embarque"); });
    },
    AsignaProyecto: function (idProyecto, Revision,
                             NombreProyecto, CodigoProyecto,
                             FechaInicio, FechaFin) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        //Se inicializa la informacion seleccionada a vacio
        $('#idEtapaSelect').val(0);
        $('.btnNuevo').hide();
        $('#Imprimir').hide();
        $('#bbGrid-OrdenEmbarque')[0].innerHTML = "";
        $('#idEtapaSelect').val('');
        $('#nombreEtapa').text('');
        $('#FechaInicioEtapa').text('');
        $('#FechaFinEtapa').text('');
        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        if (OrdenEmbarque.accEscritura === true)
            $('.btnNuevo').show();

        $('#myCollapsible').collapse('hide');
        $("#btn").addClass("glyphicon-plus");
        $('#btnCollapse').show();
        $('#rowOrdenEmbarque').show();
        $('#bbGrid-OrdenEmbarque')[0].innerHTML = "";
        OrdenEmbarque.CargarGridEmbarques();
    },
    serializaOrdenEmbarque: function (id){
        var form = OrdenEmbarque.activeForm;
        return ({
            'idOrdenProduccion': $('#idEtapaSelect').val(), //La etapa es igual a la Orden de produccion
            'observacionOrdenEmbarque': $(form + ' #Obervaciones').val().toUpperCase(),
            'estatuOrdeEmbarque': $('#EstatusOE option:selected').text().toUpperCase(),
            'fechaCreacion': $('#fechaCreacion').val(),
            'id': id
        });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = OrdenEmbarque;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
    },
    CargarGridEmbarques: function () {
        var url = contextPath + "OrdenEmbarque/CargaOrdenEmbarques/",
            data = 'idProyecto=' + $('#idProyectoSelect').val() +
                   '&idEtapa=' + $('#idEtapaSelect').val();// El url del controlador
        $.getJSON(url, data, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            OrdenEmbarque.colOrdenEmbarque = new Backbone.Collection(data);
            var bolFilter = OrdenEmbarque.colOrdenEmbarque.length > 0 ? true : false;
            if (bolFilter) {
                OrdenEmbarque.gridOrdenEmbarque = new bbGrid.View({
                    container: $('#bbGrid-OrdenEmbarque'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    editar: OrdenEmbarque.accEscritura,
                    borrar: OrdenEmbarque.accBorrar,
                    collection: OrdenEmbarque.colOrdenEmbarque,
                    colModel: [{ title: 'Orden Embarque', name: 'id', width: '15%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Orden Produccion', name: 'idOrdenProduccion', width: '15%', filter: true, filterType: 'input' },
                               { title: 'Observacion', name: 'observacionOrdenEmbarque', width: '55%', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'estatuOrdeEmbarque', width: '55%', filter: true, filterType: 'input' },
                               { title: 'Fecha', name: 'fechaCreacion', width: '15%', filter: true, filterType: 'input' }],
                    onRowClick: function () {
                        $('#Imprimir').show();
                        OrdenEmbarque.rowSelected  = this.selectedRows[0];
                    }
                });
                $('#cargandoInfoOE').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron Ordenes de Embarque");
                $('#bbGrid-OrdenEmbarque')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de las Ordenes de Embarque");
        });
    },
    AgregaMarcasExistentes: function () {
        $.each(OrdenEmbarque.lstMarcasSelect, function (index, item) {
            OrdenEmbarque.colMarcas.add(item, { at: 0 });
        });
    },
    SeleccionarMarcasExistenes: function (view) {
        $.each(OrdenEmbarque.lstMarcasSelect, function (index, item) {
            view.setRowSelected({ id: item.id });
        });
    },
    CargaGridMarcas: function (addExistentes) {
        var lblNumMarcas = $(OrdenEmbarque.activeForm + ' #lblNumMarcas');
        $(OrdenEmbarque.activeForm + ' #cargandoInfoMAR').show();
        var url = contextPath + "OrdenEmbarque/CargaMarcasDispo?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            OrdenEmbarque.colMarcas = new Backbone.Collection(data);
            if (addExistentes) { OrdenEmbarque.AgregaMarcasExistentes(); }
            var bolFilter = OrdenEmbarque.colMarcas.length > 0 ? true : false;
            if (bolFilter) {
                OrdenEmbarque.gridMarca = new bbGrid.View({
                    container: $(OrdenEmbarque.activeForm + ' #bbGrid-MarcasAgregar'),
                    enableTotal: true,
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    multiselect: true,
                    collection: OrdenEmbarque.colMarcas,
                    colModel: [{ title: 'Marca', name: 'NombreMarca', filter: true, filterType: 'input' },
                               { title: 'Serie', name: 'idSerie', filter: true, filterType: 'input' },
                               { title: 'Peso', name: 'Peso', filter: true, total: 0, filterType: 'input' },
                               { title: 'Piezas Marca', name: 'Piezas', filter: true, filterType: 'input' },
                               { title: 'Plano', name: 'NombrePlano', filter: true, filterType: 'input' }],
                    onRowClick: function () {
                        lblNumMarcas.text(this.selectedRows.length);
                    },
                    onBeforeRender: function () {
                        lblNumMarcas.text(this.selectedRows.length);
                    },
                    onReady: function () {
                        if (OrdenEmbarque.lstMarcasSelect.length > 0) {
                            OrdenEmbarque.SeleccionarMarcasExistenes(this);
                        }
                    }
                });
                $(OrdenEmbarque.activeForm + ' #cargandoInfoMAR').hide();
                $('.btn-ActualizarOE').show();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Marcas.");
                $(OrdenEmbarque.activeForm + ' #bbGrid-MarcasAgregar')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las Marcas");
        });
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_orden_embarque.html",
            rptTemplate = '',
            tabla_html,
            tablatmp = '',
            tableData,
            tablaheader,
            tcompleta = '',
            f = new Date(),
            dataFiltros= "?idProyecto=" + $('#idProyectoSelect').val() +
                        "&idEtapa=" + $('#idEtapaSelect').val() +
                        "&idOrden=" + OrdenEmbarque.rowSelected;

        if (OrdenEmbarque.rowSelected !== null) {
            $.get(templateURL, function (data) {
                rptTemplate = data;
                var urlHeader = contextPath + "OrdenEmbarque/CargaHeaderOrdeEmb" + dataFiltros; // El url del controlador
                $.getJSON(urlHeader, function (data) {
                    tablaheader = data;
                    for (var j = 0; j < tablaheader.length; j++) {
                        rptTemplate = rptTemplate.replace('vrEtapaNom', tablaheader[j].NombreEtapa);
                        rptTemplate = rptTemplate.replace('vrRevison', tablaheader[j].Revision);
                        rptTemplate = rptTemplate.replace('vrProyecto', tablaheader[j].NombreProyecto);
                        rptTemplate = rptTemplate.replace('vrFolio', tablaheader[j].idOrdenEmb);
                        rptTemplate = rptTemplate.replace('vrCodigo', tablaheader[j].Codigo);
                    }

                    var url = contextPath + "OrdenEmbarque/CargaReporteDetaOE/" + OrdenEmbarque.rowSelected; // El url del controlador
                    $.getJSON(url, function (data) {
                        tableData = data;
                        for (var i = 0; i < tableData.length; i++) {
                            tcompleta += "<tr>";
                            tcompleta += "<td colspan='2'>" + tableData[i].nombreMarca + "</td>";
                            tcompleta += "<td colspan='2'>" + tableData[i].piezas + "</td>";
                            tcompleta += "<td colspan='2'>" + tableData[i].peso + "</td>";
                            tcompleta += "<td colspan='3'>" + tableData[i].pesoTotal + "</td>";
                            tcompleta += "<td colspan='4'>" + tableData[i].nombrePlano + "</td>";
                            tcompleta += "</tr>";
                        }
                        rptTemplate = rptTemplate.replace('vrImagen', "<img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' />");
                        rptTemplate = rptTemplate.replace('vrFecha', f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                        tablatmp = rptTemplate.replace('vrDetalle', tcompleta);
                        var tmpElemento = document.createElement('a');
                        var data_type = 'data:application/vnd.ms-excel';
                        tabla_html = tablatmp.replace(/ /g, '%20');
                        tmpElemento.href = data_type + ', ' + tabla_html;
                        //Asignamos el nombre a nuestro EXCEL
                        tmpElemento.download = 'Orden_Embarque.xls';
                        // Simulamos el click al elemento creado para descargarlo
                        tmpElemento.click();
                    }).fail(function () {
                        CMI.DespliegaError("No se pudo cargar la informacion detalle de la Orden de embarques");
                    });
                });
            }); //$.get(templateURL
        }
        else {
            CMI.DespliegaError("Favor de seleccionar orden de embarque para imprimir");
        }
    }
};

$(function () {
    OrdenEmbarque.Inicial();
});