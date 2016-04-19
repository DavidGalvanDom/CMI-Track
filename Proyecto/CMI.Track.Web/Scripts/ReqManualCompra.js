//js de catalogo de Requisicion Manual de compra.
//David Galvan
//17/Febrero/2016
var json;
var ReqMCompra = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridReqCompra: {},
    colReqMCompra: {},
    colOrigenReq: [],
    colUnidadMedida: [],
    colAlmacen: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
        
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarReq").click(that.onBuscarRequerimiento);
        $("#btnImprimir").click(that.onImprimir);
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarMaterialRequi', that.onActualizar);
        $("#Origen").change(that.onCambiaOrigen);
        
        $('#etapaRow').hide();
        $('#btnCollapse').hide();
        $('#Imprimir').hide();
        $('#OrigenDiv').hide();
        $('#CausaDiv').hide();

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
    onCambiaOrigen: function () {

        if ($('#Origen').val() == 3) {
            $('#CausaDiv').show();
        }
        else {
            $('#CausaDiv').hide();
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_requisicion_manual.html";
        var rptTemplate = '';
        var tabla_html;
        var tablatmp = '';
        var tableData;
        var tablaheader;
        var total = 0;
        var f = new Date();
        var tcompleta = ''
        var urlImagen = window.location.protocol + '//' + window.location.host + '//Content/images/CMI.TRACK.reportes.png';
        var f = new Date();
        $.get(templateURL, function (data) { rptTemplate = data; });
        var urlHeader = contextPath + "ReqManualCompra/CargaInfoRequisicion?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
        $.getJSON(urlHeader, function (data) {
            tablaheader = data;
            for (j = 0; j < tablaheader.length; j++) {
                rptTemplate = rptTemplate.replace('vrEtapa', 'ETAPA #'+ tablaheader[j]['idEtapa']);
                rptTemplate = rptTemplate.replace('vrDesEtapa', tablaheader[j]['NombreEtapa']);
                rptTemplate = rptTemplate.replace('vrNoPro', tablaheader[j]['id']);
                rptTemplate = rptTemplate.replace('vrNombrePro', tablaheader[j]['NombreProyecto']);
                rptTemplate = rptTemplate.replace('vrFolioReq', tablaheader[j]['FolioRequerimiento']);
                rptTemplate = rptTemplate.replace('vrDepto', tablaheader[j]['NombreDepto']);
                rptTemplate = rptTemplate.replace('vrSolicita', tablaheader[j]['NomnreUsuario']);
            }
       
            var url = contextPath + "ReqManualCompra/CargaDetalleManual?idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td></td>";
                    tcompleta += "<td>" + tableData[i]['Cantidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Unidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['nombreMaterial'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Calidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Ancho'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Largo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Largo'] *0.3048 + "</td>";
                    tcompleta += "<td>" + tableData[i]['Peso'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Cantidad'] * (tableData[i]['Largo'] * 0.3048) * tableData[i]['Peso'] + "</td>";
                    tcompleta += "</tr>";
                    total += (tableData[i]['Cantidad'] * (tableData[i]['Largo'] * 0.3048) * tableData[i]['Peso']);
                  
                }
                
                rptTemplate = rptTemplate.replace('vrTotal', total);
                rptTemplate = rptTemplate.replace('vrImagen', urlImagen);
                tablatmp = rptTemplate.replace('vrDetalle', tcompleta);
                var tmpElemento = document.createElement('a');
                var data_type = 'data:application/vnd.ms-excel';
               tabla_html = tablatmp.replace(/ /g, '%20');
                tmpElemento.href = data_type + ', ' + tabla_html;
                //Asignamos el nombre a nuestro EXCEL
                tmpElemento.download = 'Requisicion.xls';
                // Simulamos el click al elemento creado para descargarlo
                tmpElemento.click();

                //getJSON fail
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
            });
        });


    },
    onGuardar: function () {
        var form = ReqMCompra.activeForm,
            btn = this;
        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $(form + ' #idRequerimiento').val($('#idRequerimientoSelect').val());
            $(form + ' #idMaterialSelect').val($('#idMaterialSelect').val());
            $(form + ' #Causa').val($('#Causa').val());
            $(form + ' #Origen').val($('#Origen').val());
            //Se hace el post para guardar la informacion
            $.post(contextPath + "ReqManualCompra/Nuevo",
                $("#NuevoReqManualCompraForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        ReqMCompra.colReqMCompra.add(ReqMCompra.serializaManualCompra(data.id));
                        CMI.DespliegaInformacion('El Item fue guardado con el Id: ' + data.id);
                        $('#nuevo-ReqManualCompra').modal('hide');
                        if (ReqMCompra.colReqMCompra.length === 1) {
                            ReqMCompra.CargaGrid();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                        CMI.botonMensaje(false, btn, 'Guardar');
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
            $.post(contextPath + "ReqManualCompra/Actualiza",
                $("#ActualizarReqManualCompraForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-ReqManualCompra').modal('hide');
                        Categoria.colCategorias.add(Categoria.serializaCategoria(data.id, '#ActualizarReqManualCompraForm'), { merge: true });
                        CMI.DespliegaInformacion('El material fue Actualizado. Id:' + data.id);
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
            ProyectoBuscar.parent = ReqMCompra;
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
            EtapaBuscar.parent = ReqMCompra;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarRequerimiento: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "ReqGralMaterial/BuscarRequerimientos"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            RequerimientoBuscar.idEtapa = $('#idEtapaSelect').val();
            RequerimientoBuscar.idProyecto = $('#idProyectoSelect').val();
            RequerimientoBuscar.parent = ReqMCompra;
            RequerimientoBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Requerimientos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarMaterial: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Material/BuscarMaterial"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-Material').html(data);
            $('#buscar-Material').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            MaterialBuscar.parent = ReqMCompra;
            MaterialBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Materiales");
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
        $('.btnNuevo').hide();
        if ($('#idEtapaSelect').val(idEtapa) !== null) {
            $('#NombreEt').show();
            $('#FechaInicioEt').show();
            $('#FechaFinEt').show();
        };
        $('#requerimientoRow').show();
  
    },
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento, fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');
     
        //Se carga el grid de ReqMatGral asignadas a la etapa
       // $('#bbGrid-ReqMatGral')[0].innerHTML = "";
        ReqMCompra.CargaGrid();
        ReqMCompra.CargarColeccionOrigenReq();
        $('#Imprimir').show();
        $('#OrigenDiv').show();
        //$('#CausaDiv').show();
       // $('#Imprimir').show();
        ///Muestra el boton de nueva ReqMatGral
        if (ReqMCompra.accEscritura === true)
            $('.btnNuevo').show();
        if ($('#idRequerimientoSelect').val(idRequerimiento) !== null) {
            $('#FolioRequerimiento').show();
            $('#FechaSolicitud').show();
        };
        $('#myCollapsible').collapse('hide');
        $("#btn").addClass("glyphicon-plus");
        $('#btnCollapse').show();
        $('#requisicionRow').show();
       
    },
    AsignaMaterial: function (id, NombreMaterial,
                       AnchoMaterial, LargoMaterial,PesoMaterial,CalidadMaterial) {
        $('#idMaterialSelect').val(id);
        $('#NombreMat').val(NombreMaterial);
        $('#AnchoMat').val(AnchoMaterial);
        $('#LongitudMat').val(LargoMaterial);
        $('#CalidadAcero').val(CalidadMaterial);
        $('#PesoMat').val(PesoMaterial);
        $('#buscar-Material').modal('hide');
       
        //Se carga el grid de PlanosMontaje asignadas a la etapa
      //  $('#bbGrid-PlanosMontaje')[0].innerHTML = "";
        //  ReqMCompra.CargaGrid();
      
    
    },
    CargarColeccionOrigenReq: function () {
        var formOrigen = ReqMCompra.activeForm;
        if (ReqMCompra.colOrigenReq.length < 1) {
            var url = contextPath + "OrigenRequisicion/CargaOrigenesRequisicionActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                ReqMCompra.colOrigenReq = data;
                ReqMCompra.CargaListaOrigenReq(formOrigen);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            ReqMCompra.CargaListaOrigenReq(formOrigen);
        }
    },
    CargaListaOrigenReq: function (formOrigen) {
        var select = $(formOrigen + ' #Origen').empty();

        select.append('<option> </option>');

        $.each(ReqMCompra.colOrigenReq, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.NombreOrigenRequisicion
                                 + '</option>');
        });

        $(formOrigen + '#Origen').val($(formOrigen + '#Origen').val());
    },
    CargarColeccionUnidadMedida: function () {
        var form = ReqMCompra.activeForm;
        if (ReqMCompra.colUnidadMedida.length < 1) {
            var url = contextPath + "UnidadMedida/CargaUnidadesMedidaActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                ReqMCompra.colUnidadMedida = data;
                ReqMCompra.CargaListaUnidades(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            ReqMCompra.CargaListaUnidades(form);
        }
    },
    CargaListaUnidades: function (form) {
        var select = $(form + ' #Unidad').empty();

        select.append('<option> </option>');

        $.each(ReqMCompra.colUnidadMedida, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreCortoUnidadMedida
                                 + '</option>');
        });

        $(form + '#Unidad').val($(form + '#Unidad').val());
    },
    CargarColeccionAlmacen: function () {
        var form = ReqMCompra.activeForm;
        if (ReqMCompra.colAlmacen.length < 1) {
            var url = contextPath + "Almacen/CargaAlmacenesActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                ReqMCompra.colAlmacen = data;
                ReqMCompra.CargaListaAlmacenes(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            ReqMCompra.CargaListaAlmacenes(form);
        }
    },
    CargaListaAlmacenes: function (form) {
        var select = $(form + ' #Almacen').empty();

        select.append('<option> </option>');

        $.each(ReqMCompra.colAlmacen, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreAlmacen
                                 + '</option>');
        });

        $(form + '#Almacen').val($(form + '#Almacen').val());
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "ReqManualCompra/Nuevo"; // El url del controlador   
        if ($('#Origen').val() != '')
        {
            if ($('#Origen').val() == 3) {
                if ($('#Causa').val() != '') {
                    $.get(url, function (data) {
                        $('#nuevo-ReqManualCompra').html(data);
                        $('#nuevo-ReqManualCompra').modal({
                            backdrop: 'static',
                            keyboard: true
                        }, 'show');
                        CMI.RedefinirValidaciones(); //para los formularios dinamicos          
                        ReqMCompra.activeForm = '#NuevoReqManualCompraForm';
                        $(ReqMCompra.activeForm + ' #btnBuscarMat').click(ReqMCompra.onBuscarMaterial);
                        ReqMCompra.CargarColeccionUnidadMedida();
                        ReqMCompra.CargarColeccionAlmacen();
                    });
                } else {
                    CMI.DespliegaError("Por favor agregar una causa");
                }                
            }
            else {
                $.get(url, function (data) {
                    $('#nuevo-ReqManualCompra').html(data);
                    $('#nuevo-ReqManualCompra').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                    CMI.RedefinirValidaciones(); //para los formularios dinamicos          
                    ReqMCompra.activeForm = '#NuevoReqManualCompraForm';
                    $(ReqMCompra.activeForm + ' #btnBuscarMat').click(ReqMCompra.onBuscarMaterial);
                    ReqMCompra.CargarColeccionUnidadMedida();
                    ReqMCompra.CargarColeccionAlmacen();
                });
            }
        } else {
            CMI.DespliegaError("Por favor seleccione un Origen");
        }
    },
              Editar: function (idRow) {
                var id, idRequerimiento, row;
            CMI.CierraMensajes();
                //Se toma de la colleccion el renglon seleccionado
            row = ReqMCompra.colReqMCompra.get(idRow);
                //Se toman los valores de la coleccion
            id = row.attributes.id;
            idRequerimiento = $('#idRequerimientoSelect').val();
            var url = contextPath + "ReqManualCompra/Actualiza"; // El url del controlador
            $.get(url, { id: id, idRequerimiento: idRequerimiento }, function (data) {
                $('#actualiza-ReqManualCompra').html(data);
                $('#actualiza-ReqManualCompra').modal({
                    backdrop: 'static',
                    keyboard: true
                }, 'show');
                ReqMCompra.CargarColeccionUnidadMedida();
                ReqMCompra.CargarColeccionAlmacen();
                CMI.RedefinirValidaciones(); //para los formularios dinamicos
            });
        },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = ReqMCompra;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaManualCompra: function (id) {
        var form = ReqMCompra.activeForm;
        return ({
            'idMaterialSelect': $(form + ' #idMaterialSelect').val(),
            'nombreMaterial': $(form + ' #NombreMat').val(),
            'Unidad': $('#Unidad option:selected').text().toUpperCase(),
            'Calidad': $(form + ' #CalidadAcero').val(),
            'Ancho': $(form + ' #AnchoMat').val(),
            'Largo': $(form + ' #LongitudMat').val(),
            'Cantidad': $(form + ' #Cantidad').val(),
            'Peso': $(form + ' #PesoMat').val(),
            'id': id
        });
        },
    CargaGrid: function () {
        var url = contextPath + "ReqManualCompra/CargaDetalleManual?idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            ReqMCompra.colReqMCompra = new Backbone.Collection(data);
            var bolFilter = ReqMCompra.colReqMCompra.length > 0 ? true : false;
            if (bolFilter) {
                gridReqCompra = new bbGrid.View({
                    container: $('#bbGrid-ReqManualCompras'),
                    rows: 5,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: ReqMCompra.accClonar,
                    editar: ReqMCompra.accEscritura,
                    borrar: ReqMCompra.accBorrar,
                    collection: ReqMCompra.colReqMCompra,
                    seguridad: ReqMCompra.accSeguridad,
                    colModel: [{ title: 'Item', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterialSelect', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Unidad', name: 'Unidad', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input' },
                               { title: 'Peso', name: 'Peso', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales registradas para el requerimeinto seleccionado.");
                $('#bbGrid-ReqManualCompras')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las ReqManualCompras");
        });
    }
};

$(function () {
    ReqMCompra.Inicial();
})