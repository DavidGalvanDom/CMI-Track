//js de Requerimientos
//David Jasso
//23/Febrero/2016
var Requerimiento = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridRequerimiento: {},
    colRequerimientos: {},
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
        
        $('#etapaRow').hide();
        $('#requerimientoRow').hide();
        $('#Imprimir').hide();
        $('#btnCollapse').hide();
    },
    onImprimir: function () {
        var tableData;
        var tablaheader;
        var tabla;
        var tcompleta;
        var total = 0;
        var f = new Date();
        var urlImagen = window.location.protocol + '//' + window.location.host + '//Content/images/CMI.TRACK.reportes.png';
        var header = "<table border='2'>";
        var f = new Date();
        var urlHeader = contextPath + "ReqManualCompra/CargaInfoRequerimiento?idProyecto=" + $('#idProyectoSelect').val() + "&idEtapa=" + $('#idEtapaSelect').val() + "&idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
        $.getJSON(urlHeader, function (data) {
            tablaheader = data;
            for (j = 0; j < tablaheader.length; j++) {
                header += "<tr>";
                header += "<td colspan='3'><img src="+ urlImagen + " /></td>"
                header += "<td > <table> <tr > <td colspan='2'> </td> </tr>";
                header += "<tr> <td colspan='2' align='center'><strong>REQUERIMIENTO</strong></td> </tr> ";
                header += "<tr> <td colspan='2' align='center'><strong> ETAPA #" + tablaheader[j]['idEtapa'] + "</strong></td> </tr><tr> <td colspan='2'> </td></tr> ";
                header += "<tr> <td colspan='2' align='center'><strong><i> " + tablaheader[j]['NombreEtapa'] + "</i></strong> </td> </tr> <tr> <td colspan='2' align='center'style='color:red;'>95% <strong>Rev.A</strong></td></tr></table></td> ";
                header += "<td> <table > <tr align='right'><td></td><td></td><td></td><td style='border:solid;border-size:2;' align='center'><strong>No.</strong></td></tr> <tr align='center'>  <td></td><td></td><td></td> <td style='border:solid;border-size:2;'><strong>" + tablaheader[j]['id'] + "</strong></td> </tr><tr align='right'> <td  colspan='4'>FECHA:</td></tr><tr align='right'><td colspan='4'>Folio Req.</td></tr><tr align='right'> <td  colspan='4'>DEPARTAMENTO:</td></tr><tr align='right'><td  colspan='4'>SOLICITADO POR:</td></tr></table>";
                header += "</td><td><table><tr align='center'><td style='border:solid;border-size:2';>PROYECTO</td></tr><tr align='center'><td style='border:solid;border-size:2;'><strong>" + tablaheader[j]['NombreProyecto'] + "</strong></td></tr><tr align='center'><td><strong>" + f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear() + "</strong></td></tr>";
                header += "<tr><td  align='center'><strong>" + tablaheader[j]['FolioRequerimiento'] + "</strong></td></tr>";
                header += "<tr><td  align='center'>" + tablaheader[j]['NombreDepto'] + "</td></tr>"
                header += "<tr><td  align='center'>" + tablaheader[j]['NomnreUsuario'] + "</td></tr></table></td></tr>";
            }
      
        var url = contextPath + "ReqGralMaterial/CargaReqGralMaterialesId?idEtapa=" + $('#idEtapaSelect').val() + "&idProyecto=" + $('#idProyectoSelect').val() +  "&idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            tableData = data;
            tabla = "<table  border='2' ><tr align='center'><td rowspan='2'><strong>Partida</strong></td><td rowspan='2'><strong>Cantidad</strong></td><td rowspan='2'><strong>Unidad</strong></td><td rowspan='2' colspan='1'><strong>DESCRIPCION</strong></td><td rowspan='2' colspan='1'><strong>Calidad<br>de Acero</strong></td><td rowspan='2'><strong>Ancho<br>(ft.)</strong></td><td rowspan='2'><strong>Long.<br>( ft.)</strong></td><td rowspan='2'><strong>Long.(m)<br>Area (m2)</strong></td><td rowspan='2'><strong>Kg/m<br>Kg/m2</strong></td><td rowspan='2'><strong>TOTAL<br>( Kg )</strong></td></tr></table>";
            tcompleta = "<table border='2'><tr><td><table border='1'>";
                for (i = 0; i < tableData.length; i++) {
                    tcompleta += "<tr>";
                    tcompleta += "<td></td>";
                    tcompleta += "<td>" + tableData[i]['piezasSubMarca'] + "</td>";
                    tcompleta += "<td></td>";
                    tcompleta += "<td>" + tableData[i]['perfilSubMarca'] + "</td>";
                    tcompleta += "<td></td>";
                    tcompleta += "<td>" + tableData[i]['anchoSubMarca'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['longitudSubMarca'] + "</td>";
                    tcompleta += "<td> "+ tableData[i]['longitudSubMarca'] * 0.3048 + "</td>";
                    tcompleta += "<td>" + tableData[i]['kgmSubMarca'] + "</td>";
                    tcompleta += "<td>" + tableData[i]['piezasSubMarca'] * (tableData[i]['longitudSubMarca'] * 0.3048) * tableData[i]['kgmSubMarca'] + "</td>";
                    tcompleta += "</tr>";
                    total += (tableData[i]['piezasSubMarca'] * (tableData[i]['longitudSubMarca'] * 0.3048) * tableData[i]['kgmSubMarca']);
                }
                tcompleta += "</table></td></tr><table><tr><td colspan='8'></td><td align='right'>TOTAL</td><td style='border:solid;border-size:2;'>" + total + "</td></tr></table></table>";
                header += tabla + tcompleta;
                var tmpElemento = document.createElement('a');
                var data_type = 'data:application/vnd.ms-excel';
                var tabla_div = header;
            //alert(tabla_div);
                var tabla_html = tabla_div.replace(/ /g, '%20');
                tmpElemento.href = data_type + ', ' + tabla_html;
            //Asignamos el nombre a nuestro EXCEL
                tmpElemento.download = 'Requerimiento_General.xls';
            // Simulamos el click al elemento creado para descargarlo
                tmpElemento.click();
      
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
        });
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
            ProyectoBuscar.parent = Requerimiento;
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarEtapa: function (){
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
            EtapaBuscar.parent = Requerimiento;
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
            RequerimientoBuscar.parent = Requerimiento;
            RequerimientoBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Requerimientos");
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
        $('#bbGrid-ReqMatGral')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        };
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
        $('.btnNuevo').hide();
        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-ReqMatGral')[0].innerHTML = "";
        if ($('#idEtapaSelect').val(idEtapa) !== null ) {
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
        $('#bbGrid-ReqMatGral')[0].innerHTML = "";
        Requerimiento.CargaGrid();
        $('#Imprimir').show();

        if ($('#idRequerimientoSelect').val(idRequerimiento) !== null) {
            $('#FolioRequerimiento').show();
            $('#FechaSolicitud').show();
        };
        $('#myCollapsible').collapse('hide');
        $("#btn").addClass("glyphicon-plus");
        $('#btnCollapse').show();
        ///Muestra el boton de nueva ReqMatGral
        if (Requerimiento.accEscritura === true)
            $('.btnNuevo').show();
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = Requerimiento;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaRequerimiento: function (id) {
       // var form = Requerimiento.activeForm;
        return ({
            'perfilSubMarca': $(form + ' #perfilSubMarca').val(),
            'piezasSubMarca': $(form + ' #piezasSubMarca').val(),
            'corteSubMarca': $(form + ' #corteSubMarca').val(),
            'longitudSubMarca': $(form + ' #longitudSubMarca').val(),
            'anchoSubMarca': $(form + ' #anchoSubMarca').val(),
            'gradoSubMarca': $(form + ' #gradoSubMarca').val(),
            'kgmSubMarca': $(form + ' #kgmSubMarca').val(),
            'totalLASubMarca': $(form + ' #totalLASubMarca').val(),
            'pesoSubMarca': $(form + ' #pesoSubMarca').val(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "ReqGralMaterial/CargaReqGralMaterialesId?idEtapa=" + $('#idEtapaSelect').val() + "&idProyecto=" + $('#idProyectoSelect').val() +  "&idRequerimiento=" + $('#idRequerimientoSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            Requerimiento.colRequerimientos = new Backbone.Collection(data);
            var bolFilter = Requerimiento.colRequerimientos.length > 0 ? true : false;
            if (bolFilter) {
                gridRequerimiento = new bbGrid.View({
                    container: $('#bbGrid-ReqMatGral'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: Requerimiento.accClonar,
                    editar: Requerimiento.accEscritura,
                    borrar: Requerimiento.accBorrar,
                    collection: Requerimiento.colRequerimientos,
                    seguridad: Requerimiento.accSeguridad,
                    colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                              { title: 'Perfil', name: 'perfilSubMarca', width: '8%' },
                              { title: 'Piezas', name: 'piezasSubMarca', width: '8%' },
                              { title: 'Corte', name: 'corteSubMarca' },
                              { title: 'Longitud', name: 'longitudSubMarca' },
                              { title: 'Ancho', name: 'anchoSubMarca' },
                              { title: 'Grado', name: 'gradoSubMarca' },
                              { title: 'KGM', name: 'kgmSubMarca' },
                              { title: 'Total', name: 'totalLASubMarca' },
                              { title: 'Peso', name: 'pesoSubMarca' } ]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Planos de Montaje registradas para la Etapa seleccionada.");
                $('#bbGrid-ReqMatGral')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los requerimientos de material");
        });
    }  
};

$(function () {
    Requerimiento.Inicial();
})