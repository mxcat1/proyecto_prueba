let app= angular.module('login',[]);

app.controller("loginController",['$scope','$http',function (s, h) {
    s.usuario_datos={};
    s.errores={};
    s.login=function () {
        h({
            method:'POST',
            url:'php/controladores/Usuarios.php',
            data:{opcion:'login',usuarios:s.usuario_datos}
        }).then(function (data) {
            s.errores=[];
            console.log(data.data[0].name)
            alert('Usuario '+ data.data[0].name +' Logueado Sadisfactoriamente');
            window.location.href='sistema.php';
        },function (error) {
            s.errores=error.data.errores;
            alert('No existe el usuario '+s.usuario_datos.usuario)
        })
    }
}]);

let index = angular.module('index',[]);

index.controller('indexController',['$scope','$http',function (s,h) {
    s.productos={};
    s.errores={};
    s.cuenta=[1,2,3,4,5,6,7,8,9];
    s.mostrar_productos=function () {
        h({
            method: 'POST',
            url: 'php/controladores/Productos.php',
            data:{opcion: 'listarpro'}
        }).then(function (data) {
            s.productos=data.data;
            console.log(s.productos)
            console.log(s.cuenta[0])
        })
    }
    s.mostrar_productos();
}]);

let productos= angular.module('productos',[]);
productos.controller('productosController',['$scope','$http',function (s,h) {
    s.tipo_reporte=0;
    s.productos={};
    s.currentPage = 0;
    s.pageSize = 50;
    s.pages = [];
    s.fecha1='';
    s.errores='';

    s.listar_pro=function () {
        h({
            method:'POST',
            url:'php/controladores/Productos.php',
            data:{opcion:'prostock'}
        }).then(function (pro) {
            s.productos=pro.data;
            s.tipo_reporte=1;
            console.log(s.productos.length)
        })
    };
    s.stock_minimo=function(){
        h({
            method:'POST',
            url:'php/controladores/Productos.php',
            data:{opcion:'stockmin'}
        }).then(function (pro) {
            s.productos=pro.data;
            s.tipo_reporte=2;
            console.log(s.productos)
        })
    };
    s.masvendidos_cambio=function(){
        s.tipo_reporte=3;
        s.productos=null;
        console.log(s.productos)
    };
    s.masvendidos=function(){
        s.fecha1=$('#fecha').val();
        h({
            method:'POST',
            url:'php/controladores/Productos.php',
            data:{opcion:'masvendidos',fecha:s.fecha1}
        }).then(function (pro) {
            s.errores=null;
            s.productos=pro.data;
            console.log(s.productos)
        },function (err) {
            s.errores=err.data;
        })
    };

    s.configPages = function() {
        s.pages.length = 0;
        let ini = s.currentPage - 4;
        let fin = s.currentPage + 5;
        if (ini < 1) {
            ini = 1;
            if (Math.ceil(s.productos.length / s.pageSize) > 10)
                fin = Math.ceil(s.productos.length / s.pageSize);
            else
                fin = Math.ceil(s.productos.length / s.pageSize);
        } else {
            if (ini >= Math.ceil(s.productos.length / s.pageSize) - 10) {
                ini = Math.ceil(s.productos.length / s.pageSize) - 10;
                fin = Math.ceil(s.productos.length / s.pageSize);
            }
        }
        if (ini < 1) ini = 1;
        for (let i = ini; i <= fin; i++) {
            s.pages.push({
                no: i
            });
        }

        if (s.currentPage >= s.pages.length)
            s.currentPage = s.pages.length - 1;
    };

    s.setPage = function(index) {
        s.currentPage = index - 1;
    };

}]).filter('startFromGrid', function() {
        return function(input, start) {
            start = +start;
            return input.slice(start);
        }
    });

let razon_social=angular.module('razon_social',[]);

razon_social.controller('razon_sController',["$scope","$http",function (s, h) {
    s.tipo_reporte_rs=0;
    s.razon_social=[];
    s.clientes={};
    s.proveedores={};
    s.errores=[];
    s.currentPage = 0;
    s.pageSize = 50;
    s.pages = [];
    s.listar_razon_social=function () {
        h({
            method:'POST',
            url:'php/controladores/Razon_social.php',
            data:{opcion:'listar_clipro'}
        })
            .then(function (data) {
                s.razon_social=data.data;
                console.log(data.data)
                s.tipo_reporte_rs=1;
        })
    };
    s.configPages = function() {
        s.pages.length = 0;
        let ini = s.currentPage - 4;
        let fin = s.currentPage + 5;
        if (ini < 1) {
            ini = 1;
            if (Math.ceil(s.razon_social.length / s.pageSize) > 10)
                fin = Math.ceil(s.razon_social.length / s.pageSize);
            else
                fin = Math.ceil(s.razon_social.length / s.pageSize);
        } else {
            if (ini >= Math.ceil(s.razon_social.length / s.pageSize) - 10) {
                ini = Math.ceil(s.razon_social.length / s.pageSize) - 10;
                fin = Math.ceil(s.razon_social.length / s.pageSize);
            }
        }
        if (ini < 1) ini = 1;
        for (let i = ini; i <= fin; i++) {
            s.pages.push({
                no: i
            });
        }

        if (s.currentPage >= s.pages.length)
            s.currentPage = s.pages.length - 1;
    };

    s.setPage = function(index) {
        s.currentPage = index - 1;
    };

}])
    .filter('startFromGrid', function() {
    return function(input, start) {
        start = +start;
        return input.slice(start);
    }
});

let movimientos=angular.module('movimientos',[]);

movimientos.controller('movimientosController',['$scope','$http',function (s, h) {
    s.movimientos={};
    s.tipo_reporte_m=0;
    s.errores={};
    s.datosm=['Compras','Ventas'];
    s.fecham='';
    s.totaldinero=function () {
        let fecha=$('#fecha').val();
        s.fecham=fecha;
        h({
            method:'POST',
            url:'php/controladores/Movimientos.php',
            data:{opcion:'totaldinero',fecha:fecha}
        })
            .then(function (data) {
                s.errores=null;
                s.movimientos=data.data;
                console.log(data.data)
            },function (error) {
                s.errores=error.data;
            })
    }
    s.mostrarform=function () {
        s.errores=null;
        s.movimientos=null;
        s.tipo_reporte_m=1;
    }
}]);


