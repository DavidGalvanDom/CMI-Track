//js de Asignar Materiales por Proyecto
//David Jasso
//28/Marzo/2016
var json;
var MaterialesProyecto = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridMaterialesProyecto: {},
    colMaterialesProyecto: {},
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
        $("#btnImprimir").click(that.onImprimir);
        $('.btnNuevo').click(that.Nuevo);
        $(".btn-GuardaNew").click(that.onConfirmar);
        $(document).on("click", '.btn-Cerrar', that.onCerrar);
        $(document).on("click", '.btn-AgregarMaterial', that.onGuardarM);
        $('#etapaRow').hide();
        $('#rowAlmacen').hide();
        $('#btnCollapse').hide();
        $('#Imprimir').hide();

        $(document).on('click', '.accrowBorrar', function () {
            that.Borrar($(this).parent().parent().attr("data-modelId"));
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
        var templateURL = contextPath + "Content/template/rpt_materiales_proyecto.html";
        var rptTemplate = '';
        var tabla_html;
        var tablatmp = '';
        var tableData;
        var Etapa;
        var DesEtapa;
        var NoPro;
        var NomPro;
        var FolReq;
        var Depto;
        var Solicita;
        var tablaheader;
        var total = 0;
        var tcompleta = ''
        var f = new Date();
        $.get(templateURL, function (data) { rptTemplate = data; });
        var urlHeader = contextPath + "ReqManualCompra/CargaInfoRequisicion?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
        $.getJSON(urlHeader, function (data) {
            tablaheader = data;
            for (j = 0; j < tablaheader.length; j++) {
                Etapa = tablaheader[j]['idEtapa'];
                DesEtapa = tablaheader[j]['NombreEtapa'];
                NoPro = tablaheader[j]['id'];
                NomPro = tablaheader[j]['NombreProyecto'];
                FolReq = tablaheader[j]['FolioRequerimiento'];
                Depto = tablaheader[j]['NombreDepto'];
                Solicita = tablaheader[j]['NomnreUsuario'];
            }

            var url = contextPath + "AsignaProyecto/CargaDetalleMaterialesProyecto?idRequerimiento=" + $('#idRequerimientoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idProyecto=" + $('#idProyectoSelect').val(); // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td>" + tableData[i]['nombreMaterial'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Ancho'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Largo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Cantidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Peso'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Solpie'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Solkgs'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Reqpie'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Reqkgs'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Matpie'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Matkgs'] + "</td>";
                    tcompleta += "</tr>";
                  //  total += (tableData[i]['Cantidad'] * (tableData[i]['Largo'] * 0.3048) * tableData[i]['Peso']);

                }

                // rptTemplate = rptTemplate.replace('vrTotal', total);
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
              //  alert(tablatmp);
                tmpElemento.href = data_type + ', ' + tabla_html;
                //Asignamos el nombre a nuestro EXCEL
                tmpElemento.download = 'Mteriales_Proyecto.xls';
                // Simulamos el click al elemento creado para descargarlo
                tmpElemento.click();

                //getJSON fail
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
            });
        });


    },
    onConfirmar: function () 
    {
        var btn = this,
                dataPost = '';
        var mat = [];
        var valida;
        var valida2;

        CMI.botonMensaje(true, btn, "<i class='fa floppy-o' aria-hidden='true'></i>Guardar");
            dataPost = $("Index *").serialize();

            if ($('#Almacen').val() !== '') {

                $.each(MaterialesProyecto.colMaterialesProyecto.models, function (index, value) {
                    mat = MaterialesProyecto.colMaterialesProyecto.where({ id: value.id});
                    if (mat[0].attributes.Total == 0) {
                        if (mat[0].attributes.Existencia >= parseFloat(document.getElementById(value.id).value)) {
                            if (parseFloat(document.getElementById(value.id).value) != 0) {
                                dataPost = dataPost + '&lstMS=' + parseFloat(document.getElementById(value.id).value) + ',' + value.id + ',' + mat[0].attributes.idMaterial + ',' + $('#Almacen').val() + ',' + localStorage.idUser;
                            }
                            valida = 0;
                            //valida2 = 0;
                        }
                        else {
                            valida = 1;
                        }
                    }
       
                });

        


                if (valida = 0) {
         
                    //Se hace el post para guardar la informacion
                    $.post(contextPath + "AsignaProyecto/Actualiza",
                        dataPost,
                        function (data) {
                            if (data.Success === true) {
                                CMI.DespliegaInformacion(data.Message);
                                $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
                                MaterialesProyecto.CargaGrid();
                            } else {
                                CMI.DespliegaErrorDialogo(data.Message);
                                $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
                                MaterialesProyecto.CargaGrid();
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
    onCerrar: function (e) {
        $('#nuevo-AsignaProyecto').modal('hide');
        CMI.DespliegaInformacion('Los materiales fueron asigandos correctamente');
        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = '';
        MaterialesProyecto.CargaGrid();
    },
    onGuardarM: function (e) {
        var btn = this;

        CMI.botonMensaje(true, btn, 'Agregar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "AsignaProyecto/NuevoM",
                $("#NuevoAsignaMaterialesForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                     //   $('#nuevo-AsignaProyecto').modal('hide');
                        CMI.DespliegaInformacion('Los materiales fueron asigandos correctamente');
                        $('#bbGrid-MaterialesAsignadosM')[0].innerHTML = '';
                        MaterialesProyecto.CargaGridAsignadosM();
                        $('#idRequisicionSelect').val('');
                        $('#idRequisicion').text('');
                        $('#idReq').val(0);
                        $('#OrigenReq').text('');
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
        //$('#bbGrid-PlanosMontaje')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        //  $('#nombreEtapa').text('');
        //  $('#FechaInicioEtapa').text('');
        //  $('#FechaFinEtapa').text('');

        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');

        $('#folioRequerimiento').text('Folio Requermiento');
        $('#fechaSolicitud').text('Fecha Solicitud');


        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";
        $('#Imprimir').hide();
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
    AsignaRequerimiento: function (idRequerimiento, folioRequerimiento, fechaSolicitud) {

        $('#idRequerimientoSelect').val(idRequerimiento);
        $('#folioRequerimiento').text(folioRequerimiento);
        $('#fechaSolicitud').text(fechaSolicitud);
        $('#buscar-General').modal('hide');

        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";

        if (MaterialesProyecto.accEscritura === true)
            $('.btnNuevo').show();
        MaterialesProyecto.CargarColeccionAlmacen();
     
        $('#rowAlmacen').show();
        $('#myCollapsible').collapse('hide');
        $('#btnCollapse').show();
        $('#Imprimir').show();
        MaterialesProyecto.CargaGrid();
       
    

    },
    AsignaRequisicion: function (id, NombreOrigen, Causa, Estatus, Serie, Factura, Proveedor, FechaFac) {

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
    AsignaMaterial: function (id, NombreMaterial,
                   AnchoMaterial, LargoMaterial, PesoMaterial, CalidadMaterial) {
        $('#idMaterial').val(id);
        $('#idMaterialSelect').val(id);
        $('#NombreMat').val(NombreMaterial);
        $('#buscar-Material').modal('hide');
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "AsignaProyecto/NuevoR"; // El url del controlador    
        if ($('#Almacen').val() != '') {
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
            if (data.Success == true) {
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
            }).fail(function (e) {
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
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            MaterialesProyecto.CargaListaUnidades(form);
        }
    },
    CargaListaUnidades: function (form) {
        var select = $(form + ' #Unidad').empty();

        select.append('<option>Selecciona Unidad</option>');

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
            }).fail(function (e) {
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
    CargaGrid: function () {
        var url = contextPath + "AsignaProyecto/CargaMaterialesProyecto?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
   
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            $.each(data, function (index, value) {
                //value.id = value.id + "," + value.idMaterial;
                value.Cantidad = " <input  id='" + value.id + "' type=\"text\" class=\"form-control\" tabindex='" + index + "'  value='" + value.Cantidad + "' /> ";
            });

            MaterialesProyecto.colMaterialesProyecto = new Backbone.Collection(data);
            var bolFilter = MaterialesProyecto.colMaterialesProyecto.length > 0 ? true : false;
            if (bolFilter) {
                gridMaterialesProyecto = new bbGrid.View({
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
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Materiales asigandos a este proyecto.");
                $('#bbGrid-AsignaMaterialesProyecto')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de materiales asigandos al proyecto");
        });
    },
    CargaGridAsignadosM: function () {
        var url = contextPath + "AsignaProyecto/CargaMaterialesAsignados?idProyecto=" + $('#idProyectoSelect').val() + '&idEtapa=' + $('#idEtapaSelect').val() + '&idRequerimiento=' + $('#idRequerimientoSelect').val() + '&idAlmacen=' + $('#Almacen').val(); // El url del controlador
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
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de materiales asigandos al proyecto");
        });
    }
};

$(function () {
    MaterialesProyecto.Inicial();
})