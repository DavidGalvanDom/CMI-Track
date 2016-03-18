//js Modulo de Carga de lista general de partes.
//David Galvan
//11/Marzo/2016
var ListaGeneral = {    
    accEscritura: false,    
    accSeguridad: false,
    activeForm: '#frmListaPartes',
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
        this.EventoNombreArchivo();
    },
    Eventos: function () {
        var that = this;

        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $("#cmdSubir").click(that.onSubirArchivo);
        $('#etapaRow').hide();
        $('.subirArchivo').hide();
        
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
            ProyectoBuscar.parent = ListaGeneral;
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
            EtapaBuscar.parent = ListaGeneral;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar proyectos");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onSubirArchivo: function () {
        var filesName = 'flistaPartes',
            btn = this,
            form = ListaGeneral.activeForm,
            files;

        if ($("form").valid()) {
            CMI.botonMensaje(true, btn, 'Subir Archivo');
            files = document.getElementById(filesName).files;
            if (files.length > 0) {
                if (window.FormData !== undefined) {
                    var data = new FormData();
                    for (var count = 0; count < files.length; count++) {
                        data.append(files[count].name, files[count]);
                    }
                    $.ajax({
                        type: "POST",
                        url: '/ListaGeneral/SubirArchivo',
                        contentType: false,
                        processData: false,
                        data: data,
                        success: function (result) {
                            if (result.Success === true) {
                                $(ListaGeneral.activeForm + ' #archivoListaGen').val(result.Archivo);
                                $('#lblSubirArchivo').text('Ok').removeClass('label-info').addClass('label-success');
                                $('#lblValidarArchivo').text('--').removeClass('label-success').addClass('label-info');
                                $('#lblGuardaInfo').text('--').removeClass('label-success').addClass('label-info');

                                ListaGeneral.onValidarArchivo(btn);                                
                            } else {
                                $(ListaGeneral.activeForm + ' #archivoListaGen').val('');
                                CMI.DespliegaError(result.Message);
                                CMI.botonMensaje(false, btn, 'Subir Archivo');
                            }
                        },
                        error: function (xhr, status, p3, p4) {
                            var err = "Error " + " " + status + " " + p3 + " " + p4;
                            if (xhr.responseText && xhr.responseText[0] == "{") {
                                err = JSON.parse(xhr.responseText).Message;
                            }
                            CMI.DespliegaError(err);
                            CMI.botonMensaje(false, btn, 'Subir Archivo');
                        }
                    });
                } else {
                    CMI.DespliegaError("Este explorador no soportado por la aplicacion favor de utilizar una version mas reciente. Chrome");
                    CMI.botonMensaje(false, btn, 'Subir Archivo');
                }
            }
        }
    },
    onValidarArchivo: function (btn) {        
        CMI.CierraMensajes();
        var url = contextPath + "ListaGeneral/ValidarInformacion", // El url del controlador
            data = 'idProyecto=' + $('#idProyectoSelect').val() +
                   '&idEtapa=' + $('#idEtapaSelect').val() +
                   '&archivoListaGen=' + $(ListaGeneral.activeForm + ' #archivoListaGen').val();
        $.post(url,data, function (result) {
            if (result.Success === true) {
                $('#lblValidarArchivo').text('Ok (' + result.numRegistros + ')').removeClass('label-info').addClass('label-success');
                ListaGeneral.onSubirInformacion(btn);
            } else {                
                $(ListaGeneral.activeForm + ' #archivoListaGen').val('');
                CMI.DespliegaError(result.Message);
                ListaGeneral.ExportarExcel(result.excel);
                CMI.botonMensaje(false, btn, 'Subir Archivo');
            }
        }).fail(function () {
            CMI.DespliegaError("Error al momenot de Validar el Archivo");
        }).always(function () {
            CMI.botonMensaje(false, btn, 'Subir Archivo');
        });
    },
    onSubirInformacion: function (btn) {
        CMI.CierraMensajes();
        var url = contextPath + "ListaGeneral/SubirInformacion"; // El url del controlador      
        $.post(url, function (result) {
            if (result.Success === true) {
                CMI.DespliegaInformacion('El proceso termino de guardar la lista general de partes.');
                $(ListaGeneral.activeForm + ' #archivoListaGen').val('');
                $('#lblGuardaInfo').text('Ok').removeClass('label-info').addClass('label-success');
                CMI.botonMensaje(false, btn, 'Subir Archivo');
                $('.subirArchivo').hide();
            } else {
                $(ListaGeneral.activeForm + ' #archivoListaGen').val('');
                CMI.DespliegaError(result.Message);
                CMI.botonMensaje(false, btn, 'Subir Archivo');
            }
        }).fail(function () {
            CMI.DespliegaError("Error al momenot de Subir la informacion del Archivo");
        }).always(function () {
            CMI.botonMensaje(false, btn, 'Subir Archivo');
        });
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
        $('#frmListaPartes').hide();

        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');
        
        ///Mestra la seleccion de Archivos
        $('#frmListaPartes').show();
    },
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = ListaGeneral;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },    
    EventoNombreArchivo: function () {
        var form = ListaGeneral.activeForm;
        //Se inicializan los eventos para el formulario
        $(document).on('change', '.btn-file :file', function () {
            var input = $(this),
                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                label = input.val().replace(/\\/g, '/').replace(/.*\//, ''),
                file = input.get(0).files[0];
            var arrFileName = label.split('.');
            if (arrFileName.length > 0) {
                if (arrFileName[arrFileName.length - 1] !== 'xlsx') {
                    CMI.DespliegaError("El formato de Archivo no es valido. Permite archivos Excel xlsx");
                    $('.subirArchivo').hide();
                    $('#lblFileName').val('');
                    input.value = '';
                    return;
                }

            } else {
                CMI.DespliegaError("El formato de Archivo no es valido. Permite archivos Excel xlsx");
                $('.subirArchivo').hide();
                $('#lblFileName').val('');
                input.value = '';
                return;
            }

            $('#lblFileName').val(label);
            $('#lblSubirArchivo').text('--').removeClass('label-success').addClass('label-info');
            $('#lblValidarArchivo').text('--').removeClass('label-success').addClass('label-info');
            $('#lblGuardaInfo').text('--').removeClass('label-success').addClass('label-info');
            $('.subirArchivo').show();
        });
    },
    ExportarExcel: function (csvInfo) {

        //Generate a file name
        var fileName = "Lista_Partes_Err";
       
        //inicializa el formato del archivo csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + escape(csvInfo);

        //Se genera un tag temporal <a /> 
        var link = document.createElement("a");
        link.href = uri;

        //se oculta el link
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";

        //Dispara el evento para mostrar el archivo con los datos
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
};

$(function () {
    ListaGeneral.Inicial();
})

