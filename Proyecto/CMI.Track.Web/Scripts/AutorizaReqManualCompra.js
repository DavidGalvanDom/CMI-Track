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
        $("#btnBuscarRequisicion").click(that.onBuscarRequisicion);
        $("#Autoriza").click(that.onAutorizar);
        $("#btnAutoriza").click(that.onAutorizar);
        $("#btnRechaza").click(that.onRechazar);

        $('#etapaRow').hide();
        $('#FechaFinEt').hide();
        $('#FechaInicioEt').hide();
        $('#NombreEt').hide();
        $('#FolioRequerimiento').hide();
        $('#FechaSolicitud').hide();
        $('#NombreProyecto').hide();
        $('#revisionPro').hide();
        $('#codigoProyecto').hide();
        $('#fechaInicio').hide();
        $('#fechaFin').hide();
        $('#btnCollapse').hide();
        $('#Autorizar').hide();
        $('#OrigenDiv').hide();
        $('#CausaDiv').hide();
        $('#IDRequisicion').hide();
        $('#OrigenRequi').hide();
        $('#CausaRequi').hide();
        $('#EstatusReq').hide();
    },
    onAutorizar: function () {
 
        var btn = this;

        CMI.botonMensaje(true, btn, 'Autorizar');
        //CMI.CierraMensajes();
        var url = contextPath + "ReqManualCompra/Autoriza", // El url del controlador
            data = 'Autoriza=1' +
                   '&idRequisicion=' + $('#idRequisicionSelect').val() +
                   '&idRequerimiento=' + $('#idRequerimientoSelect').val();
        $.post(url, data, function (result) {
            if (result.Success === true) {
                CMI.DespliegaInformacion('Requisicion Autorizada');
                $('#Autorizar').hide();
            } else {
              //  $(ListaGeneral.activeForm + ' #archivoListaGen').val('');
                CMI.DespliegaError(result.Message);
                CMI.botonMensaje(false, btn, 'Autorizar');
            }
        }).fail(function () {
            CMI.DespliegaError("Error al autorizar la requisición");
        }).always(function () {
            CMI.botonMensaje(false, btn, 'Autorizar');
        });
    },
    onRechazar: function () {
        var btn = this;

        CMI.botonMensaje(true, btn, 'Rechazar');
        //CMI.CierraMensajes();
        var url = contextPath + "ReqManualCompra/Autoriza", // El url del controlador
            data = 'Autoriza=0' +
                   '&idRequisicion=' + $('#idRequisicionSelect').val() +
                   '&idRequerimiento=' + $('#idRequerimientoSelect').val();
        $.post(url, data, function (result) {
            if (result.Success === true) {
                CMI.DespliegaInformacion('Requisicion Rechazada');
                $('#Autorizar').hide();
            } else {
                //  $(ListaGeneral.activeForm + ' #archivoListaGen').val('');
                CMI.DespliegaError(result.Message);
                
                CMI.botonMensaje(false, btn, 'Rechazar');
            }
        }).fail(function () {
            CMI.DespliegaError("Error al rechazar la requisición");
        }).always(function () {
            CMI.botonMensaje(false, btn, 'Rechazar');
        });
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
    onBuscarRequisicion: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "ReqManualCompra/BuscarRequisiciones"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            RequisicionesBuscar.idEtapa = $('#idEtapaSelect').val();
            RequisicionesBuscar.idProyecto = $('#idProyectoSelect').val();
            RequisicionesBuscar.idRequerimiento = $('#idRequerimientoSelect').val();
            RequisicionesBuscar.parent = ReqMCompra;
            RequisicionesBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Requisiciones");
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

        $('#idRequisicion').text('Requisicion');
        $('#OrigenReq').text('Origen');
        $('#Estatus').text('Estatus');
        $('#Causa').text('');

        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";

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
        if ($('#idEtapaSelect').val(idEtapa) !== null) {
            $('#NombreEt').show();
            $('#FechaInicioEt').show();
            $('#FechaFinEt').show();
        };


        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');

        $('#idRequisicion').text('Requisicion');
        $('#OrigenReq').text('Origen');
        $('#Estatus').text('Estatus');
        $('#Causa').text('');

        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";

        $('#requerimientoRow').show();

    },
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento, fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');

        //Se carga el grid de ReqMatGral asignadas a la etapa
        //$('#bbGrid-ReqManualCompras')[0].innerHTML = "";
    
 
        ///Muestra el boton de nueva ReqMatGral
        if (ReqMCompra.accEscritura === true)
        if ($('#idRequerimientoSelect').val(idRequerimiento) !== null) {
            $('#FolioRequerimiento').show();
            $('#FechaSolicitud').show();
        };

        $('#idRequisicion').text('Requisicion');
        $('#OrigenReq').text('Origen');
        $('#Estatus').text('Estatus');
        $('#Causa').text('');

        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";
        $('#requisicionRow').show();
    },
    AsignaRequisicion: function (id, NombreOrigen, Causa, Estatus) {

        $('#idRequisicion').text(id);
        $('#idRequisicionSelect').val(id);
        $('#OrigenReq').text(NombreOrigen);
        $('#Causa').text(Causa);
        $('#Estatus').text(Estatus);
        $('#buscar-General').modal('hide');

        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-ReqManualCompras')[0].innerHTML = "";
        ReqMCompra.CargaGrid();
        ReqMCompra.CargarColeccionOrigenReq();

        ///Muestra el boton de nueva ReqMatGral
        //if (ReqMCompra.accEscritura === true)
        if ($('#idRequisicionSelect').val(id) !== null) {
            $('#IDRequisicion').show();
            $('#OrigenRequi').show();
            $('#CausaRequi').show();
            $('#EstatusReq').show();
           
        }
        if (Estatus == "Autorizada") {
            CMI.DespliegaInformacion('Esta Requisicion se encuentra con estatus Autorizada');
            $('#Autorizar').hide();
        } else if (Estatus == "Rechazada") {
            CMI.DespliegaInformacion('Esta Requisicion se encuentra con estatus Rechazada');
            $('#Autorizar').hide();
        }else{
            $('#Autorizar').show();
        }
      
        
        $('#myCollapsible').collapse('hide');
        $("#btn").addClass("glyphicon-plus");
        $('#btnCollapse').show();
        $('#requisicionRow').show();

    },
    AsignaMaterial: function (id, NombreMaterial,
                       AnchoMaterial, LargoMaterial, PesoMaterial, CalidadMaterial) {
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
        var url = contextPath + "ReqManualCompra/CargaDetalleManual?idRequerimiento=" + $('#idRequerimientoSelect').val() + '&idRequisicion=' + $('#idRequisicionSelect').val(); // El url del controlador
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
                    actionenable: false,
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
                CMI.DespliegaInformacion("No se encontraron Materiales registradas para el requerimiento seleccionado.");
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