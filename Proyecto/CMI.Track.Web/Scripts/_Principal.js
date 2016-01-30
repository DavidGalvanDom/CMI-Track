var CMI = {    
    inicial: function () {
        try {
            if (Inicio !== undefined) {
                Inicio.CargarLocalStorage();
            }
        } catch (exp) {
        };
       
        CMI.eventos();       
        CMI.CargaSideBar();
    },
    eventos: function () {
        //Eventos generales
    },   
    CargaSideBar: function () {
        if (localStorage.Perfil === '' || localStorage.Perfil === undefined) return;
        var urlEventos = contextPath + "Principal/_sideBar?perf=" + localStorage.Perfil;
        $.post(urlEventos, function (data) {
            if (data.substring(0, 5) === '<!DOC') return;

            $('#divSideBar').html(data);
            CMI.incluyeEventoHref();
            try {
                sideBar.seleccionaOpcion();
            } catch (exp) { }
        });
    },
    ReiniciaLocalStorage: function (pUsuario, pNombre) {
        localStorage.setItem("idUser", pUsuario);
        localStorage.setItem("UserName", pNombre);              
    },
    ValidaFecha: function (pDate) {
        //yyyy-mm-dd
        var reg = /^\d{4}-((0\d)|(1[012]))-(([012]\d)|3[01])$/;
        return reg.test(pDate);
    },
    ValidaCorreo: function (pCorreo) {
        //name@domain.com
        var reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
        return reg.test(pCorreo);
    },
    RedefinirValidaciones: function () {
        $("form").removeData("validator");
        $("form").removeData("unobtrusiveValidation");
        $.validator.unobtrusive.parse("form");
    },
    CierraMensajes: function () {
        $(".clientAlert").html('');
        $(".clientAlertDlg").html('');
    },
    DespliegaError: function (error) {
        $(".clientAlert").html("<div class='alert alert-danger'>" +
                                "<button type='button' class='close' data-dismiss='alert'>x</button>" +
                                  error + "</div>");
        setTimeout(CMI.CierraMensajes, 10000);
    },
    DespliegaInformacion: function (msg) {
        $(".clientAlert").html("<div class='alert alert-info'>" +
                                "<button type='button' class='close' data-dismiss='alert'>x</button>" +
                                  msg + "</div>");
        setTimeout(CMI.CierraMensajes, 10000);
    },
    DespliegaErrorDialogo: function (error) {
        $(".clientAlertDlg").html("<div class='alert alert-danger'>" +
                               "<button type='button' class='close' data-dismiss='alert'>x</button>" +
                                 error + "</div>");
    },
    DespliegaInformacionDialogo: function (msg) {
        $(".clientAlertDlg").html("<div class='alert alert-info'>" +
                               "<button type='button' class='close' data-dismiss='alert'>x</button>" +
                                 msg + "</div>");        
    }
};