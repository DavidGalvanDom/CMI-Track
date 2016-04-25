/*global $, CMI, Backbone, bbGrid*/
//js de Generacion de Embarque Tablet
//David Galvan
//20/Abril/2016
var Remision = {
    activeForm: '',
    origen: '',
    estatusRevision: 0,
    saldo: 0,
    gridEmbarque: {},
    gridOrdenEmbar : {},
    colOrdenEmbar: null,
    colRemisiones: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.origen = $('#origentablet').val();
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);

        $(document).on('click', '.accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
        });

        $('#etapaRow').hide();
    },
    onGuardar: function () {
        var form = Remision.activeForm,
            btn = this,
            contador = 0,
            data ='';
        //Agrega la clase de mandatorio cuando no ha seleccionado un cliente.
        if ($(form + ' #idCliente').val() === "0") {
            $(form + ' #nombreCliente').addClass('input-validation-error');
        }

        if ($("form").valid()) {
            CMI.botonMensaje(true, btn, 'Guardar');
            $('#usuarioCreacion').val(localStorage.idUser);

            if (Remision.colOrdenEmbar == null || Remision.colOrdenEmbar.length < 1) {
                CMI.DespliegaErrorDialogo('Debe seleccionar por lo menos una Orden de embarque');
                CMI.botonMensaje(false, btn, 'Guardar');
                return;
            }

            data = $("#NuevaRemisionForm *").serialize();

            while (Remision.colOrdenEmbar.length > contador) {
                data = data + '&lstOrdenEmbarque=' + Remision.colOrdenEmbar.at(contador).attributes.id;
                contador = contador + 1;
            }
            console.log(data);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "Remision/Nuevo",
                data,
                function (data) {
                    if (data.Success == true) {
                        Remision.colRemisiones.add(Remision.serializaRemision(data.id));
                        CMI.DespliegaInformacion('La Remision fue guardada con el Id: ' + data.id);
                        $('#nuevo-Remision').modal('hide');
                        if (Remision.colRemisiones.length === 1) {
                            Remision.CargaGrid();
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
            ProyectoBuscar.parent = Remision;
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
            EtapaBuscar.parent = Remision;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarOrdenEmbarque: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/BuscarOrdenEmbarque/"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            OrdenEmbarqueBuscar.idProyecto = $('#idProyectoSelect').val();
            OrdenEmbarqueBuscar.revisionProyecto = $('#RevisionPro').text();
            OrdenEmbarqueBuscar.idEtapa = $('#idEtapaSelect').val();
            OrdenEmbarqueBuscar.parent = Remision;
            OrdenEmbarqueBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Ordenes Embarque");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarCliente: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "Cliente/BuscarCliente"; // El url del controlador
        $.get(url, function (data) {
            $('#buscar-Cliente').html(data);
            $('#buscar-Cliente').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            ClienteBuscar.Inicial();
            ClienteBuscar.parent = Remision;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar clietnes");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        Remision.colOrdenEmbar.remove(id);
    },
    AsignaCliente: function (idCliente, nombreClietne,
                            direccionEntrega, contactoCliente) {
        var that = Remision;
        $(that.activeForm + ' #idCliente').val(idCliente);
        $(that.activeForm + ' #contacto').text(contactoCliente);
        $(that.activeForm + ' #direccion').text(direccionEntrega);
        $(that.activeForm + ' #nombreCliente').text(nombreClietne);
        $(that.activeForm + ' #nombreCliente').removeClass('input-validation-error');
        ///Se cierra la ventana de Clientes
        $('#buscar-Cliente').modal('hide');
    },
    AsignaProyecto: function (idProyecto, Revision,
                             NombreProyecto, CodigoProyecto,
                             FechaInicio, FechaFin,
                             idEstatusRevision) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        Remision.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }

        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('.btnNuevo').hide();

        $('#etapaRow').show();

    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');

        $('#idOrdenEmbarSelect').val(0);
        $('#idOrdenEmbarque').text('Orden Embarque');
        $('#idOrdenProduccion').text('Orden Produccion');
        $('#FechaCreacionOE').text('Fecha Creacion');
        $('#Observacion').text('Observacion');
        $('#codBarras').hide();
        $('#ordenEmbarqueRow').show();

        if (Remision.accEscritura === true)
            $('.btnNuevo').show();
    },
    AsignaOrdenEmbarque: function (idOrdenEmbarque, idOrdenProduccion,
                                    observacion, fecha) {
        $('#idOrdenEmbarSelect').val(idOrdenEmbarque);
        $('#idOrdenEmbarque').text(idOrdenEmbarque);
        $('#idOrdenProduccion').text(idOrdenProduccion);
        $('#FechaCreacionOE').text(fecha);
        $('#Observacion').text(observacion);
        $('#buscar-General').modal('hide');
        var data = {
            id: idOrdenEmbarque,
            idOrdenProduccion: idOrdenProduccion,
            fechaCreacion: fecha,
            Observacion: observacion
        };

        if (Remision.colOrdenEmbar === null) {
            Remision.colOrdenEmbar = new Backbone.Collection(data);
            Remision.CargaGridOrdenEmbarque();
        } else {
            Remision.colOrdenEmbar.add(data, { merge: true });
        }

        //Se carga el grid de Remision asignadas a la Orden
        $('#bbGrid-Embarques')[0].innerHTML = "";
        Remision.CargaGrid();
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Remision/Nuevo"; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-Remision').html(data);
            $('#nuevo-Remision').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Remision.activeForm = '#NuevaRemisionForm';
            $(Remision.activeForm + ' #btnBuscarCliente').click(Remision.onBuscarCliente);
            Remision.IniciaDateControls();
            Remision.colOrdenEmbar = null;
        });
    },
    IniciaDateControls: function () {
        var form = Remision.activeForm;
        $(form + ' #dtpFechaEnvio').datetimepicker({ useCurrent: false, format: 'DD/MM/YYYY' });
    },
    ValidaPermisos: function () {

        var permisos = localStorage.modPermisos,
            modulo = Remision;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;

    },
    CargaGrid: function () {
        var url = contextPath + "GenerarEmbarque/CargaDetalleOrden?id=" + $('#idOrdenEmbarSelect').val() + "&tipo=" + Remision.origen; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Remision.colRemisiones = new Backbone.Collection(data);
            var bolFilter = Remision.colRemisiones.length > 0 ? true : false;
            if (bolFilter) {
                Remision.gridEmbarque = new bbGrid.View({
                    container: $('#bbGrid-Embarques'),
                    enableTotal: true,
                    enableSearch: false,
                    detalle: false,
                    collection: Remision.colRemisiones,
                    seguridad: false,
                    colModel: [{ title: 'Orden Embarque', name: 'idOrdenEmbarque', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Proyecto', name: 'nombreProyecto', filter: true, filterType: 'input' },
                               { title: 'Etapa', name: 'claveEtapa', filter: true, filterType: 'input' },
                               { title: 'Nombre Pieza', name: 'nombreMarca', filter: true, filterType: 'input' },
                               { title: 'Pieza', name: 'piezas', filter: true, filterType: 'input', total: 0 },
                               { title: 'Piezas Confir', name: 'piezasLeidas', filter: true, filterType: 'input', total: 0 },
                               { title: 'Saldo', name: 'Saldo', filter: true, filterType: 'input', total: 0 },
                               { title: 'Peso C/U', name: 'peso', filter: true, filterType: 'input' },
                               { title: 'Peso Total', name: 'pesoTotal', filter: true, filterType: 'input', total: 0 },
                               { title: 'Nombre Plano', name: 'nombrePlano', filter: true, filterType: 'input' }]
                });
                $('#cargandoInfo').hide();
                $('#divImprimir').show();
                if (Remision.gridEmbarque.colModel[6].total === 0) {
                    CMI.DespliegaInformacion("La Orden de Embarque ya fue registrada en su totalidad.");
                    $('#codBarras').hide();
                }
            }
            else {
                CMI.DespliegaInformacion("No se encontraron el detalle de la orden de Embarque seleccionada");
                $('#bbGrid-Embarques')[0].innerHTML = "";
                $('#divImprimir').hide();
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de la Orden de Embarque");
        });
    },
    CargaGridOrdenEmbarque: function () {
        var bolFilter = Remision.colOrdenEmbar.length > 0 ? true : false;
        if (bolFilter) {
            Remision.gridOrdenEmbar = new bbGrid.View({
                container: $('#bbGrid-OrdenEmbar'),
                enableSearch: false,
                actionenable: true,
                detalle: false,
                collection: Remision.colOrdenEmbar,
                borrar: Remision.accBorrar,
                editar: false,
                seguridad: false,
                colModel: [{ title: 'Embarque', name: 'id', width: '8%' },
                           { title: 'Produccion', name: 'idOrdenProduccion' },
                           { title: 'Fecha', name: 'fechaCreacion'},
                           { title: 'Observacion', name: 'Observacion'}]
            });
            $('#cargandoInfo').hide();
        }
        else {
            CMI.DespliegaInformacion("No se encontraron Ordees de Embarque");
            $('#bbGrid-OrdenEmbar')[0].innerHTML = "";
        }
    }
};

$(function () {
    Remision.Inicial();
})