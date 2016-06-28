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
    colRequisiciones: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
        $(window).resize(ReqMCompra.AjustaModal);
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarReq").click(that.onBuscarRequerimiento);
        $("#btnImprimir").click(that.onImprimir);
        $(document).on("click", '.btn-AgregarMaterial', that.onAgregar);
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-ActualizarMaterialRequi', that.onActualizar);
        $(document).on("change", '#Origen', that.onCambiaOrigen);
        $("#idReq").change(that.onCambiaRequisicion);
        $('#etapaRow').hide();
        $('#btnCollapse').hide();
        $('#Imprimir').hide();
        $('#CausaDiv').hide();

        //Eventos de los botones de Acciones del grid
        $(document).on('click', '.accrowEdit', function () {
            that.Editar($(this).parent().parent().attr("data-modelId"));
        });

        $(document).on('click', '.accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
        });
    },
    onCambiaOrigen: function () {

        if ($('#Origen').val() == 2) {
            $('#CausaDiv').show();
        }
        else {
            $('#CausaDiv').hide();
        }
    },
    onCambiaRequisicion: function () {

        if ($('#idReq').val() == '') {
            //$('#CausaDiv').show();
        }
        else {
            $('#bbGrid-ReqManualCompras')[0].innerHTML = '';
            ReqMCompra.CargaGrid($('#idReq').val());
            $('#Imprimir').show();
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
        var tcompleta = ''
        var f = new Date();

        $.get(templateURL, function (data) {

            rptTemplate = data;
            var urlHeader = contextPath + "ReqManualCompra/CargaInfoRequisicion?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador

            $.getJSON(urlHeader, function (data) {
                tablaheader = data;
                for (j = 0; j < tablaheader.length; j++) {
                    rptTemplate = rptTemplate.replace('vrEtapa', 'ETAPA #' + tablaheader[j]['idEtapa']);
                    rptTemplate = rptTemplate.replace('vrDesEtapa', tablaheader[j]['NombreEtapa']);
                    rptTemplate = rptTemplate.replace('vrNoPro', tablaheader[j]['id']);
                    rptTemplate = rptTemplate.replace('vrNombrePro', tablaheader[j]['NombreProyecto']);
                    rptTemplate = rptTemplate.replace('vrFolioReq', $('#idReq').val());
                    rptTemplate = rptTemplate.replace('vrDepto', tablaheader[j]['NombreDepto']);
                    rptTemplate = rptTemplate.replace('vrSolicita', tablaheader[j]['NomnreUsuario']);
                }

                var url = contextPath + "ReqManualCompra/CargaDetalleManual?idRequerimiento=" + $('#idRequerimientoSelect').val() + "&idRequisicion=" + $('#idReq').val(); // El url del controlador
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
                        tcompleta += "<td>" + tableData[i]['Largo'] * 0.3048 + "</td>";
                        tcompleta += "<td>" + tableData[i]['Peso'] + "</td>";
                        tcompleta += "<td>" + tableData[i]['Cantidad'] * (tableData[i]['Largo'] * 0.3048) * tableData[i]['Peso'] + "</td>";
                        tcompleta += "</tr>";
                        total += (tableData[i]['Cantidad'] * (tableData[i]['Largo'] * 0.3048) * tableData[i]['Peso']);

                    }

                    rptTemplate = rptTemplate.replace('vrTotal', total);
                    rptTemplate = rptTemplate.replace('vrFecha', f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                    rptTemplate = rptTemplate.replace('vrImagen', "<img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' />");
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
        });
    },
    onGuardar: function () {
        $('#nuevo-ReqManualCompra').modal('hide');
        $('#idReq').empty();
            var formRequisicion = ReqMCompra.activeForm;
            var ultimo = 0;
                var url = contextPath + "ReqManualCompra/CargaRequisiciones?idEtapa=" + $('#idEtapaSelect').val() + '&idProyecto=' + $('#idProyectoSelect').val() + '&idRequerimiento=' + $('#idRequerimientoSelect').val(); // El url del controlador
                $.getJSON(url, function (data) {
                    ReqMCompra.colRequisiciones = data;

                    var select = $('#idReq').empty();

                    select.append('<option> </option>');

                    $.each(ReqMCompra.colRequisiciones, function (i, item) {
                        select.append('<option value="'
                                             + item.id
                                             + '">'
                                             + item.id + ' - ' + item.NombreOrigen
                                             + '</option>');

                        ultimo = item.id;
                    });

                    $('#idReq').val($('#idReq').val());
                    $("#idReq").val(ultimo).change();

                }).fail(function (e) {
                    CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de Requisiciones");
                });
    },
    onAgregar: function (e) {
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
                    if (data.Success == true) {
                        if (data.id === "0") {
                            CMI.DespliegaErrorDialogo("Ya existe una requisicion de tipo Inicial, favor de validarlo");
                        } else {
                            $('#bbGrid-MatRequi')[0].innerHTML = '';
                            $('#idRequisicion').val(data.id);
                            $('#idRequi').text(data.id);
                            ReqMCompra.CargaGridReq(data.id);
                            ReqMCompra.AjustaModal();
                        }
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
                        $('#bbGrid-ReqManualCompras')[0].innerHTML = '';
                        ReqMCompra.CargaGrid($('#idReq').val());
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
        $('#idEtapaSelect').val(0);
        $('.btnNuevo').hide();
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        };
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');

        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');


        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";
        $('#Imprimir').hide();
        $('#etapaRow').show();       
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);       
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        $('.btnNuevo').hide();
        if ($('#idEtapaSelect').val(idEtapa) !== null) {
            $('#NombreEt').show();
            $('#FechaInicioEt').show();
            $('#FechaFinEt').show();
        };

        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');


        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";
        $('#Imprimir').hide();
        $('#requerimientoRow').show();
  
    },
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento, fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');
        $('#rowRequisicion').show();
        //Se carga el grid de ReqMatGral asignadas a la etapa
        // $('#bbGrid-ReqMatGral')[0].innerHTML = "";
        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";
        ReqMCompra.CargarColeccionRequisiciones();
    

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
                       AnchoMaterial, LargoMaterial, 
		       PesoMaterial, CalidadMaterial, 
		       AnchoUM) {
        $('#idMaterialSelect').val(id);
        $('#NombreMat').val(NombreMaterial);
        $('#AnchoMat').val(AnchoMaterial);
        $('#LongitudMat').val(LargoMaterial);
        $('#CalidadAcero').val(CalidadMaterial);
        $('#PesoMat').val(PesoMaterial);
        $('#Unidad').val(AnchoUM);
        $('#buscar-Material').modal('hide');    
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

        $(form + ' #Unidad').val($(form + ' #unid').val());
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

        $(form + ' #Almacen').val($(form + ' #alm').val());
    },
    CargarColeccionRequisiciones: function () {
        var formRequisicion = ReqMCompra.activeForm;
        if (ReqMCompra.colRequisiciones.length < 1) {
            var url = contextPath + "ReqManualCompra/CargaRequisiciones?idEtapa=" + $('#idEtapaSelect').val() + '&idProyecto=' + $('#idProyectoSelect').val() + '&idRequerimiento=' + $('#idRequerimientoSelect').val(); // El url del controlador
            $.getJSON(url, function (data) {
                ReqMCompra.colRequisiciones = data;
                ReqMCompra.CargaListaRequisiciones(formRequisicion);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de Requisiciones");
            });
        } else {
            ReqMCompra.CargaListaRequisiciones(formRequisicion);
        }
    },
    CargaListaRequisiciones: function (formRequisicion) {
        var select = $(formRequisicion + ' #idReq').empty();

        select.append('<option> </option>');

        $.each(ReqMCompra.colRequisiciones, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.id + ' - ' + item.NombreOrigen
                                 + '</option>');
        });

        $(formRequisicion + '#idReq').val($(formRequisicion + '#idReq').val());
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "ReqManualCompra/Nuevo"; // El url del controlador   
  
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
                        ReqMCompra.CargarColeccionOrigenReq();
                        ReqMCompra.CargarColeccionAlmacen();
                    });
    },
    AjustaModal: function() {
        var altura = $(window).height() - 155; 
        $(".ativa-scroll").css({"height":altura,"overflow-y":"auto"});
    },
    Editar: function (idRow) {
        var id, idRequerimiento, row, idRequisicion;
    CMI.CierraMensajes();
        //Se toma de la colleccion el renglon seleccionado
    row = ReqMCompra.colReqMCompra.get(idRow);
        //Se toman los valores de la coleccion
    id = row.attributes.id;
    idRequerimiento = $('#idRequerimientoSelect').val();
    idRequisicion = $('#idReq').val();
    var url = contextPath + "ReqManualCompra/Actualiza"; // El url del controlador
    $.get(url, { id: id, idRequerimiento: idRequerimiento, idRequisicion: idRequisicion }, function (data) {
        $('#actualiza-ReqManualCompra').html(data);
        $('#actualiza-ReqManualCompra').modal({
            backdrop: 'static',
            keyboard: true
        }, 'show');
        ReqMCompra.activeForm = '#ActualizarReqManualCompraForm';
        ReqMCompra.CargarColeccionUnidadMedida();
        ReqMCompra.CargarColeccionAlmacen();
        CMI.RedefinirValidaciones();
    });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "ReqManualCompra/Borrar"; // El url del controlador
        $.post(url, { id: id, idRequisicion: $('#idReq').val() }, function (data) {
            if (data.Success == true) {
                ReqMCompra.colReqMCompra.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el material asignado"); });
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
            'nombreMaterial': $(form + ' #NombreMat').text(),
            'Unidad': $('#Unidad option:selected').text().toUpperCase(),
            'Calidad': $(form + ' #CalidadAcero').text(),
            'Ancho': $(form + ' #AnchoMat').text(),
            'Largo': $(form + ' #LongitudMat').text(),
            'Cantidad': $(form + ' #Cantidad').val(),
            'Peso': $(form + ' #PesoMat').text(),
            'id': id
        });
        },
    CargaGrid: function (id) {
        var url = contextPath + "ReqManualCompra/CargaDetalleManual?idRequerimiento=" + $('#idRequerimientoSelect').val() + "&idRequisicion=" + id; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            ReqMCompra.colReqMCompra = new Backbone.Collection(data);
            var bolFilter = ReqMCompra.colReqMCompra.length > 0 ? true : false;
            if (bolFilter) {
                gridReqCompra = new bbGrid.View({
                    container: $('#bbGrid-ReqManualCompras'),
                    enableTotal: true,
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    editar: ReqMCompra.accEscritura,
                    borrar: ReqMCompra.accBorrar,
                    collection: ReqMCompra.colReqMCompra,
                    colModel: [{ title: 'Item', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterialSelect', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Unidad', name: 'Unidad', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input', total: 0 },
                               { title: 'Peso', name: 'Peso', filter: true, total: 0 }]
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
    },
    CargaGridReq: function (id) {
        var url = contextPath + "ReqManualCompra/CargaDetalleManual?idRequerimiento=" + $('#idRequerimientoSelect').val() + "&idRequisicion="+ id; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            ReqMCompra.colReqMCompra = new Backbone.Collection(data);
            var bolFilter = ReqMCompra.colReqMCompra.length > 0 ? true : false;
            if (bolFilter) {
                gridReqCompra = new bbGrid.View({
                    container: $('#bbGrid-MatRequi'),
                    rows: 5,
                    rowList: [5, 15, 25, 50, 100],
                    enableTotal: true,
                    enableSearch: false,
                    actionenable: false,
                    borrar: ReqMCompra.accBorrar,
                    collection: ReqMCompra.colReqMCompra,
                    colModel: [{ title: 'Item', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterialSelect', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Unidad', name: 'Unidad', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input', total: 0 },
                               { title: 'Peso', name: 'Peso', filter: true, total: 0 }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales registradas para el requerimeinto seleccionado.");
                $('#bbGrid-MatRequi')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las ReqManualCompras");
        });
    }
};

$(function () {
    ReqMCompra.Inicial();
});