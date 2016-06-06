/*global $, CMI, Backbone, bbGrid,ProyectoBuscar,OrdenEmbarqueBuscar,EtapaBuscar,contextPath, ClienteBuscar*/
//js de Generacion de Embarque Tablet
//David Galvan
//20/Abril/2016
var Remision = {
    activeForm: '',
    origen: '',
    estatusRevision: 0,
    saldo: 0,
    gridRemisiones: {},
    gridOrdenEmbar : {},
    colOrdenEmbar: null,
    colRemisiones: {},
    remisionSelected: null,
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
        $(document).on("click", '.btn-Actualizar', that.onActualizar);

        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);

        //Remover Orden de embarque al momento de editar
        $(document).on('click', '.modal-body .accrowBorrar', function () {
            that.BorrarOrden($(this).parent().parent().attr("data-modelId"));
        });

        $(document).on('click', '#bbGrid-Remisiones .accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
        });

        //Editar Remision
        $(document).on('click', '.accrowEdit', function () {
            that.EditarRemision($(this).parent().parent().attr("data-modelId"));
        });

        $('#etapaRow').hide();
    },
    onActualizar: function (){
        var form = Remision.activeForm,
            btn = this,
            contador = 0,
            data = '';
        if ($(form + ' #idCliente').val() === "0") {
            $(form + ' #nombreCliente').addClass('input-validation-error');
        }

        if ($("form").valid()) {
            CMI.botonMensaje(true, btn, 'Actualizar');
            $(Remision.activeForm + ' #usuarioCreacion').val(localStorage.idUser);

            if (Remision.colOrdenEmbar === null || Remision.colOrdenEmbar.length < 1) {
                CMI.DespliegaErrorDialogo('Debe seleccionar por lo menos una Orden de embarque');
                CMI.botonMensaje(false, btn, 'Actualizar');
                return;
            }

            data = $("#ActualizarRemisionForm *").serialize();

            while (Remision.colOrdenEmbar.length > contador) {
                data = data + '&lstOrdenEmbarque=' + Remision.colOrdenEmbar.at(contador).attributes.id;
                contador = contador + 1;
            }

            //Se hace el post para guardar la informacion
            $.post(contextPath + "Remision/Actualiza",
                data,
                function (data) {
                    if (data.Success === true) {
                        Remision.colRemisiones.add(Remision.serializaRemision(data.id), { merge: true });
                        CMI.DespliegaInformacion('La Remision fue Actualizada correctamente.');
                        $('#actualiza-Remision').modal('hide');
                        if (Remision.colRemisiones.length === 1) {
                            $('#bbGrid-Remisiones')[0].innerHTML = "";
                            Remision.CargaGrid();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al actulizar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Actualizar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Actualizar');
        }
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
            $(Remision.activeForm + ' #usuarioCreacion').val(localStorage.idUser);

            if (Remision.colOrdenEmbar === null || Remision.colOrdenEmbar.length < 1) {
                CMI.DespliegaErrorDialogo('Debe seleccionar por lo menos una Orden de embarque');
                CMI.botonMensaje(false, btn, 'Guardar');
                return;
            }

            data = $("#NuevaRemisionForm *").serialize();

            while (Remision.colOrdenEmbar.length > contador) {
                data = data + '&lstOrdenEmbarque=' + Remision.colOrdenEmbar.at(contador).attributes.id;
                contador = contador + 1;
            }

            //Se hace el post para guardar la informacion
            $.post(contextPath + "Remision/Nuevo",
                data,
                function (data) {
                    if (data.Success === true) {
                        Remision.colRemisiones.add(Remision.serializaRemision(data.id));
                        CMI.DespliegaInformacion('La Remision fue guardada con el Id: ' + data.id);
                        $('#nuevo-Remision').modal('hide');
                        if (Remision.colRemisiones.length === 1) {
                            $('#bbGrid-Remisiones')[0].innerHTML = "";
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
            CMI.DespliegaError("No se pudo cargar el modulo de Buscar proyectos");
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
            CMI.DespliegaError("No se pudo cargar el modulo de Buscar etapa");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onImprimir: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Remision/Remision/"; // El url del controlador
        if (Remision.remisionSelected !== null) {
            url = url + Remision.remisionSelected;
            $.get(url, function (data) {
                if (data.Success === true) {
                    Remision.CargaDetalleRemision(Remision.remisionSelected, data.Data);
                } else {
                    CMI.DespliegaError(data.Message);
                }
            }).fail(function () {
                CMI.DespliegaError("No se pudo cargar la informacion de la Remision");
            });

        } else {
            CMI.DespliegaError("Debe seleccionar una Remision de la lista.");
        }
    },
    onBuscarOrdenEmbarque: function () {
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "OrdenEmbarque/BuscarOrdenEmbarque?sinRemision=true"; // El url del controlador
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
    CargaDetalleRemision: function (id, remision) {
        var url = contextPath + "Remision/CargaDetalleRemision/" + id; // El url del controlador
        $.get(url, function (data) {
            if (data.Success === true) {
                Remision.GeneraExcelRemision(Remision.remisionSelected, remision, data.Data, data.fecha);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion del Detalle de Remision");
        });
    },
    EditarRemision: function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Remision/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-Remision').html(data);
            $('#actualiza-Remision').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            Remision.activeForm = '#ActualizarRemisionForm';
            $(Remision.activeForm + ' #btnBuscarCliente').click(Remision.onBuscarCliente);
            Remision.IniciaDateControls();
            Remision.CargaOrdenesRemision(id);
        });
    },
    CargaOrdenesRemision: function (id) {
        $.get(contextPath + "Remision/CargaEmbarquesRemisiones/" + id,
               function (data) {
                   if (data.Success === true) {
                       Remision.colOrdenEmbar = new Backbone.Collection(data.Data);
                       $('#bbGrid-OrdenEmbarA')[0].innerHTML = "";
                       Remision.CargaGridOrdenEmbarque('A');
                   } else {
                       CMI.DespliegaErrorDialogo(data.Message);
                   }
               }).fail(function () {
                   CMI.DespliegaErrorDialogo("Error al cargar los Embarques de la remision");
               });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Remision/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                Remision.colRemisiones.remove(id);
                CMI.DespliegaInformacion("Se borro la Remision con  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la Remision."); });
    },
    BorrarOrden: function (id) {
        CMI.CierraMensajes();
        Remision.colOrdenEmbar.remove(id);
    },
    CargaClienteProyecto: function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Proyecto/ClienteProyecto"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                var cliente = data.Data;
                Remision.AsignaCliente(cliente.id, cliente.NombreCliente, cliente.DireccionEntrega, cliente.ContactoCliente);
            } else {
                CMI.DespliegaErrorDialogo(data.Message);
            }
        }).fail(function () { CMI.DespliegaErrorDialogo("No se pudo borrar la Remision."); });
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

        //Se carga el grid de Remision asignadas a la Orden
        $('#bbGrid-Remisiones')[0].innerHTML = "";
        Remision.CargaGrid();
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
            observacionOrdenEmbarque: observacion
        };

        if (Remision.colOrdenEmbar === null) {
            Remision.colOrdenEmbar = new Backbone.Collection(data);
            $('#bbGrid-OrdenEmbarN')[0].innerHTML = "";
            Remision.CargaGridOrdenEmbarque('N');
        } else {
            Remision.colOrdenEmbar.add(data, { merge: true });
        }
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "Remision/Nuevo?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val(); // El url del controlador
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
            Remision.CargaClienteProyecto($('#idProyectoSelect').val());
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
    serializaRemision: function (id){
        return ({
            'id' : id,
            'NombreCliente': $( Remision.activeForm + ' #nombreCliente').text(),
            'Transporte': $( Remision.activeForm + ' #transporte').val(),
            'fechaEnvio': $( Remision.activeForm + ' #fechaEnvio').val(),
            'fechaRemision': $( Remision.activeForm + ' #fechaRemision').val()
        });
    },
    CargaGrid: function () {
        var url = contextPath + "Remision/CargaRemisiones?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfoEM').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Remision.colRemisiones = new Backbone.Collection(data);
            var bolFilter = Remision.colRemisiones.length > 0 ? true : false;
            if (bolFilter) {
                Remision.gridRemisiones = new bbGrid.View({
                    container: $('#bbGrid-Remisiones'),
                    actionenable: true,
                    enableSearch: false,
                    detalle: false,
                    editar: Remision.accEscritura,
                    collection: Remision.colRemisiones,
                    seguridad: false,
                    borrar: Remision.accBorrar,
                    colModel: [{ title: 'Remision', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Cliente', name: 'NombreCliente', filter: true, filterType: 'input' },
                               { title: 'Transporte', name: 'Transporte', filter: true, filterType: 'input' },
                               { title: 'Fecha Envio', name: 'fechaEnvio', filter: true, filterType: 'input' },
                               { title: 'Fecha Remision', name: 'fechaRemision', filter: true, filterType: 'input' }],
                    onRowClick: function () {
                        $('#rowImprimir').show();
                        Remision.remisionSelected = this.selectedRows[0];
                }
                });
                $('#cargandoInfoEM').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Remisiones para el proyecto y etapa seleccionados.");
                $('#bbGrid-Remisiones')[0].innerHTML = "";
                $('#rowImprimir').hide();
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de las Remisiones");
            $('#rowImprimir').hide();
        });
    },
    CargaGridOrdenEmbarque: function (tipo) {
        var bolFilter = Remision.colOrdenEmbar.length > 0 ? true : false;
        if (bolFilter) {
            $('#cargandoInfoOE').show();
            Remision.gridOrdenEmbar = new bbGrid.View({
                container: $('#bbGrid-OrdenEmbar' + tipo),
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
                           { title: 'Observacion', name: 'observacionOrdenEmbarque' }]
            });
            $('#cargandoInfoOE').hide();
        }
        else {
            CMI.DespliegaInformacion("No se encontraron Ordees de Embarque");
            $('#bbGrid-OrdenEmbar' + tipo)[0].innerHTML = "";
        }
    },
    GeneraExcelRemision: function (id, remision, detalle, fecha) {
        var tblDataRow = '',
          tabla = '',
          tcompleta = '',
          header = "<table border='2'>",
          tabla_html = '';

        if (detalle !== null) {
            for (var contador = 0; contador < detalle.length; contador++) {
                var item = detalle[contador];
                tblDataRow += "<tr>";
                tblDataRow += "<td>" + item.idOrdenEmbarque + "</td>";
                tblDataRow += "<td colspan='6'>" + item.Marca.replace(/ /g, '&nbsp;') + "</td>";
                tblDataRow += "<td colspan='2'>" + item.Piezas + "</td>";
                tblDataRow += "<td colspan='2'>" + item.PesoCU + "</td>";
                tblDataRow += "</tr>";
            }
        }
        header += "<tr>";
        header += "<td colspan='3'><img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' /></td>";
        header += "<td > <table> ";
        header += "        <tr> <td colspan='6' align='center'><strong> Reporte Remision </strong></td> </tr><tr > <td colspan='2'> </td> </tr> ";
        header += "        <tr> <td colspan='6' align='center'><strong> " + $('#nombreProyecto').text() + " - " + $('#nombreEtapa').text() + " </strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
        header += "      </table>";
        header += " </td> ";
        header += "<td> ";
        header += "    <table ><tr> <td></td> </tr><tr align='right'> <td>Codigo:</td></tr><tr align='right'><td >Revision:</td></tr><tr align='right'><td >Folio:</td></tr><tr align='right'> <td >Fecha:</td></tr></table>";
        header += "</td>";
        header += "<td> ";
        header += "    <table><tr align='center'></tr><tr align='center'><td ><strong>" + $('#CodigoProyecto').text() + "</strong></td></tr><tr align='center'><td><strong>" + $('#RevisionPro').text() + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + id + "</strong></td></tr>";
        header += "      <tr><td  align='center'><strong>" + fecha + "</strong></td></tr>";
        header += "    </table>";
        header += "</td>";
        header += "</tr></table>";

        header += "<table border='2'>";
        header += "<tr align='center'> <td colspan='2'>REMITIDO: </td> <td colspan='4'>" + remision.nombreCliente + "</td> <td colspan='2'>TRANSPORTE: </td> <td colspan='3'>" + remision.transporte + "</td></tr>";
        header += "<tr align='center'> <td colspan='2'>DOMICILIO: </td> <td colspan='4'>" + remision.direccionCliente + "</td> <td colspan='2'>PLACAS: </td><td colspan='3'>" + remision.placas + "</td></tr>";
        header += "<tr align='center'> <td colspan='2'>CONTACTO: </td> <td colspan='4'>" + remision.nombreContacto + "</td> <td colspan='2'>CONDUCTOR: </td><td colspan='3'>" + remision.conductor + "</td></tr>";
        header += "<tr align='center'> <td colspan='2'> </td> <td colspan='4'></td> <td colspan='2'>FIRMA DE RECIBIDO: </td><td colspan='3'></td></tr>";
        header += "</table>";

        tabla = "<table  border='2' ><tr align='center'>" +
                "<td rowspan='2'><strong>Orden Embarque</strong></td>" +
                "<td rowspan='2' colspan='6'><strong>Nombre Pieza</strong></td>" +
                "<td rowspan='2' colspan='2'><strong>Pieza</strong></td>" +
                "<td rowspan='2' colspan='2'><strong>Peso </strong></td>" +
                "</tr></table>";

        tcompleta = "<table border='2'><tr><td><table border='1'>";
        tcompleta += tblDataRow;
        tcompleta += "</table></td></tr></table>";

        tcompleta += "<table ><tr><td></td></tr> <tr >";
        tcompleta += "<td colspan='2'></td>";
        tcompleta += "<td colspan='3' style='border:solid;border-size:2'>SOLICITO</td>";
        tcompleta += "<td colspan='3' style='border:solid;border-size:2'>AUTORIZO: </td>";
        tcompleta += "<td colspan='3' style='border:solid;border-size:2'>RECIBIO: </td>";
        tcompleta += "</tr></table>";

        header += tabla + tcompleta;

        var tmpElemento = document.createElement('a'),
            data_type = 'data:application/vnd.ms-excel',
            tabla_div = header;

        tabla_html = tabla_div.replace(/ /g, '%20');

        tmpElemento.href = data_type + ', ' + tabla_html;
        //Asignamos el nombre a nuestro EXCEL
        tmpElemento.download = 'Reporte_Remision.xls';
        // Simulamos el click al elemento creado para descargarlo
        tmpElemento.click();
    }
};

$(function () {
    Remision.Inicial();
});