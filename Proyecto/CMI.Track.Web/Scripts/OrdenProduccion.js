/*global $,ProyectoBuscar,EtapaBuscar,CMI,bbGrid,Backbone,contextPath*/
//js de Ordenes de Produccion
//Juan Lopepe
//19/Febrero/2016
var OrdenProduccion = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridOrdenProduccion: {},
    colDetalleOrdenProduccion: {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#btnImprimir").click(that.onImprimir);
        $("#clase").change(that.onCambiaClase);
        
    },
    onCambiaClase: function () {
        $('#bbGrid-OrdenProduccion')[0].innerHTML = "";
        $('.alert').hide();
        OrdenProduccion.CargaGrid();
    },
    onImprimir: function () {
        var templateURL = contextPath + "Content/template/rpt_OrdenProduccion.html";
        var rptTemplate = '';
        var arrData;
        var tblData = '';
        var tabla_html = '';
        $.ajax({
            type: "GET",
            url: templateURL,
            async: false,
            success: function (response) {
                rptTemplate = response;
            }
        });
        
        var url = contextPath + "OrdenProduccion/CargaDetalleOrdenProduccion?idEtapa=" + $('#idEtapaSelect').val() + "&clase=" + $('#clase').val(); // El url del controlador
        $.getJSON(url, function (data) {
            arrData = data;
            
            for (var i = 0; i < arrData.length; i++) {
                tblData += "<tr>";
                tblData += "<td>" + arrData[i]['seccion'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['tipo'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['pieza'] + "</td>";
                tblData += "<td>" + arrData[i]['marca'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['serie'] + "</td>";
                tblData += "<td>" + arrData[i]['submarca'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['perfil'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['piezas'] + "</td>";
                tblData += "<td>" + arrData[i]['numCorte'] + "</td>";
                tblData += "<td>" + arrData[i]['longitud'] + "</td>";
                tblData += "<td>" + arrData[i]['ancho'] + "</td>";
                tblData += "<td>" + arrData[i]['grado'] + "</td>";
                tblData += "<td>" + arrData[i]['kgm'] + "</td>";
                tblData += "<td>" + arrData[i]['totalLA'] + "</td>";
                tblData += "<td>" + arrData[i]['total'] + "</td>";
                tblData += "<td>" + arrData[i]['numPlano'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['peso'] + "</td>";
                tblData += "</tr>";
            }

            rptTemplate = rptTemplate.replace('myVarCodigoProyecto', $('#CodigoProyecto').text());
            rptTemplate = rptTemplate.replace('myVarRevisionProyecto', $('#RevisionPro').text());
            tabla_html = rptTemplate.replace('myVarTRs', tblData);
            tabla_html = tabla_html.replace(/ /g, '%20');
            
            var tmpElemento = document.createElement('a');
            var data_type = 'data:application/vnd.ms-excel';
            tmpElemento.href = data_type + ', ' + tabla_html;
            tmpElemento.download = 'Orden_Produccion.xls';
            tmpElemento.click();

            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de la Orden de Produccion");
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
            ProyectoBuscar.parent = OrdenProduccion;
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
            EtapaBuscar.parent = OrdenProduccion;
            EtapaBuscar.Inicial();            
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
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
        $('#bbGrid-OrdenProduccion')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        }
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
        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-OrdenProduccion')[0].innerHTML = "";
        if ($('#idEtapaSelect').val(idEtapa) !== null ) {
            $('#NombreEt').show();
            $('#FechaInicioEt').show();
            $('#FechaFinEt').show();
        }

        $('#clase option[value="T"]').attr("selected", "selected");

        OrdenProduccion.CargaGrid();
        $('#claseRow').show();

    },
    ValidaPermisos: function () {
        var modulo = OrdenProduccion;

        modulo.accEscritura = false;
        modulo.accBorrar = false;
        modulo.accClonar = false;
    },
    CargaGrid: function () {
        var url = contextPath + "OrdenProduccion/CargaDetalleOrdenProduccion?idEtapa=" + $('#idEtapaSelect').val() + "&clase=" + $('#clase').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            OrdenProduccion.colDetalleOrdenProduccion = new Backbone.Collection(data);
            var bolFilter = OrdenProduccion.colDetalleOrdenProduccion.length > 0 ? true : false;
            if (bolFilter) {
                OrdenProduccion.gridOrdenProduccion = new bbGrid.View({
                    container: $('#bbGrid-OrdenProduccion'),
                    rows: 10,
                    rowList: [5, 10, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: OrdenProduccion.accClonar,
                    editar: OrdenProduccion.accEscritura,
                    borrar: OrdenProduccion.accBorrar,
                    collection: OrdenProduccion.colDetalleOrdenProduccion,
                    seguridad: OrdenProduccion.accSeguridad,
                    colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                              { title: 'Seccion', name: 'seccion' },
                              { title: 'Tipo', name: 'tipo' },
                              { title: 'Pieza', name: 'pieza' },
                              { title: 'Marca', name: 'marca' },
                              { title: 'Serie', name: 'serie' },
                              { title: 'SubMarca', name: 'submarca' },
                              { title: 'Perfil', name: 'perfil' },
                              { title: 'Piezas', name: 'piezas' },
                              { title: 'NumCorte', name: 'numCorte' },
                              { title: 'Longitud', name: 'longitud' },
                              { title: 'Ancho', name: 'ancho' },
                              { title: 'Grado', name: 'grado' },
                              { title: 'Kg/M', name: 'kgm' },
                              { title: 'TotalLA', name: 'totalLA' },
                              { title: 'Total', name: 'total' },
                              { title: 'NumPlano', name: 'numPlano' },
                              { title: 'Peso', name: 'peso' }]
                });
                $('#cargandoInfo').hide();
                $('#Imprimir').show();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Datos de la Orden de Produccion seleccionada.");
                $('#bbGrid-OrdenProduccion')[0].innerHTML = "";
                $('#Imprimir').hide();
            }
            //getJSON fail
        }).fail(function () {
            CMI.DespliegaError("No se pudo cargar la informacion de la Orden de Produccion");
        });
    }  
};

$(function () {
    OrdenProduccion.Inicial();
});