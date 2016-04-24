//js de catalogo de Requisicion Manual de compra.
//David Galvan
//17/Febrero/2016
var json;
var OrdenEmbarque = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridOrdenEmbarque: {},
    colOrdenEmbarque: {},
    colOrigenReq: [],
    colUnidadMedida: [],
    colOrden: [],
    colAlmacen: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
        this.CargarColeccionOrden();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnImprimir").click(that.onImprimir);
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-AgregarMarca', that.onAgregar);
        $("#idOrdenEmb").change(that.onCambiaOrden);
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

        $(document).on('click', '.accrowClonar', function () {
            that.Clonar($(this).parent().parent().attr("data-modelId"));
        });
    },
    onCambiaOrden: function () {

        if ($('#idOrdenEmb').val() == 'undefined') {
            $('#bbGrid-OrdenEmbarque')[0].innerHTML = '';
            OrdenEmbarque.CargaGrid($('#idOrdenEmb').val());
        }
        else {
            $('#bbGrid-OrdenEmbarque')[0].innerHTML = '';
            OrdenEmbarque.CargaGrid($('#idOrdenEmb').val());
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_orden_embarque.html";
        var rptTemplate = '';
        var tabla_html;
        var tablatmp = '';
        var tableData;
        var tablaheader;
        var total = 0;
        var tcompleta = ''
        var f = new Date();
        if ($('#idOrdenEmb').val() != "undefined") {
        $.get(templateURL, function (data) { rptTemplate = data; });
        var urlHeader = contextPath + "OrdenEmbarque/CargaHeaderOrdeEmb?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idOrden=" + $('#idOrdenEmb').val(); // El url del controlador
        $.getJSON(urlHeader, function (data) {
            tablaheader = data;
            for (j = 0; j < tablaheader.length; j++) {
                rptTemplate = rptTemplate.replace('vrEtapaNom', tablaheader[j]['NombreEtapa']);
                rptTemplate = rptTemplate.replace('vrRevison', tablaheader[j]['Revision']);
                rptTemplate = rptTemplate.replace('vrProyecto', tablaheader[j]['NombreProyecto']);
                rptTemplate = rptTemplate.replace('vrFolio', tablaheader[j]['idOrdenEmb']);
                rptTemplate = rptTemplate.replace('vrCodigo', tablaheader[j]['Codigo']);
            }
       
            var url = contextPath + "OrdenEmbarque/CargaOrdenEmbarque?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idOrden=" + $('#idOrdenEmb').val(); // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td colspan='2'>" + tableData[i]['NombreMarca'] + "</td>";
                    tcompleta += "<td colspan='2'>" + tableData[i]['Piezas'] + "</td>";
                    tcompleta += "<td colspan='2'>" + tableData[i]['Peso'] + "</td>";
                    tcompleta += "<td colspan='3'>" + tableData[i]['Total'] + "</td>";
                    tcompleta += "<td colspan='4'>" + tableData[i]['NombrePlano'] + "</td>";
                    tcompleta += "</tr>";
                   // total += (tableData[i]['Total']);
                  
                }
                
               // rptTemplate = rptTemplate.replace('vrTotal', total);
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

                //getJSON fail
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
            });
        });
        }
        else {
            CMI.DespliegaError("Favor de seleccionar orden de embarque para imprimir");
        }

    },
    onAgregar: function (e) {
        var btn = this;

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "OrdenEmbarque/Nuevo",
                $("#NuevoOrdenEmbarqueForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
   
                        $('#bbGrid-MarcasAgregar')[0].innerHTML = '';

                        OrdenEmbarque.CargaGridMarca($('#idProyectoSelect').val() , $('#idEtapaSelect').val());

                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al guardar la informacion");

                }).always(function () { CMI.botonMensaje(false, btn, 'Agregar'); });

        } else {
            CMI.botonMensaje(false, btn, 'Agregar');
        }
    },
    onGuardar: function () {
        $('#nuevo-OrdenEmbarque').modal('hide');
        $('#bbGrid-OrdenEmbarque')[0].innerHTML = '';
        OrdenEmbarque.CargaGrid();
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
    onBuscarMarca: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/BuscarMarca"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-marca').html(data);
            $('#buscar-marca').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            MarcaBuscar.idProyecto = $('#idProyectoSelect').val();
            MarcaBuscar.idEtapa = $('#idEtapaSelect').val();
            MarcaBuscar.parent = OrdenEmbarque;
            MarcaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Marcas");
        }).always(function () { $(btn).removeAttr("disabled"); });
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
        //$('#bbGrid-PlanosMontaje')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
      //  $('#nombreEtapa').text('');
      //  $('#FechaInicioEtapa').text('');
      //  $('#FechaFinEtapa').text('');
        $('.btnNuevo').hide();
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        };

        $('#etapaRow').show();       
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);       
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        //Se carga el grid de PlanosMontaje asignadas a la etapa
       // $('#bbGrid-PlanosMontaje')[0].innerHTML = "";
        //  ReqMCompra.CargaGrid();
        $('.btnNuevo').show();
        OrdenEmbarque.CargaGrid();
        if ($('#idEtapaSelect').val(idEtapa) !== null) {
            $('#NombreEt').show();
            $('#FechaInicioEt').show();
            $('#FechaFinEt').show();
        };
        $('#myCollapsible').collapse('hide');
        $("#btn").addClass("glyphicon-plus");
        $('#btnCollapse').show();
        $('#rowOrdenEmbarque').show();
        $('#Imprimir').show();
    },
    AsignaMarca: function (id) {
        $('#idMarca').val(id);
        $('#idMarcaSelect').val(id);
        $('#buscar-marca').modal('hide');
    },
    CargarColeccionOrden: function () {
        var form = OrdenEmbarque.activeForm;
        if (OrdenEmbarque.colOrden.length < 1) {
            var url = contextPath + "OrdenEmbarque/CargaOrdenes/"; // El url del controlador
            $.getJSON(url, function (data) {
                OrdenEmbarque.colOrden = data;
                var select = $(form + ' #idOrdenEmb').empty();

                select.append('<option value="undefined">Selecciona Orden</option>');

                $.each(OrdenEmbarque.colOrden, function (i, item) {
                    select.append('<option value="'
                                         + item.idOrdenEmb
                                         + '">'
                                         + item.idOrdenEmb
                                         + '</option>');
                });

                $(form + '#idOrdenEmb').val($(form + '#idOrdenEmb').val());
                // MovtoMaterial.CargaListaMovtoM(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de ordenes de embarque");

            });
        } else {
            OrdenEmbarque.CargaListaOrden(form);
        }
    },
    CargaListaOrden: function (form) {
        var select = $(form + ' #idOrdenEmb').empty();

        select.append('<option> </option>');

        $.each(OrdenEmbarque.colOrden, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.idDocumento
                                 + '</option>');
        });

        $(form + '#idOrdenEmb').val($(form + '#idOrdenEmb').val());
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
                        $('#idProyecto').val($('#idProyectoSelect').val());
                        $('#idEtapa').val($('#idEtapaSelect').val());
                        $('#Revision').val($('#RevisionPro').text());
                        OrdenEmbarque.activeForm = '#NuevoOrdenEmbarqueForm';
                        $(OrdenEmbarque.activeForm + ' #btnBuscarMarca').click(OrdenEmbarque.onBuscarMarca);
                    });
    },
        
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = OrdenEmbarque;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    CargaGrid: function () {
        var url = contextPath + "OrdenEmbarque/CargaOrdenEmbarque?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idOrden=" + $('#idOrdenEmb').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            OrdenEmbarque.colOrdenEmbarque = new Backbone.Collection(data);
            var bolFilter = OrdenEmbarque.colOrdenEmbarque.length > 0 ? true : false;
            if (bolFilter) {
                gridOrdenEmbarque = new bbGrid.View({
                    container: $('#bbGrid-OrdenEmbarque'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: OrdenEmbarque.accClonar,
                    editar: OrdenEmbarque.accEscritura,
                    borrar: OrdenEmbarque.accBorrar,
                    collection: OrdenEmbarque.colOrdenEmbarque,
                    seguridad: OrdenEmbarque.accSeguridad,
                    colModel: [{ title: '#', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proyecto', name: 'NombreProyecto', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Etapa', name: 'idEtapa', filter: true, filterType: 'input' },
                               { title: 'Nombre de pieza(marca)', name: 'NombreMarca', filter: true, filterType: 'input' },
                               { title: '#Piezas', name: 'Piezas', filter: true, filterType: 'input' },
                               { title: 'Peso C/U', name: 'Peso', filter: true, filterType: 'input' },
                               { title: 'Peso Total', name: 'Total', filter: true, filterType: 'input' },
                               { title: 'Nombre Plano', name: 'NombrePlano', filter: true, filterType: 'input' }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontro información");
                $('#bbGrid-OrdenEmbarque')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de Orden de Embarque");
        });
    },
    CargaGridMarca: function () {
        var url = contextPath + "OrdenEmbarque/CargaOrdenEmbarque?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            OrdenEmbarque.colOrdenEmbarque = new Backbone.Collection(data);
            var bolFilter = OrdenEmbarque.colOrdenEmbarque.length > 0 ? true : false;
            if (bolFilter) {
                gridOrdenEmbarque = new bbGrid.View({
                    container: $('#bbGrid-MarcasAgregar'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: OrdenEmbarque.accClonar,
                    editar: OrdenEmbarque.accEscritura,
                    borrar: OrdenEmbarque.accBorrar,
                    collection: OrdenEmbarque.colOrdenEmbarque,
                    seguridad: OrdenEmbarque.accSeguridad,
                    colModel: [{ title: '#', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proyecto', name: 'NombreProyecto', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Etapa', name: 'idEtapa', filter: true, filterType: 'input' },
                               { title: 'Nombre de pieza(marca)', name: 'NombreMarca', filter: true, filterType: 'input' },
                               { title: '#Piezas', name: 'Piezas', filter: true, filterType: 'input' },
                               { title: 'Peso C/U', name: 'Peso', filter: true, filterType: 'input' },
                               { title: 'Peso Total', name: 'Total', filter: true, filterType: 'input' },
                               { title: 'Nombre Plano', name: 'NombrePlano', filter: true, filterType: 'input' }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontro información");
                $('#bbGrid-MarcasAgregar')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de Orden de Embarque");
        });
    }
};

$(function () {
    OrdenEmbarque.Inicial();
})