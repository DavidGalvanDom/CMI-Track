/*global $, CMI, Backbone,ProyectoBuscar,routeUrlImages, bbGrid, contextPath, EtapaBuscar, RequerimientoBuscar,RequisicionesBuscar, MaterialBuscar*/
//js de Asignar Materiales por Proyecto
//David Jasso
//28/Marzo/2016
var MaterialesProyecto = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    valInicial: 0,
    gridMaterialesProyecto: {},
    colMaterialesProyecto: {},
    colOrigenReq: [],
    colUnidadMedida: [],
    colDocumentos: [],
    colAlmacen: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
        $(window).resize(MaterialesProyecto.AjustaModal);
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnBuscarReq").click(that.onBuscarRequerimiento);
        $("#btnBuscarRequisicion").click(that.onBuscarRequisicion);
        $("#btnImprimir").click(that.onImprimir);
        $('.btnNuevo').click(that.Nuevo);
        $(".btn-GuardaNew").click(that.onConfirmar);
        $(document).on("click", '.btn-Cerrar', that.onCerrar);
        $(document).on("click", '.btn-AgregarMaterial', that.onGuardarM);
        $('#etapaRow').hide();
        $('#rowAlmacen').hide();
        $('#btnCollapse').hide();
        $('#Imprimir').hide();
        $(document).on("change", '#idDoc', that.onCambiaDoc);
        $(document).on('click', '.accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
        });
    },
    onCambiaDoc: function () {
        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
        $('#Imprimir').show();
        MaterialesProyecto.CargaGrid($('#idDoc').val());
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
            ProyectoBuscar.parent = MaterialesProyecto;
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
            EtapaBuscar.parent = MaterialesProyecto;
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
            RequerimientoBuscar.parent = MaterialesProyecto;
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
            RequisicionesBuscar.parent = MaterialesProyecto;
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
            MaterialBuscar.parent = MaterialesProyecto;
            MaterialBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Materiales");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_materiales_proyecto.html",
            rptTemplate = '',
            tabla_html,
            tablatmp = '',
            tableData,
            Etapa,
            DesEtapa,
            NoPro,
            NomPro,
            FolReq,
            Depto,
            Solicita,
            tablaheader,
            tcompleta = '',
            f = new Date();
        $.get(templateURL, function (data) { rptTemplate = data; });
        var urlHeader = contextPath + "AsignaProyecto/CargaHeaderMaterialesAsignados?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idDocumento=" + $('#idDoc').val(); // El url del controlador
        $.getJSON(urlHeader, function (data) {
            tablaheader = data;
            for (var j = 0; j < tablaheader.length; j++) {
                Etapa = tablaheader[j].idEtapa;
                DesEtapa = tablaheader[j].NombreEtapa;
                NoPro = tablaheader[j].idProyecto;
                NomPro = tablaheader[j].NombreProyecto;
                FolReq = tablaheader[j].documentoMP;
                Solicita = tablaheader[j].NombreUsuario;
            }

            var url = contextPath + "AsignaProyecto/CargaDetalleMaterialesProyecto?idRequerimiento=" + $('#idRequerimientoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idProyecto=" + $('#idProyectoSelect').val() + "&idDocumento=" + $('#idDoc').val(); // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
                for (var i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td>" + tableData[i].nombreMaterial + "</td>";
                    tcompleta += "<td>" + tableData[i].Ancho + "</td>";
                    tcompleta += "<td>" + tableData[i].Largo + "</td>";
                    tcompleta += "<td>" + tableData[i].Cantidad + "</td>";
                    tcompleta += "<td>" + tableData[i].Peso + "</td>";
                    tcompleta += "<td>" + tableData[i].Solpie + "</td>";
                    tcompleta += "<td>" + tableData[i].Solkgs + "</td>";
                    tcompleta += "<td>" + tableData[i].Reqpie + "</td>";
                    tcompleta += "<td>" + tableData[i].Reqkgs + "</td>";
                    tcompleta += "<td>" + tableData[i].Matpie + "</td>";
                    tcompleta += "<td>" + tableData[i].Matkgs + "</td>";
                    tcompleta += "</tr>";
                }

                rptTemplate = rptTemplate.replace('vrEtapa', 'ETAPA #' + Etapa);
                rptTemplate = rptTemplate.replace('vrDesEtapa', DesEtapa);
                rptTemplate = rptTemplate.replace('vrFecha', f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                rptTemplate = rptTemplate.replace('vrNoPro', $('#idProyectoSelect').val());
                rptTemplate = rptTemplate.replace('vrNombrePro', NomPro);
                rptTemplate = rptTemplate.replace('vrFolioReq', FolReq);
                rptTemplate = rptTemplate.replace('vrDepto', Depto);
                rptTemplate = rptTemplate.replace('vrSolicita', Solicita);
                rptTemplate = rptTemplate.replace('vrImagen', "<img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' />");
                rptTemplate = rptTemplate.replace('vrDetalle', tcompleta);
                tablatmp = rptTemplate;
                var tmpElemento = document.createElement('a');
                var data_type = 'data:application/vnd.ms-excel';
                tabla_html = tablatmp.replace(/ /g, '%20');
                tmpElemento.href = data_type + ', ' + tabla_html;

                tmpElemento.download = 'Mteriales_Proyecto.xls';
                tmpElemento.click();
                //getJSON fail
            }).fail(function () {
                CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
            });
        });
    },
    onConfirmar: function () 
    {
        var btn = this,
            dataPost = '',
            mat = [],
            valida;

        CMI.botonMensaje(true, btn, "<i class='fa floppy-o' aria-hidden='true'></i>Guardar");
        dataPost = $("Index *").serialize();

        if ($('#Almacen').val() !== '') {
            $.each(MaterialesProyecto.colMaterialesProyecto.models, function (index, value) {
                mat = MaterialesProyecto.colMaterialesProyecto.where({ id: value.id});
                if (mat[0].attributes.Total === 0) {
                    if (mat[0].attributes.Existencia >= parseFloat(document.getElementById(value.id).value)) {
                        if (parseFloat(document.getElementById(value.id).value) !== 0) {
                            dataPost = dataPost + '&lstMS=' + parseFloat(document.getElementById(value.id).value) + ',' + value.id + ',' + mat[0].attributes.idMaterial + ',' + $('#Almacen').val() + ',' + localStorage.idUser;
                        }
                        valida = 0;
                    } else {
                        valida = 1;
                    }
                }
            });

            if (valida === 0) {
                //Se hace el post para guardar la informacion
                $.post(contextPath + "AsignaProyecto/Actualiza",
                    dataPost,
                    function (data) {
                        if (data.Success === true) {
                            CMI.DespliegaInformacion(data.Message);
                            $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
                            MaterialesProyecto.CargaGrid($('#idDoc').val());
                        } else {
                            CMI.DespliegaErrorDialogo(data.Message);
                            $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
                            MaterialesProyecto.CargaGrid($('#idDoc').val());
                        }
                    }).fail(function () {
                        CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                    }).always(function () { CMI.botonMensaje(false, btn, "<i class='fa floppy-o' aria-hidden='true'></i>Guardar"); });
            } else {
                CMI.DespliegaError("Existencia no disponible");
                CMI.botonMensaje(false, btn, "<i class='fa floppy-o' aria-hidden='true'></i>Guardar");
            }
        }
        else {
            CMI.DespliegaError("Favor de seleccionar el almacen");
            CMI.botonMensaje(false, btn, "<i class='fa floppy-o' aria-hidden='true'></i>Guardar");
        }
    },
    onCerrar: function () {
        $('#idDoc').empty();
        var ultimo = 0,
            url = contextPath + "AsignaProyecto/CargaDocumentoMaterialProyecto?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            MaterialesProyecto.colDocumentos = data;
            var select = $('#idDoc').empty();
            select.append('<option value=0"undefined">Selecciona documento</option>');
            $.each(MaterialesProyecto.colDocumentos, function (i, item) {
                select.append('<option value="'
                                     + item.documentoMP
                                     + '">'
                                     + item.documentoMP
                                     + '</option>');
                ultimo = item.documentoMP;
            });

            $('#idDoc').val($('#idDoc').val());
            $("#idDoc").val(ultimo).change();
            $(" .select2").select2({ allowClear: true, placeholder: 'Documento' });
            $('#nuevo-AsignaProyecto').modal('hide');
            CMI.DespliegaInformacion('Los materiales fueron asigandos correctamente');
            $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
            MaterialesProyecto.CargaGrid($("#idDoc").val());
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de documentos");
        });
    },
    onGuardarM: function () {
        var btn = this;
        CMI.CierraMensajes();
        CMI.botonMensaje(true, btn, 'Agregar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "AsignaProyecto/NuevoM",
                $("#NuevoAsignaMaterialesForm *").serialize(),
                function (data) {
                    if (data.Success === true) {
                        CMI.DespliegaInformacionDialogo('Los materiales fueron asigandos correctamente');
                        $('#idRequisicionSelect').val('');
                        $('#idRequisicion').text('');
                        $('#idReq').val(0);
                        $('#OrigenReq').text('');
                        $('#idFolio').text(data.id);
                        $('#idAsignaProyecto').val(data.id);
                        $('#bbGrid-MaterialesAsignadosM')[0].innerHTML = '';
                        MaterialesProyecto.CargaGridAsignadosM(data.id);
                        MaterialesProyecto.AjustaModal();
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
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');

        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');
        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";
        $('#Imprimir').hide();
        $('#requerimientoRow').hide();
        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#OrdenProduccion').text(idEtapa);
        $('#buscar-General').modal('hide');
        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');
        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";
        $('#Imprimir').hide();
        $('#requerimientoRow').show();
    },
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento,
                                   fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');

        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";

        if (MaterialesProyecto.accEscritura === true)
            $('.btnNuevo').show();
        MaterialesProyecto.CargarColeccionAlmacen();
        MaterialesProyecto.CargarColeccionDocumentos();
        $('#rowAlmacen').show();
        $('#myCollapsible').collapse('hide');
        $('#btnCollapse').show();
    },
    AsignaRequisicion: function (id, NombreOrigen,
                                 Causa, Estatus,
                                 Serie, Factura,
                                 Proveedor, FechaFac) {

        $('#idRequisicion').text(id);
        $('#idReq').val(id);
        $('#idRequisicionSelect').val(id);
        $('#OrigenReq').text(NombreOrigen);
        $('#Causa').text(Causa);
        $('#Estatus').text(Estatus);
        $('#SerieFac').val(Serie);
        $('#FacturaReq').val(Factura);
        $('#ProveedorFac').val(Proveedor);
        $('#FechaFactura').val(FechaFac);
        $('#buscar-General').modal('hide');
    },
    AsignaMaterial: function (id, NombreMaterial) {
        $('#idMaterial').text(id);
        $('#idMaterialSelect').val(id);
        $('#NombreMat').text(NombreMaterial);
        $('#buscar-Material').modal('hide');
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "AsignaProyecto/NuevoR"; // El url del controlador    
        if ($('#Almacen').val() !== '') {
            $.get(url, function (data) {
                $('#nuevo-AsignaProyecto').html(data);
                $('#nuevo-AsignaProyecto').modal({
                    backdrop: 'static',
                    keyboard: true
                }, 'show');
                CMI.RedefinirValidaciones(); //para los formularios dinamicos
                MaterialesProyecto.activeForm = '#NuevoAsignaMaterialesForm';
                $('#idAlmacen').val($('#Almacen').val());
                $('#idEtapa').val($('#idEtapaSelect').val());
                $('#idProyecto').val($('#idProyectoSelect').val());
                $('#Revision').val($('#RevisionPro').text());
                $('#usuarioCreacion').val(localStorage.idUser);
                $(MaterialesProyecto.activeForm + ' #btnBuscarRequisicion').click(MaterialesProyecto.onBuscarRequisicion);
                $(MaterialesProyecto.activeForm + ' #btnBuscarMat').click(MaterialesProyecto.onBuscarMaterial);
                MaterialesProyecto.CargarColeccionUnidadMedida();
                MaterialesProyecto.CargarColeccionOrigenReq();
                $('#idRequisicionSelect').val(0);
                $('#idMaterialSelect').val(0);
            });
        } else {
            CMI.DespliegaError("Por favor seleccione un almacen");
        }
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "AsignaProyecto/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success === true) {
                MaterialesProyecto.colMaterialesProyecto.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el material asignado"); });
    },
    CargarColeccionAlmacen: function () {
        var form = MaterialesProyecto.activeForm;
        if (MaterialesProyecto.colAlmacen.length < 1) {
            var url = contextPath + "Almacen/CargaAlmacenesActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                MaterialesProyecto.colAlmacen = data;
                MaterialesProyecto.CargaListaAlmacenes(form);
            }).fail(function () {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            MaterialesProyecto.CargaListaAlmacenes(form);
        }
    },
    CargaListaAlmacenes: function (form) {
        var select = $(form + ' #Almacen').empty();

        select.append('<option> </option>');

        $.each(MaterialesProyecto.colAlmacen, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreAlmacen
                                 + '</option>');
        });

        $(form + '#Almacen').val($(form + '#Almacen').val());
    },
    CargarColeccionUnidadMedida: function () {
        var form = MaterialesProyecto.activeForm;
        if (MaterialesProyecto.colUnidadMedida.length < 1) {
            var url = contextPath + "UnidadMedida/CargaUnidadesMedidaActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                MaterialesProyecto.colUnidadMedida = data;
                MaterialesProyecto.CargaListaUnidades(form);
            }).fail(function () {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            MaterialesProyecto.CargaListaUnidades(form);
        }
    },
    CargaListaUnidades: function (form) {
        var select = $(form + ' #Unidad').empty();
        select.append('<option value=0>Selecciona Unidad</option>');
        $.each(MaterialesProyecto.colUnidadMedida, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreCortoUnidadMedida
                                 + '</option>');
        });

        $(form + '#Unidad').val($(form + '#Unidad').val());
    },
    CargarColeccionOrigenReq: function () {
        var formOrigen = MaterialesProyecto.activeForm;
        if (MaterialesProyecto.colOrigenReq.length < 1) {
            var url = contextPath + "OrigenRequisicion/CargaOrigenesRequisicionActivas/"; // El url del controlador
            $.getJSON(url, function (data) {
                MaterialesProyecto.colOrigenReq = data;
                MaterialesProyecto.CargaListaOrigenReq(formOrigen);
            }).fail(function () {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            MaterialesProyecto.CargaListaOrigenReq(formOrigen);
        }
    },
    CargaListaOrigenReq: function (formOrigen) {
        var select = $(formOrigen + ' #idOrigen').empty();

        select.append('<option>Selecciona Origen</option>');

        $.each(MaterialesProyecto.colOrigenReq, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.NombreOrigenRequisicion
                                 + '</option>');
        });

        $(formOrigen + '#idOrigen').val($(formOrigen + '#idOrigen').val());
    },
    CargarColeccionDocumentos: function () {
        var form = MaterialesProyecto.activeForm;
        if (MaterialesProyecto.colDocumentos.length < 1) {
            var url = contextPath + "AsignaProyecto/CargaDocumentoMaterialProyecto?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val(); // El url del controlador
            $.getJSON(url, function (data) {
                MaterialesProyecto.colDocumentos = data;
                MaterialesProyecto.CargaListaDocumentos(form);
            }).fail(function () {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los documentos generados");
            });
        } else {
            MaterialesProyecto.CargaListaDocumentos(form);
        }
    },
    CargaListaDocumentos: function (form) {
        var select = $(form + ' #idDoc').empty();

        select.append('<option value=0>Selecciona Documento</option>');

        $.each(MaterialesProyecto.colDocumentos, function (i, item) {
            select.append('<option value="'
                                 + item.documentoMP
                                 + '">'
                                 + item.documentoMP
                                 + '</option>');
        });

        $(form + '#idDoc').val($(form + '#idDoc').val());
        $(" .select2").select2({ allowClear: true, placeholder: 'Documento' });
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = MaterialesProyecto;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = false;
    },
    IniciaDateControls: function () {
        var form = MaterialesProyecto.activeForm;
        $(form + ' #dtpFechaFactura').datetimepicker({ format: 'MM/DD/YYYY' });
    },
    focusOut: function (input) {
        var total = 0;
        //Actualiza el total 
        if (MaterialesProyecto.valInicial !== input.value) {
            total = parseFloat($('#lblTotalReci').text());
            total = total + (input.value - MaterialesProyecto.valInicial);
            $('#lblTotalReci').text(total);
        }
    },
    AjustaModal: function () {
        var altura = $(window).height() - 155;
        $(".ativa-scroll").css({ "height": altura, "overflow-y": "auto" });
    },
    focusIn: function (input) {
        MaterialesProyecto.valInicial = input.value;
    },
    CargaGrid: function (id) {
        var url = contextPath + "AsignaProyecto/CargaMaterialesProyecto?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val() + '&idDocumento=' + id,
            total = 0,
            validar = 0 ; // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            $.each(data, function (index, value) {
                total = total + parseFloat(value.Cantidad);
                if (value.Cantidad === 0) {
                    validar = 1;
                }
                if (value.Cantidad === 0) {                    
                    value.Cantidad = " <input onblur='MaterialesProyecto.focusOut(this);' onFocus='MaterialesProyecto.focusIn(this);' id='" + value.id + "' type=\"number\" class=\"form-control\" tabindex='" + index + "'  value='" + value.Cantidad + "' /> ";
                } else {
                    value.Cantidad = " <input disabled onblur='MaterialesProyecto.focusOut(this);' onFocus='MaterialesProyecto.focusIn(this);' id='" + value.id + "' type=\"number\" class=\"form-control\" tabindex='" + index + "'  value='" + value.Cantidad + "' /> ";
                }
                
            });
            $('#lblTotalReci').text(total);
            $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";
            MaterialesProyecto.colMaterialesProyecto = new Backbone.Collection(data);
            var bolFilter = MaterialesProyecto.colMaterialesProyecto.length > 0 ? true : false;
            if (bolFilter) {
                MaterialesProyecto.gridMaterialesProyecto = new bbGrid.View({
                    container: $('#bbGrid-AsignaMaterialesProyecto'),
                    enableTotal: true,
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: MaterialesProyecto.accClonar,
                    editar: false,
                    borrar: MaterialesProyecto.accBorrar,
                    collection: MaterialesProyecto.colMaterialesProyecto,
                    seguridad: MaterialesProyecto.accSeguridad,
                    colModel: [{ title: 'id', name: 'id', width: '8%' },
                               { title: 'Id Material', name: 'idMaterial' },
                               { title: 'Nombre', name: 'nombreMat' },
                               { title: 'Unidad', name: 'UM' },
                               { title: 'Existencia', name: 'Existencia' },
                               { title: 'Entrega', name: 'Cantidad' },
                               { title: 'Calidad', name: 'Calidad' },
                               { title: 'Ancho', name: 'Ancho' },
                               { title: 'Longitud', name: 'Largo' },
                               { title: 'Long(m)-Area(m2)', name: 'LongArea' },
                               { title: 'kg/m-kg/m2', name: 'Peso', total: 0 },
                               { title: 'Total', name: 'Total', total: 0 }],
                });
                $('#cargandoInfo').hide();
                if (validar === 1) {
                    $('#guardar').show();
                }
                else {
                    $('#guardar').hide();
                }
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales asigandos a este proyecto.");
                $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de materiales asigandos al proyecto");
        });
    },
    CargaGridAsignadosM: function () {
        var url = contextPath + "AsignaProyecto/CargaMaterialesAsignados?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val() + '&idRequerimiento=' + $('#idRequerimientoSelect').val() + '&idAlmacen=' + $('#Almacen').val() + '&idDocumento=' + $('#idAsignaProyecto').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            MaterialesProyecto.colMaterialesProyecto = new Backbone.Collection(data);
            var bolFilter = MaterialesProyecto.colMaterialesProyecto.length > 0 ? true : false;
            if (bolFilter) {
                gridMaterialesProyecto = new bbGrid.View({
                    container: $('#bbGrid-MaterialesAsignadosM'),
                    rows: 5,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: MaterialesProyecto.accClonar,
                    editar: MaterialesProyecto.accEscritura,
                    borrar: MaterialesProyecto.accBorrar,
                    collection: MaterialesProyecto.colMaterialesProyecto,
                    seguridad: MaterialesProyecto.accSeguridad,
                    colModel: [{ title: 'id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterial', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre', name: 'nombreMat', filter: true, filterType: 'input' },
                               { title: 'Unidad', name: 'UM', filter: true, filterType: 'input' },
                               { title: 'Existencia', name: 'Existencia', filter: true, filterType: 'input' },
                               { title: 'Entrega', name: 'Cantidad', filter: true, filterType: 'input' },
                               { title: 'Calidad', name: 'Calidad', filter: true, filterType: 'input' },
                               { title: 'Ancho', name: 'Ancho', filter: true, filterType: 'input' },
                               { title: 'Longitud', name: 'Largo', filter: true, filterType: 'input' },
                               { title: 'Long(m)-Area(m2)', name: 'LongArea', filter: true, filterType: 'input' },
                               { title: 'kg/m-kg/m2', name: 'Peso', filter: true, filterType: 'input' },
                               { title: 'Total', name: 'Total', filter: true }],
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales asigandos a este proyecto.");
                $('#bbGrid-MaterialesAsignadosM')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de materiales asigandos al proyecto");
        });
    }
};

$(function () {
    MaterialesProyecto.Inicial();
});