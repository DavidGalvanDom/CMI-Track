//js de catalogo de categorias.
//David Jasso
//02/Febrero/2016

var MovtoMaterial = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    activeForm: '',
    colMovtoM: {},
    gridMovtoM: {},
    colDocumento: [],
    colTipoMovto: [],
    colAlmacen: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
        this.Eventos();
        this.ValidaPermisos();

       this.CargarColeccionMovtoM();
      
    },
    Eventos: function () {
        var that = this;
        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onGuardar);
        $(document).on("click", '.btn-AgregarMaterial', that.onAgregar);
        $(document).on("click", '.btn-ActualizarCategoria', that.onActualizar);
        $("#btnImprimir").click(that.onImprimir);
        $("#idDoc").change(that.onCambiaDocumento);
       // $("#TipoMov").change(that.onCambiaTipo);
        $(document).on("change", '#TipoMov', that.onCambiaTipo);
    
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
    onCambiaDocumento: function () {

        if ($('#idDoc').val() == '') {
            //$('#CausaDiv').show();
        }
        else {
            $('#bbGrid-clear')[0].innerHTML = '';
            MovtoMaterial.CargaGrid($('#idDoc').val());
        }
    },
    onCambiaTipo: function () {

        if ($('#TipoMov').val() == '') {
            //$('#CausaDiv').show();
        }
        else {
            $('#TipoMovto').val($('#TipoMov').val());
            document.getElementById("TipoMov").disabled = true;
           // document.getElementById("myText").disabled = true;
           
          
           // $('#TipoMov').disable = true;
        }
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_movtos_materiales.html";
        var rptTemplate = '';
        var tabla_html;
        var tablatmp = '';
        var tableData;
        var tablaheader;
        var total = 0;
        var tcompleta = ''
        var f = new Date();
        if ($('#idDoc').val() != "undefined") {
        $.get(templateURL, function (data) { rptTemplate = data; });
        var urlHeader = contextPath + "MovimientoMaterial/CargaHeaderMovimientos?id=" + $('#idDoc').val(); // El url del controlador
        $.getJSON(urlHeader, function (data) {
            tablaheader = data;
            for (j = 0; j < tablaheader.length; j++) {
                rptTemplate = rptTemplate.replace('vrFolio', tablaheader[j]['idDocumento']);
                rptTemplate = rptTemplate.replace('vrTipoMovto', tablaheader[j]['TipoMovto']);
                rptTemplate = rptTemplate.replace('vrFecha',f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
               // rptTemplate = rptTemplate.replace('vrNoPro', tablaheader[j]['id']);
               // rptTemplate = rptTemplate.replace('vrNombrePro', tablaheader[j]['NombreProyecto']);
               // rptTemplate = rptTemplate.replace('vrFolioReq', tablaheader[j]['FolioRequerimiento']);
               // rptTemplate = rptTemplate.replace('vrDepto', tablaheader[j]['NombreDepto']);
               // rptTemplate = rptTemplate.replace('vrSolicita', tablaheader[j]['NomnreUsuario']);
            }

            var url = contextPath + "MovimientoMaterial/CargaMovimientos?id=" + $('#idDoc').val() ; // El url del controlador
            $.getJSON(url, function (data) {
                tableData = data;
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td>" + tableData[i]['Cantidad'] + "</td>";
                    tcompleta += "<td>" + "</td>";
                    tcompleta += "<td>" + tableData[i]['idMaterialM'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Material'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Ancho'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Largo'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Calidad'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['Almacen'] + "</td>";
                    tcompleta += "</tr>";
              

                }

                rptTemplate = rptTemplate.replace('vrTotal', total);
                rptTemplate = rptTemplate.replace('vrImagen', "<img src='" + routeUrlImages + "/CMI.TRACK.reportes.png' />");
                tablatmp = rptTemplate.replace('vrDetalle', tcompleta);
                var tmpElemento = document.createElement('a');
                var data_type = 'data:application/vnd.ms-excel';
                tabla_html = tablatmp.replace(/ /g, '%20');
                tmpElemento.href = data_type + ', ' + tabla_html;
                //Asignamos el nombre a nuestro EXCEL
                tmpElemento.download = 'Movimientos_materiales.xls';
                // Simulamos el click al elemento creado para descargarlo
                tmpElemento.click();

                //getJSON fail
            }).fail(function (e) {
                CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
            });
        });

        }
        else {
            CMI.DespliegaError("Favor de seleccionar documento");
        }
    },
    onGuardar: function (e) {
       
        $('#nuevo-movimientomaterial').modal('hide');
      //  $('#bbGrid-clear')[0].innerHTML = '';
        //   MovtoMaterial.CargaGrid();

        $('#idDoc').empty();
        var formRequisicion = MovtoMaterial.activeForm;
        var ultimo = 0;
        var url = contextPath + "MovimientoMaterial/CargaDocumentos/"; // El url del controlador
        $.getJSON(url, function (data) {
            MovtoMaterial.colDocumento = data;

            var select = $('#idDoc').empty();


            select.append('<option value="undefined">Selecciona documento</option>');

            $.each(MovtoMaterial.colDocumento, function (i, item) {
                select.append('<option value="'
                                     + item.idDocumento
                                     + '">'
                                     + item.idDocumento
                                     + '</option>');

                ultimo = item.idDocumento;

            });

            $('#idDoc').val($('#idDoc').val());
            // $('#idReq').val(ultimo);
            //$("#idReq").change(ultimo);
            $("#idDoc").val(ultimo).change();

        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de documentos");
        });
        
         
    },
    onAgregar: function (e) {
        var btn = this;

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            //Se hace el post para guardar la informacion
            $.post(contextPath + "MovimientoMaterial/Nuevo",
                $("#NuevoMovtoMForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        //$('#nuevo-movimientomaterial').modal('hide');
                        //CMI.DespliegaInformacion('Los materiales fueron asigandos correctamente');
         
                        $('#idDocum').text(data.id);
                        $('#bbGrid-MovtoMateriales')[0].innerHTML = '';
                        $('#idDocumento').val(data.id);
                       

                        MovtoMaterial.CargaGridM(data.id);
                      
                        
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
            $.post(contextPath + "Categoria/Actualiza",
                $("#ActualizaCategoriaForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-categoria').modal('hide');
                        MovtoMaterial.colMovtoM.add(MovtoMaterial.serializaCategoria(data.id, '#ActualizaCategoriaForm'), { merge: true });
                        CMI.DespliegaInformacion('La categoria fue Actualizada. Id:' + data.id);
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
            MaterialBuscar.parent = MovtoMaterial;
            MaterialBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Materiales");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaMaterial: function (id, NombreMaterial,
                   AnchoMaterial, LargoMaterial, PesoMaterial, CalidadMaterial) {
        $('#idMaterialM').val(id);
        $('#idMaterialSelect').val(id);
        $('#buscar-Material').modal('hide');

        //Se carga el grid de PlanosMontaje asignadas a la etapa
        //  $('#bbGrid-PlanosMontaje')[0].innerHTML = "";
        //  ReqMCompra.CargaGrid();


    },
    CargarColeccionMovtoM: function () {
        var form = MovtoMaterial.activeForm;
        if (MovtoMaterial.colDocumento.length < 1) {
            var url = contextPath + "MovimientoMaterial/CargaDocumentos/"; // El url del controlador
            $.getJSON(url, function (data) {
                MovtoMaterial.colDocumento = data;
                var select = $(form + ' #idDoc').empty();

                select.append('<option value="undefined">Selecciona documento</option>');

                $.each(MovtoMaterial.colDocumento, function (i, item) {
                    select.append('<option value="'
                                         + item.idDocumento
                                         + '">'
                                         + item.idDocumento
                                         + '</option>');
                });

                $(form + '#idDoc').val($(form + '#idDoc').val());
               // MovtoMaterial.CargaListaMovtoM(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");

            });
        } else {
           MovtoMaterial.CargaListaMovtoM(form);
        }
    },
    CargaListaMovtoM: function (form) {
        var select = $(form + ' #idDocumento').empty();

        select.append('<option> </option>');

        $.each(MovtoMaterial.colDocumento, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.idDocumento
                                 + '</option>');
        });

        $(form + '#idDocumento').val($(form + '#idDocumento').val());
    },
    CargarColeccionTipoMovto: function () {
        var form = MovtoMaterial.activeForm;
        if (MovtoMaterial.colTipoMovto.length < 1) {
            var url = contextPath + "MovimientoMaterial/CargaTiposMovimientos/"; // El url del controlador
            $.getJSON(url, function (data) {
                MovtoMaterial.colTipoMovto = data;
                MovtoMaterial.CargaListaTipoMovto(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de tipos de movimeintos");

            });
        } else {
            MovtoMaterial.CargaListaTipoMovto(form);
        }
    },
    CargaListaTipoMovto: function (form) {
        var select = $(form + ' #TipoMov').empty();

        select.append('<option> </option>');

        $.each(MovtoMaterial.colTipoMovto, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.TipoMovto
                                 + '</option>');
        });

        $(form + '#TipoMov').val($(form + '#TipoMov').val());
    },
    CargarColeccionAlmacen: function () {
        var form = MovtoMaterial.activeForm;
        if (MovtoMaterial.colAlmacen.length < 1) {
            var url = contextPath + "Almacen/CargaAlmacenesActivos/"; // El url del controlador
            $.getJSON(url, function (data) {
                MovtoMaterial.colAlmacen = data;
                MovtoMaterial.CargaListaAlmacenes(form);
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de las unidades de medida");
            });
        } else {
            MovtoMaterial.CargaListaAlmacenes(form);
        }
    },
    CargaListaAlmacenes: function (form) {
        var select = $(form + ' #idAlmacen').empty();

        select.append('<option> </option>');

        $.each(MovtoMaterial.colAlmacen, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.nombreAlmacen
                                 + '</option>');
        });

        $(form + '#idAlmacen').val($(form + '#idAlmacen').val());
    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "MovimientoMaterial/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-movimientomaterial').html(data);
            $('#nuevo-movimientomaterial').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            MovtoMaterial.activeForm = '#NuevoMovtoMForm';
            $(MovtoMaterial.activeForm + ' #btnBuscarMat').click(MovtoMaterial.onBuscarMaterial);
            MovtoMaterial.CargarColeccionTipoMovto();
            MovtoMaterial.CargarColeccionAlmacen();
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "Categoria/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-categoria').html(data);
            $('#actualiza-categoria').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            MovtoMaterial.CargarColeccionUnidadMedida();
            MovtoMaterial.CargarColeccionAlmacen();
            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el registro ' + id) === false) return;
        var url = contextPath + "Categoria/Borrar"; // El url del controlador
        $.post(url, { id: id }, function (data) {
            if (data.Success == true) {
                MovtoMaterial.colMovtoM.remove(id);
                CMI.DespliegaInformacion(data.Message + "  id:" + id);
            } else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar la categoria post Borrar"); });
    },
    Clonar : function (id){
        CMI.CierraMensajes();
        var url = contextPath + "Categoria/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-categoria').html(data);
            $('#nuevo-categoria').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
        });

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = MovtoMaterial;
        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
       
        if (modulo.accEscritura === true)
            $('.btnNuevo').show();

    },
    serializaCategoria: function (id,form) {
        return ({
            'NombreCategoria': $(form + ' #NombreCategoria').val().toUpperCase(),
            'Estatus': $(form + ' #Estatus').val(),
            'id': id
        });
    },
    CargaGrid: function (id) {
        $('#cargandoInfo').show();
        var url = contextPath + "MovimientoMaterial/CargaMovimientos?id=" + id; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            MovtoMaterial.colMovtoM = new Backbone.Collection(data);
            var bolFilter = MovtoMaterial.colMovtoM.length > 0 ? true : false;
            if (bolFilter) {
                gridMovtoM = new bbGrid.View({
                    container: $('#bbGrid-clear'),
                    rows: 5,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: false,
                    detalle: false,
                    clone: MovtoMaterial.accClonar,
                    editar: MovtoMaterial.accEscritura,
                    borrar: MovtoMaterial.accBorrar,
                    collection: MovtoMaterial.colMovtoM,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterialM', filter: true, filterType: 'input' },
                               { title: 'Material', name: 'Material', filter: true, filterType: 'input' },
                               { title: 'Documento', name: 'idDocumento', filter: true, filterType: 'input' },
                               { title: 'Existencia', name: 'Existencia', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input' },
                               { title: 'Tipo Movimiento', name: 'TipoMovto', filter: true }]
                });
                
                $('#cargandoInfo').hide();
                $('#Imprimir').show();
                
            } else {
                CMI.DespliegaInformacion("No se encontraron movimientos registrados");
                $('#Imprimir').hide();
                $('#bbGrid-clear')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los movimeintos");
        });
        
    },
    CargaGridM: function (id) {
        $('#cargandoInfo').show();
        
        var url = contextPath + "MovimientoMaterial/CargaMovimientos?id=" + id; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            MovtoMaterial.colMovtoM = new Backbone.Collection(data);
            var bolFilter = MovtoMaterial.colMovtoM.length > 0 ? true : false;
            if (bolFilter) {
                gridMovtoM = new bbGrid.View({
                    container: $('#bbGrid-MovtoMateriales'),
                    rows: 5,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: true,
                    actionenable: false,
                    detalle: false,
                    clone: MovtoMaterial.accClonar,
                    editar: MovtoMaterial.accEscritura,
                    borrar: MovtoMaterial.accBorrar,
                    collection: MovtoMaterial.colMovtoM,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Id Material', name: 'idMaterialM', filter: true, filterType: 'input' },
                               { title: 'Material', name: 'Material', filter: true, filterType: 'input' },
                               { title: 'Documento', name: 'idDocumento', filter: true, filterType: 'input' },
                               { title: 'Existencia', name: 'Existencia', filter: true, filterType: 'input' },
                               { title: 'Cantidad', name: 'Cantidad', filter: true, filterType: 'input' },
                               { title: 'Tipo Movimiento', name: 'TipoMovto', filter: true }]
                });

                $('#cargandoInfo').hide();
            } else {
                CMI.DespliegaInformacion("No se encontraron movimeintos registrados");
                $('#bbGrid-MovtoMateriales')[0].innerHTML = "";
            }

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los movimeintos");
        });

    }
};

$(function () {
    MovtoMaterial.Inicial();
});