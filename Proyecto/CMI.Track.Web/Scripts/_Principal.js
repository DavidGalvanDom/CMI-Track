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
        if (localStorage.idUser === '' || localStorage.idUser === undefined) return;
        var urlEventos = contextPath + "Principal/_sideBar/" + localStorage.idUser;
        $.post(urlEventos, function (data) {
            if (data.substring(0, 5) === '<!DOC') return;
            $('#divSideBar').html(data);           
            $('#side-menu').metisMenu();
            CMI.SeleccionaOpcionMenu();
        });
    },
    ReiniciaLocalStorage: function (pUsuario, pNombre) {
        localStorage.setItem("idUser", pUsuario);
        localStorage.setItem("UserName", pNombre);              
    },
    SeleccionaOpcionMenu: function (){
        var url = window.location;        
        var element = $('ul.nav a').filter(function () {
            return this.href == url || url.href.indexOf(this.href) == 0;
        }).addClass('active').parent().parent().addClass('in').parent();
        if (element.is('li')) {
            element.addClass('active');            
        }        
        return (element);
    },
    setPermisos: function (datos) {       
        localStorage.modPermisos = datos;
        var item = document.getElementById('Permisos');       
        if (item != null) {
            localStorage.modSerdad = item.innerText;
        } else {
            localStorage.modSerdad = '00';
        }
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
        $(".clientAlertDlg").html("<div id='divMessage' class='alert alert-danger'>" +
                               "<button type='button' class='close' data-dismiss='alert'>x</button>" +
                                 error + "</div>");
    },
    DespliegaInformacionDialogo: function (msg) {
        $(".clientAlertDlg").html("<div id='divMessage' class='alert alert-info'>" +
                               "<button type='button' class='close' data-dismiss='alert'>x</button>" +
                                 msg + "</div>");        
    }
};