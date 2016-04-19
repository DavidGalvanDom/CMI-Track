//js de Recepcion Requisicion de compra
//David Jasso
//28/Marzo/2016
var json;
var RecepecionCompra = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridRecepcionCompra: {},
    colRecepecionCompra: {},
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
        $(document).on("click", '.btn-ActualizarCantidadRecibida', that.onActualizar);
        $('#etapaRow').hide();
        $('#btnCollapse').hide();
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
            ProyectoBuscar.parent = RecepecionCompra;
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
            EtapaBuscar.parent = RecepecionCompra;
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
            RequerimientoBuscar.parent = RecepecionCompra;
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
            RequisicionesBuscar.parent = RecepecionCompra;
            RequisicionesBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Requisiciones");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onActualizar: function (e) {
        var btn = this;
        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $('#Serie').val($('#SerieFac').val());
            $('#Factura').val($('#FacturaReq').val());
            $('#Proveedor').val($('#ProveedorFac').val());
            $('#FechaFac').val($('#FechaFactura').val());
    
            if ($('#cantidadSol').val() == $('#cantidadRecibida').val() ) {
                //Se hace el post para guardar la informacion
                $.post(contextPath + "RecepcionRequisicion/Actualiza",
                    $("#ActualizarRecepcionRequisicionForm *").serialize(),
                    function (data) {
                        if (data.Success == true) {
                            $('#asigna-recibido').modal('hide');
                            CMI.DespliegaInformacion('El cantidad recibidad fue Actualizada. Item:' + data.id);
                            $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = '';
                            RecepecionCompra.CargaGrid();
                        } else {
                            CMI.DespliegaErrorDialogo(data.Message);
                        }
                    }).fail(function () {
                        CMI.DespliegaErrorDialogo("Error al actualizar la informacion");
                    }).always(function () { CMI.botonMensaje(false, btn, 'Actualizar'); });
            } else {
                CMI.DespliegaErrorDialogo("La cantidad recibida debe ser igual a la cantidad solicitada");
                CMI.botonMensaje(false, btn, 'Actualizar');
            }
    
           

        } else {

            CMI.botonMensaje(false, btn, 'Guardar');
        }

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
        //  RecepecionCompra.CargaGrid();
        $('#requerimientoRow').show();

    },
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento, fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');

        //Se carga el grid de ReqMatGral asignadas a la etapa
        // $('#bbGrid-ReqMatGral')[0].innerHTML = "";
    
 
        ///Muestra el boton de nueva ReqMatGral
        if (RecepecionCompra.accEscritura === true)

        $('#requisicionRow').show();
    },
    AsignaRequisicion: function (id, NombreOrigen, Causa, Estatus, Serie, Factura, Proveedor, FechaFac) {

        $('#idRequisicion').text(id);
        $('#idRequisicionSelect').val(id);
        $('#OrigenReq').text(NombreOrigen);
        $('#Causa').text(Causa);
        $('#Estatus').text(Estatus);
        $('#SerieFac').val(Serie);
        $('#FacturaReq').val(Factura);
        $('#ProveedorFac').val(Proveedor);
        $('#FechaFactura').val(FechaFac);
        $('#buscar-General').modal('hide');
      
        //Se carga el grid de ReqMatGral asignadas a la etapa
        // $('#bbGrid-ReqMatGral')[0].innerHTML = "";
        RecepecionCompra.CargaGrid();
        RecepecionCompra.IniciaDateControls();
        ///Muestra el boton de nueva ReqMatGral

      
        
        $('#myCollapsible').collapse('hide');
        $('#btnCollapse').show();
        $('#requisicionRow').show();

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = RecepecionCompra;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    IniciaDateControls: function () {
        var form = RecepecionCompra.activeForm;
        $(form + ' #dtpFechaFactura').datetimepicker({ format: 'MM/DD/YYYY' });
    },
    onSeleccionar: function (idRow) {
        var rowSelected = RecepecionCompra.colRecepecionCompra.get(idRow);
        var canSolicitada = rowSelected.attributes.cantidadSol;
        var canRec = rowSelected.attributes.cantidadRecibida;
        var idMaterial = rowSelected.attributes.idMaterial;
        var Material = rowSelected.attributes.nombreMaterial;
        var Ancho = rowSelected.attributes.Ancho;
        var Largo = rowSelected.attributes.Largo;
        var Peso = rowSelected.attributes.Peso;
        var Calidad = rowSelected.attributes.Calidad;
        var Existencia = rowSelected.attributes.Existencia;
        var idRequerimiento = $('#idRequerimientoSelect').val();
        var idRequisicion = $('#idRequisicionSelect').val();
        if (canRec == 0) {
        if ($('#SerieFac').val() !== '' && $('#FacturaReq').val() !== '' && $('#ProveedorFac').val() !== '' && $('#FechaFactura').val() !== '') {
            // $('#asigna-recibido').show();
            var url = contextPath + "RecepcionRequisicion/Actualiza"; // El url del controlador      
            $.get(url, function (data) {
                $('#asigna-recibido').html(data);
                $('#asigna-recibido').modal({
                    backdrop: 'static',
                    keyboard: true
                }, 'show');

             
                $('#idMaterialR').val(idMaterial);
                $('#idItem').val(rowSelected.attributes.id);
                $('#idRequerimiento').val(idRequerimiento);
                $('#idRequisicionF').val(idRequisicion);
                $('#nombreMat').val(Material);
                $('#Ancho').val(Ancho);
                $('#Largo').val(Largo);
                $('#Peso').val(Peso);
                $('#Calidad').val(Calidad);
                $('#Existencia').val(Existencia);
                $('#cantidadSol').val(canSolicitada);
                $('#cantidadRec').val(canRec);
                CMI.RedefinirValidaciones(); //para los formularios dinamicos
            });

        } else {
            CMI.DespliegaError("La información de la factura esta incompleta");
        }
        } else {
            CMI.DespliegaError("La cantidad ya fue recibida, favor de verificarlo");
        }
 
    },
    CargaGrid: function () {
        var url = contextPath + "RecepcionRequisicion/CargaDetalleRequisicion?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val() + '&idRequerimiento=' + $('#idRequerimientoSelect').val() + '&idRequisicion=' + $('#idRequisicionSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            $('#DatosFactura').show();
   
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            RecepecionCompra.colRecepecionCompra = new Backbone.Collection(data);
            var bolFilter = RecepecionCompra.colRecepecionCompra.length > 0 ? true : false;
            if (bolFilter) {
                gridRecepcionCompra = new bbGrid.View({
                    container: $('#bbGrid-DetalleRequisicionCompras'),
                    rows: 5,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: RecepecionCompra.accClonar,
                    editar: RecepecionCompra.accEscritura,
                    borrar: RecepecionCompra.accBorrar,
                    collection: RecepecionCompra.colRecepecionCompra,
                    seguridad: RecepecionCompra.accSeguridad,
                    colModel: [{ title: 'Item', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterial', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMaterial', filter: true, filterType: 'input' },
                               { title: 'Unidad', name: 'UM', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'Cantidad Solicitada', name: 'cantidadSol', filter: true, filterType: 'input' },
                               { title: 'Existencia', name: 'Existencia', filter: true, filterType: 'input' },
                               { title: 'Recibido', name: 'cantidadRecibida', filter: true, filterType: 'input' },
                               { title: ' Long(m)-Area(m2)', name: 'LongArea', filter: true, filterType: 'input' },
                               { title: 'kg/m-kg/m2', name: 'Peso', filter: true, filterType: 'input' },
                               { title: 'Total', name: 'Total', filter: true }],
                    onRowDblClick: function () {
                        RecepecionCompra.onSeleccionar(this.selectedRows[0]);
                    }
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales registradas para la requisición seleccionada.");
                $('#bbGrid-DetalleRequisicionCompras')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las ReqManualCompras");
        });
    }
};

$(function () {
    RecepecionCompra.Inicial();
})