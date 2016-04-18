//js de catalogo de Planos de Montaje.
//David Galvan
//17/Febrero/2016
var PlanosDespiece = {
    accClonar: false,
    accEscritura: false,
    accBorrar: false,
    accSeguridad: false,
    estatusRevision: 0,
    activeForm: '',
    gridPlanosDespiece: {},
    colPlanosDespiece: {},
    colTipoConstruccion: [],
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.Eventos();
        this.ValidaPermisos();
    },
    Eventos: function () {
        var that = this;
        $("#btnBuscarProyecto").click(that.onBuscarProyecto);
        $("#btnBuscarEtapa").click(that.onBuscarEtapa);
        $('#btnBuscarPlanosMontaje').click(that.onBuscarPlanosMontaje);

        $('.btnNuevo').click(that.Nuevo);
        $(document).on("click", '.btn-GuardaNuevo', that.onSubirArchivo);
        $(document).on("click", '.btn-ActualizarPlanosDespiece', that.onSubirArchivo);
        $('#etapaRow').hide();

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
    onGuardar: function (btn) {
        var form = PlanosDespiece.activeForm;

        if ($(form + ' #idTipoConstruccion').val() === '') {
            $(form + ' .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $(form + ' .select2-container').removeClass('has-error');
        }

        CMI.botonMensaje(true, btn, 'Guardar');
        if ($("form").valid()) {
            $('#usuarioCreacion').val(localStorage.idUser);
            $(form + ' #idPlanoMontaje').val($('#idPlanoMontajeSelect').val());
            //Se hace el post para guardar la informacion
            $.post(contextPath + "PlanosDespiece/Nuevo",
                $("#NuevoPlanosDespieceForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        PlanosDespiece.colPlanosDespiece.add(PlanosDespiece.serializaPlanosDespiece(data.id));
                        CMI.DespliegaInformacion('El PlanosDespiece fue guardado con el Id: ' + data.id);
                        $('#nuevo-PlanosDespiece').modal('hide');
                        if (PlanosDespiece.colPlanosDespiece.length === 1) {
                            PlanosDespiece.CargaGrid();
                        }
                    } else {
                        CMI.DespliegaErrorDialogo(data.Message);
                        CMI.botonMensaje(false, btn, 'Guardar');
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al guardar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Guardar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Guardar');
        }
    },
    onActualizar: function (btn) {
        var form = PlanosDespiece.activeForm;

        if ($(form + ' #idTipoConstruccion').val() === '') {
            $(form + ' .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $(form + ' .select2-container').removeClass('has-error');
        }

        CMI.botonMensaje(true, btn, 'Actualizar');
        if ($("form").valid()) {
            //Se hace el post para guardar la informacion
            $.post(contextPath + "PlanosDespiece/Actualiza",
                $("#ActualizaPlanosDespieceForm *").serialize(),
                function (data) {
                    if (data.Success == true) {
                        $('#actualiza-PlanosDespiece').modal('hide');
                        PlanosDespiece.colPlanosDespiece.add(PlanosDespiece.serializaPlanosDespiece(data.id), { merge: true });
                        CMI.DespliegaInformacion('El PlanosDespiece fue Actualizado. Id:' + data.id);
                    }
                    else {
                        CMI.DespliegaErrorDialogo(data.Message);
                    }
                }).fail(function () {
                    CMI.DespliegaErrorDialogo("Error al actualizar la informacion");
                }).always(function () { CMI.botonMensaje(false, btn, 'Actualizar'); });
        } else {
            CMI.botonMensaje(false, btn, 'Actualizar');
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
            ProyectoBuscar.parent = PlanosDespiece;
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
            EtapaBuscar.parent = PlanosDespiece;
            EtapaBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Etapas");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onBuscarPlanosMontaje : function (){
        var btn = this;
        $(btn).attr("disabled", "disabled");
        CMI.CierraMensajes();
        var url = contextPath + "PlanosMontaje/BuscarPlanosMontaje"; // El url del controlador      
        $.get(url, function (data) {
            $('#buscar-General').html(data);
            $('#buscar-General').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            PlanosMontajeBuscar.idEtapa = $('#idEtapaSelect').val();            
            PlanosMontajeBuscar.parent = PlanosDespiece;
            PlanosMontajeBuscar.Inicial();
            $(btn).removeAttr("disabled");
        }).fail(function () {
            CMI.DespliegaErrorDialogo("No se pudo cargar el modulo de Buscar Planos Montaje");
        }).always(function () { $(btn).removeAttr("disabled"); });
    },
    onSubirArchivo: function () {
        var filesName = PlanosDespiece.activeForm === '#NuevoPlanosDespieceForm' ? 'fPlano' : 'fPlanoAct',
            btn = this,
            form = PlanosDespiece.activeForm,
            files;

        if ($(form + ' #idTipoConstruccion').val() === '') {
            $(form + ' .select2-container').addClass('has-error');
            $("form").valid();
            return;
        } else {
            $(form + ' .select2-container').removeClass('has-error');
        }

        if ($("form").valid()) {
            CMI.botonMensaje(true, btn, 'Guardar');
            files = document.getElementById(filesName).files;
            if (files.length > 0) {
                if (window.FormData !== undefined) {
                    var data = new FormData();
                    for (var count = 0; count < files.length; count++) {
                        data.append(files[count].name, files[count]);
                    }
                    $.ajax({
                        type: "POST",
                        url: '/PlanosDespiece/SubirArchivo',
                        contentType: false,
                        processData: false,
                        data: data,
                        success: function (result) {

                            if (result.Success === true) {
                                $(PlanosDespiece.activeForm + ' #archivoPlanoDespiece').val(result.Archivo);

                                if (PlanosDespiece.activeForm !== '#NuevoPlanosDespieceForm') {
                                    PlanosDespiece.onActualizar(btn);
                                } else {
                                    PlanosDespiece.onGuardar(btn);
                                }

                            } else {
                                $(PlanosDespiece.activeForm + ' #archivoPlanoDespiece').val('');
                                CMI.DespliegaErrorDialogo(result.Message);
                                CMI.botonMensaje(false, btn, 'Guardar');
                            }
                        },
                        error: function (xhr, status, p3, p4) {
                            var err = "Error " + " " + status + " " + p3 + " " + p4;
                            if (xhr.responseText && xhr.responseText[0] == "{") {
                                err = JSON.parse(xhr.responseText).Message;
                            }
                            CMI.DespliegaErrorDialogo(err);
                            CMI.botonMensaje(false, btn, 'Guardar');
                        }
                    });
                } else {
                    CMI.DespliegaErrorDialogo("Este explorador no soportado por la aplicacion favor de utilizar una version mas reciente. Chrome");
                    CMI.botonMensaje(false, btn, 'Guardar');
                }
            } else {
                if (PlanosDespiece.activeForm !== '#NuevoPlanosDespieceForm') {
                    PlanosDespiece.onActualizar(btn);
                } else {
                    $(PlanosDespiece.activeForm + ' #archivoPlanoDespiece').val('');
                    PlanosDespiece.onGuardar(btn);
                }
            }
        }
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

        PlanosDespiece.estatusRevision = idEstatusRevision;
        if (idEstatusRevision !== 1) {
            $('#RevisionPro').addClass('revisionCerrada');
            $('.btnNuevo').hide();
            PlanosDespiece.accBorrar = false;
            PlanosDespiece.accClonar = false;
            CMI.DespliegaError("La revision del proyecto esta Cerrada. La informacion es de solo lectura.");
        } else {
            $('#RevisionPro').removeClass('revisionCerrada');
        }

        //Se inicializa la informacion seleccionada a vacio
        $('#bbGrid-PlanosDespiece')[0].innerHTML = "";
        $('#idEtapaSelect').val(0);
        $('#nombreEtapa').text('Nombre Etapa');
        $('#FechaInicioEtapa').text('Fecha Inicio');
        $('#FechaFinEtapa').text('Fecha Fin');
        $('#idPlanoMontajeSelect').val('');
        $('#nombrePlanosMontaje').text('Nombre Plano Montaje');
        $('#FechaInicioPlanoMontaje').text('Fecha Inicio');
        $('#FechaFinPlanosMontaje').text('Fecha Fin');

        $('.btnNuevo').hide();
        $('#planosMontajeRow').hide();
        $('#etapaRow').show();
    },
    AsignaEtapa: function (idEtapa, NombreEtapa,
                           FechaInicio, FechaFin) {

        $('#idEtapaSelect').val(idEtapa);
        $('#nombreEtapa').text(NombreEtapa);
        $('#FechaInicioEtapa').text(FechaInicio);
        $('#FechaFinEtapa').text(FechaFin);
        $('#buscar-General').modal('hide');
        //Se carga el grid de PlanosDespiece asignadas a la etapa
        $('#bbGrid-PlanosDespiece')[0].innerHTML = "";

        $('.btnNuevo').hide();

        $('#idPlanoMontajeSelect').val('');
        $('#nombrePlanosMontaje').text('Nombre Plano Montaje');
        $('#FechaInicioPlanoMontaje').text('Fecha Inicio');
        $('#FechaFinPlanosMontaje').text('Fecha Fin');
        $('#planosMontajeRow').show();
    },
    AsignaPlanosMontaje: function (idPlanoMontaje, nombrePlanoMontaje,
                                    fechaInicio, fechaFin){
        $('#idPlanoMontajeSelect').val(idPlanoMontaje);
        $('#nombrePlanosMontaje').text(nombrePlanoMontaje);
        $('#FechaInicioPlanoMontaje').text(fechaInicio);
        $('#FechaFinPlanosMontaje').text(fechaFin);
        $('#buscar-General').modal('hide');
        //Se carga el grid de PlanosDespiece asignadas a la etapa
        $('#bbGrid-PlanosDespiece')[0].innerHTML = "";
        PlanosDespiece.CargaGrid();

        if (PlanosDespiece.estatusRevision === 1) {
            PlanosDespiece.ValidaPermisos();

            ///Muestra el boton de nueva PlanosDespiece
            if (PlanosDespiece.accEscritura === true)
                $('.btnNuevo').show();
        }

    },
    Nuevo: function () {
        CMI.CierraMensajes();
        var url = contextPath + "PlanosDespiece/Nuevo"; // El url del controlador      
        $.get(url, function (data) {
            $('#nuevo-PlanosDespiece').html(data);
            $('#nuevo-PlanosDespiece').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            CMI.RedefinirValidaciones(); //para los formularios dinamicos          
            PlanosDespiece.activeForm = '#NuevoPlanosDespieceForm';
            PlanosDespiece.CargarColeccionTipoConstru();
            PlanosDespiece.EventoNombreArchivo();
        });
    },
    Editar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "PlanosDespiece/Actualiza/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#actualiza-PlanosDespiece').html(data);
            $('#actualiza-PlanosDespiece').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            PlanosDespiece.activeForm = '#ActualizaPlanosDespieceForm';
            PlanosDespiece.CargarColeccionTipoConstru();
            PlanosDespiece.EventoNombreArchivo();

            if (PlanosDespiece.estatusRevision !== 1) {
                $('.btn-ActualizarPlanosDespiece').hide();
            } else {
                $('.btn-ActualizarPlanosDespiece').show();
            }
        });
    },
    Borrar: function (id) {
        CMI.CierraMensajes();
        if (confirm('¿Esta seguro que desea borrar el Plano Despiece (' + id + ') ?') === false) return;
        var url = contextPath + "PlanosDespiece/Borrar"; // El url del controlador
        $.post(url, {
            id: id
        }, function (data) {
            if (data.Success == true) {
                PlanosDespiece.colPlanosDespiece.remove(id);
                CMI.DespliegaInformacion(data.Message + "  " + id);
            }
            else {
                CMI.DespliegaError(data.Message);
            }
        }).fail(function () { CMI.DespliegaError("No se pudo borrar el Plano Montaje."); });
    },
    Clonar: function (id) {
        CMI.CierraMensajes();
        var url = contextPath + "PlanosDespiece/Clonar/" + id; // El url del controlador
        $.get(url, function (data) {
            $('#nuevo-PlanosDespiece').html(data);
            $('#nuevo-PlanosDespiece').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');

            CMI.RedefinirValidaciones(); //para los formularios dinamicos
            PlanosDespiece.activeForm = '#NuevoPlanosDespieceForm';
            PlanosDespiece.CargarColeccionTipoConstru();
            PlanosDespiece.EventoNombreArchivo();
        });
    },
    
    ValidaPermisos: function () {
        var permisos = localStorage.modPermisos,
            modulo = PlanosDespiece;

        modulo.accEscritura = permisos.substr(1, 1) === '1' ? true : false;
        modulo.accBorrar = permisos.substr(2, 1) === '1' ? true : false;
        modulo.accClonar = permisos.substr(3, 1) === '1' ? true : false;
    },
    serializaPlanosDespiece: function (id) {
        var form = PlanosDespiece.activeForm;
        return ({
            'nombrePlanoDespiece': $(form + ' #nombrePlanoDespiece').val().toUpperCase(),
            'codigoPlanoDespiece': $(form + ' #codigoPlanoDespiece').val().toUpperCase(),
            'nombreEstatus': $('#idEstatus option:selected').text().toUpperCase(),
            'nombreTipoContruccion': $('#idTipoConstruccion option:selected').text().toUpperCase(),
            'id': id
        });
    },
    CargaGrid: function () {
        var url = contextPath + "PlanosDespiece/CargaPlanosDespiece?idPlanoMontaje=" + $('#idPlanoMontajeSelect').val(); // El url del controlador
        $.getJSON(url, function (data) {
            $('#cargandoInfo').show();
            if (data.Success !== undefined) { CMI.DespliegaError(data.Message); return; }
            PlanosDespiece.colPlanosDespiece = new Backbone.Collection(data);
            var bolFilter = PlanosDespiece.colPlanosDespiece.length > 0 ? true : false;
            if (bolFilter) {
                gridPlanosDespiece = new bbGrid.View({
                    container: $('#bbGrid-PlanosDespiece'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: true,
                    detalle: false,
                    clone: PlanosDespiece.accClonar,
                    editar: PlanosDespiece.accEscritura,
                    borrar: PlanosDespiece.accBorrar,
                    collection: PlanosDespiece.colPlanosDespiece,
                    seguridad: PlanosDespiece.accSeguridad,
                    colModel: [{ title: 'Id', name: 'id', width: '8%', sorttype: 'number', filter: true, filterType: 'input' },
                               { title: 'Nombre Planos Despiece', name: 'nombrePlanoDespiece', filter: true, filterType: 'input' },
                               { title: 'Codigo', name: 'codigoPlanoDespiece', filter: true, filterType: 'input' },
                               { title: 'Tipo Construccion', name: 'nombreTipoContruccion', filter: true, filterType: 'input' },
                               { title: 'Estatus', name: 'nombreEstatus', filter: true }]
                });
                $('#cargandoInfo').hide();
            }
            else {
                CMI.DespliegaInformacion("No se encontraron Planos Despiece registradas para el Plano Montaje seleccionado.");
                $('#bbGrid-PlanosDespiece')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaError("No se pudo cargar la informacion de las PlanosDespiece");
        });
    },
    EventoNombreArchivo: function () {
        var form = PlanosDespiece.activeForm;
        //Se inicializan los eventos para el formulario
        $(form + ' .btn-file :file').on('fileselect', function (event, numFiles, label) {
            var input = $(this).parents('.input-group').find(':text'),
                log = numFiles > 1 ? numFiles + ' files selected' : label;

            if (input.length) {
                input.val(log);
            } else {
                if (log) console.log(log);
            }
        });

        $(document).on('change', '.btn-file :file', function () {
            var input = $(this),
                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });
    },
    CargarColeccionTipoConstru: function () {
        if (PlanosDespiece.colTipoConstruccion.length < 1) {
            var url = contextPath + "TipoConstruccion/CargaTiposConstruccionActivos"; // El url del controlador
            $.getJSON(url, function (data) {
                PlanosDespiece.colTipoConstruccion = data;
                PlanosDespiece.CargaListaTiposConstruccion();
            }).fail(function (e) {
                CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los Tipos de Construccion");
            });
        } else {
            PlanosDespiece.CargaListaTiposConstruccion();
        }
    },    
    CargaListaTiposConstruccion: function () {
        var form = PlanosDespiece.activeForm;
        var select = $(form + ' #idTipoConstruccion').empty();
        // constructs the suggestion engine               
        select.append('<option> </option>');

        $.each(PlanosDespiece.colTipoConstruccion, function (i, item) {
            select.append('<option value="'
                                 + item.id
                                 + '">'
                                 + item.NombreTipoConstruccion
                                 + '</option>');
        });

        $(form + ' #idTipoConstruccion').val($(form + ' #tipoConstruccion').val());
        //Inicializa el combo para que pueda hacer busquedas
        $(form + " .select2").select2({ allowClear: true, placeholder: 'Tipo Contruccion' });
    },
};

$(function () {
    PlanosDespiece.Inicial();
})