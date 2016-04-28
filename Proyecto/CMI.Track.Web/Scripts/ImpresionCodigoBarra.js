//js de Impresion de Codigos de Barra
//Juan Lopepe
//19/Febrero/2016
var ImpresionCodigoBarra = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    activeForm: '',
    gridCodigosBarra: {},
    colCodigosBarra: {},
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
        $("#tipo").change(that.onCambiaTipo);
    },
    onCambiaTipo: function () {
        $('#bbGrid-CodigosBarra')[0].innerHTML = "";
        $('.alert').hide();
        ImpresionCodigoBarra.CargaGrid();
    },
    onImprimir: function () {
        var arrData;
        var tblData = '';
        var tabla_html = '';
        
        var url = contextPath + "ImpresionCodigoBarra/CargaCodigosBarra?idEtapa=" + $('#idEtapaSelect').val() + "&tipo=" + $('#tipo').val(); // El url del controlador
        $.getJSON(url, function (data) {
            arrData = data;
            tblData = "<table>";
            for (i = 0; i < arrData.length; i++) {
                tblData += "<tr>";
                tblData += "<td>" + arrData[i]['codigoBarra'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + $('#nombreProyecto').text().replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + $('#nombreEtapa').text().replace(/ /g, '&nbsp;') + "</td>";
                tblData += "<td>" + arrData[i]['codigo'].replace(/ /g, '&nbsp;') + "</td>";
                tblData += "</tr>";
            }
            tblData += "</table>";

            tabla_html = tblData;
            
            var tmpElemento = document.createElement('a');
            var data_type = 'data:application/vnd.ms-excel';
            tmpElemento.href = data_type + ', ' + tabla_html;
            tmpElemento.download = 'Codigos_de_Barra.xls';
            tmpElemento.click();

            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Codigos de Barra");
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
            ProyectoBuscar.parent = ImpresionCodigoBarra;
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
            EtapaBuscar.parent = ImpresionCodigoBarra;
            EtapaBuscar.Inicial();            
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar etapas");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    AsignaProyecto: function (idProyecto, Revision, NombreProyecto, CodigoProyecto, FechaInicio, FechaFin) {
        $('#idProyectoSelect').val(idProyecto);
        $('#RevisionPro').text(Revision);
        $('#nombreProyecto').text(NombreProyecto);
        $('#CodigoProyecto').text(CodigoProyecto);
        $('#FechaInicio').text(FechaInicio);
        $('#FechaFin').text(FechaFin);
        ///Se cierra la ventana de Proyectos
        $('#buscar-General').modal('hide');

        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-CodigosBarra')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        if ($('#idProyectoSelect').val(idProyecto) !== null) {
            $('#NombreProyecto').show();
            $('#revisionPro').show();
            $('#codigoProyecto').show();
            $('#fechaInicio').show();
            $('#fechaFin').show();
        };
        $('#Imprimir').hide();

        $('#etapaRow').show();       
    },
    AsignaEtapa: function (idEtapa, NombreEtapa, FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);       
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');
        $('.btnNuevo').hide();
        //Se carga el grid de ReqMatGral asignadas a la etapa
        $('#bbGrid-CodigosBarra')[0].innerHTML = "";
        if ($('#idEtapaSelect').val(idEtapa) !== null ) {
            $('#NombreEt').show();
            $('#FechaInicioEt').show();
            $('#FechaFinEt').show();
        };

        $('#clase option[value="T"]').attr("selected", "selected");

        ImpresionCodigoBarra.CargaGrid();
        $('#tipoRow').show();

    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = ImpresionCodigoBarra;

        modulo.accEscritura = false;
        modulo.accBorrar = false;
        modulo.accClonar = false;
    },
    CargaGrid: function () {
        var url = contextPath + "ImpresionCodigoBarra/CargaCodigosBarra?idEtapa=" + $('#idEtapaSelect').val() + "&tipo=" + $('#tipo').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            ImpresionCodigoBarra.colCodigosBarra = new Backbone.Collection(data);
            var bolFilter = ImpresionCodigoBarra.colCodigosBarra.length > 0 ? true : false;
            if (bolFilter) {
                gridCodigosBarra = new bbGrid.View({
                    container: $('#bbGrid-CodigosBarra'),
                    rows: 10,
                    rowList: [5, 10, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,
                    clone: ImpresionCodigoBarra.accClonar,
                    editar: ImpresionCodigoBarra.accEscritura,
                    borrar: ImpresionCodigoBarra.accBorrar,
                    collection: ImpresionCodigoBarra.colCodigosBarra,
                    seguridad: ImpresionCodigoBarra.accSeguridad,
                    colModel: [//{ title: 'Id', name: 'id', width: '8%' },
                              { title: 'Tipo', name: 'tipo' },
                              { title: 'Id', name: 'idMS' },
                              { title: 'Codigo', name: 'codigo' },
                              { title: 'Serie', name: 'serie' },
                              { title: 'Peso', name: 'peso' },
                              { title: 'Codigo de Barra', name: 'codigoBarra' }]
                });
                $('#cargandoInfo').hide();
                $('#Imprimir').show();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Datos.");
                $('#bbGrid-CodigosBarra')[0].innerHTML = "";
                $('#Imprimir').hide();
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de los Codigos de Barra");
        });
    }  
};

$(function () {
    ImpresionCodigoBarra.Inicial();
})