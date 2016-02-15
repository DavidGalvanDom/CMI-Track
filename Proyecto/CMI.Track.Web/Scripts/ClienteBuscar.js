//js de lista de clientes.
//David Galvan
//15/Febrero/2016

var ClienteBuscar = {    
    colClientes: {},
    gridClientes: {},
    parent : {},
    Inicial: function () {
        $.ajaxSetup({ cache: false });
        this.CargaGrid();
        this.Eventos();        
    },
    Eventos: function () {
        var that = this;        
        $(document).on("click", '.btn-clienteSeleccionado', that.onSeleccionar);
    },
    onSeleccionar: function (idRow) {
        var rowSelected = ClienteBuscar.colClientes.get(idRow);
        ClienteBuscar.parent.AsignaCliente(rowSelected.attributes.id,
                                            rowSelected.attributes.NombreCliente,
                                            rowSelected.attributes.DireccionEntrega,
                                            rowSelected.attributes.ContactoCliente);
    },
    CargaGrid: function () {
        $('#cargandoInfoBC').show();
        var url = contextPath + "Cliente/CargaClientesActivos"; // El url del controlador
        $.getJSON(url, function (data) {
            if (data.Success !== undefined) { CMI.DespliegaErrorDialogo(data.Message); return; }
            ClienteBuscar.colClientes = new Backbone.Collection(data);
            var bolFilter = ClienteBuscar.colClientes.length > 0 ? true : false;
            if (bolFilter) {
                gridClientes = new bbGrid.View({
                    container: $('#bbGrid-buscaCliente'),
                    rows: 15,
                    rowList: [5, 15, 25, 50, 100],
                    enableSearch: false,
                    actionenable: false,
                    detalle: false,                   
                    collection: ClienteBuscar.colClientes,
                    colModel: [{ title: 'Cliente', name: 'NombreCliente', filter: true, filterType: 'input' },
                               { title: 'Direccion', name: 'DireccionEntrega', filter: true, filterType: 'input' },
                               { title: 'Colonia', name: 'ColoniaCliente', filter: true, filterType: 'input' },
                               { title: 'CP', name: 'CpCliente', filter: true, filterType: 'input' },
                               { title: 'Contacto', name: 'ContactoCliente', filter: true, filterType: 'input' },
                    ],
                    onRowDblClick: function () {
                        ClienteBuscar.onSeleccionar(this.selectedRows[0]);                       
                    }
                });
                $('#cargandoInfoBC').hide();
            } else {
                CMI.DespliegaInformacionDialogo("No se encontraron Clientes registrados");
                $('#bbGrid-buscaCliente')[0].innerHTML = "";
            }
            //getJSON fail
        }).fail(function (e) {
            CMI.DespliegaErrorDialogo("No se pudo cargar la informacion de los clientes");
        });
    }
};