select sum(DM.Precio_Unitario) as Total from movimientos as M
  inner join detalle_movimientos as DM
    on M.Codigo_Movimiento=DM.Codigo_Movimiento
  inner join productos as P
    on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=12 and year(M.Fecha)=2004
#                                                   and M.Tipo_Movimiento='Venta'
group by M.Tipo_Movimiento;

create procedure ventas_compras(mes int, ano int)
  begin
    select sum(DM.Precio_Unitario) as Total from movimientos as M
      inner join detalle_movimientos as DM
        on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
        on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=mes and year(M.Fecha)=ano
    group by M.Tipo_Movimiento;
  end;
drop procedure ventas_compras;
call ventas_compras(12,2004);

select M.Codigo_Movimiento,M.Fecha,P.Descripcion_Producto,sum(DM.Cantidad_Producto) as Total from movimientos as M
  inner join detalle_movimientos as DM
    on M.Codigo_Movimiento=DM.Codigo_Movimiento
  inner join productos as P
    on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=12 and year(M.Fecha)=2004
group by P.Descripcion_Producto order by sum(DM.Cantidad_Producto) desc limit 0,30 ;


CREATE procedure mas_vendidos(mes int ,ano int)
  begin
    select M.Codigo_Movimiento,M.Fecha,P.Descripcion_Producto,sum(DM.Cantidad_Producto) as Total from movimientos as M
      inner join detalle_movimientos as DM
        on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
        on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=mes and year(M.Fecha)=ano
    group by P.Descripcion_Producto order by sum(DM.Cantidad_Producto) desc limit 0,30 ;
  end;
drop procedure mas_vendidos;
call mas_vendidos(11,2004);


select max(p.total) from (select sum(DM.Cantidad_Producto) as total from movimientos as M
  inner join detalle_movimientos as DM
    on M.Codigo_Movimiento=DM.Codigo_Movimiento
  inner join productos as P
    on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=1 and year(M.Fecha)=2004
group by P.Descripcion_Producto order by DM.Cantidad_Producto desc limit 0,30) as p;

select * from productos where Descripcion_Producto='REMOVEDOR TEKNO';

select P.Descripcion_Producto,DM.Cantidad_Producto,DM.Precio_Unitario from movimientos as M
  inner join detalle_movimientos as DM
    on M.Codigo_Movimiento=DM.Codigo_Movimiento
  inner join productos as P
    on P.Codigo_Producto=DM.Codigo_Producto where P.Descripcion_Producto='REMOVEDOR TEKNO';
create procedure masvendidos(mes int , ano int)
  begin
    declare minimo decimal;
    declare maximo decimal;
    set maximo = (select max(p.total) from (select sum(DM.Cantidad_Producto) as total from movimientos as M
      inner join detalle_movimientos as DM
        on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
        on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=mes and year(M.Fecha)=ano
    group by P.Descripcion_Producto order by sum(DM.Cantidad_Producto) desc limit 0,30) as p);
    set minimo =(select min(p.total) from (select sum(DM.Cantidad_Producto) as total from movimientos as M
      inner join detalle_movimientos as DM
        on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
        on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=mes and year(M.Fecha)=ano
    group by P.Descripcion_Producto order by sum(DM.Cantidad_Producto) desc limit 0,30) as p);
    select M.Codigo_Movimiento,M.Fecha,P.Descripcion_Producto,sum(DM.Cantidad_Producto) as total from movimientos as M
      inner join detalle_movimientos as DM
        on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
        on P.Codigo_Producto=DM.Codigo_Producto where (MONTH(M.Fecha)=mes and year(M.Fecha)=ano)
    group by P.Descripcion_Producto
    HAVING total>minimo and total<=maximo
    order by sum(DM.Cantidad_Producto) desc limit 0,30;
  end;
drop procedure masvendidos;

call masvendidos(12,2004);

use bdferreteria;
select count(*)/14 from productos;
SELECT Codigo_Producto,Descripcion_Producto,Estado_Producto,Stock_Actual,Stock_Minimo FROM productos limit 1143,10;

SELECT Codigo_Producto,Descripcion_Producto,Estado_Producto,Stock_Actual,Stock_Minimo
from productos
where Stock_Actual<Stock_Minimo;


select distinct Razon_Social,Tipo_Comprobante from movimientos order by Tipo_Comprobante;
select distinct Razon_Social,if(Tipo_Comprobante = "Boleta","Cliente","Proveedor") as Tipo
from movimientos order by Tipo_Comprobante;

select M.Codigo_Movimiento,month(M.Fecha),P.Descripcion_Producto,DM.Cantidad_Producto from movimientos as M
      inner join detalle_movimientos as DM
          on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
          on P.Codigo_Producto=DM.Codigo_Producto where MONTH(M.Fecha)=2 and DAY(M.Fecha)=1;

select sum(DM.Precio_Unitario) as Total from movimientos as M
      inner join detalle_movimientos as DM
          on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos as P
          on P.Codigo_Producto=DM.Codigo_Producto where M.Fecha like '2004-01%' #año y mes
group by M.Tipo_Movimiento;

create procedure mas_vendidos(fecha varchar(100))
  begin
    select DATE_FORMAT(M.Fecha,'%Y-%m') Fecha,P.Descripcion_Producto,sum(DM.Cantidad_Producto) as Total from movimientos as M
          inner join detalle_movimientos as DM
              on M.Codigo_Movimiento=DM.Codigo_Movimiento
          inner join productos as P
              on P.Codigo_Producto=DM.Codigo_Producto where M.Fecha like concat(fecha,'%')
    group by P.Descripcion_Producto,DATE_FORMAT(M.Fecha,'%Y-%m') order by Total desc limit 0,30 ;
  end;
drop procedure mas_vendidos;
call mas_vendidos('2004-01');

create procedure total_ventas_compras(ano_mes varchar(100))
  begin
    select sum(DM.Cantidad_Producto * DM.Precio_Unitario) as Total from movimientos as M
          inner join detalle_movimientos as DM
              on M.Codigo_Movimiento=DM.Codigo_Movimiento
          inner join productos as P
              on P.Codigo_Producto=DM.Codigo_Producto where M.Fecha like concat(ano_mes,'%') #año y mes
    group by M.Tipo_Movimiento;
  end;
drop procedure total_ventas_compras;
CALL total_ventas_compras('2004-01');

create procedure compras_prove(fecha varchar(100))
  begin
    select M.Fecha,M.Razon_Social,M.Tipo_Movimiento,sum(DM.Cantidad_Producto*DM.Precio_Unitario) Total from movimientos M
        inner join detalle_movimientos DM
            on M.Codigo_Movimiento=DM.Codigo_Movimiento
        inner join productos P
            on P.Codigo_Producto=DM.Codigo_Producto where M.Tipo_Movimiento='Compra' and M.Fecha like concat(fecha,'%')
    group by M.Fecha,M.Razon_Social;
  end;
drop procedure compras_prove;
call compras_prove('2004-12');

# select M.Codigo_Movimiento,M.Fecha,M.Razon_Social,P.Descripcion_Producto,M.Tipo_Movimiento,DM.Cantidad_Producto*DM.Precio_Unitario
#       from movimientos M
#           inner join detalle_movimientos DM
#                 on M.Codigo_Movimiento=DM.Codigo_Movimiento
#           inner join productos P
#                 on P.Codigo_Producto=DM.Codigo_Producto where M.Fecha like '2004-01%'
# group by M.Razon_Social;

create procedure ventas_cli(fecha varchar(100))
  begin
    select M.Fecha,M.Razon_Social,M.Tipo_Movimiento,sum(DM.Cantidad_Producto*DM.Precio_Unitario) Total from movimientos M
          inner join detalle_movimientos DM
              on M.Codigo_Movimiento=DM.Codigo_Movimiento
          inner join productos P
              on P.Codigo_Producto=DM.Codigo_Producto where M.Tipo_Movimiento='Venta' and M.Fecha like concat(fecha,'%')
    group by M.Fecha,M.Razon_Social;
  end;
drop procedure ventas_cli;
call ventas_cli('2004-01');


select M.Fecha, M.Numero_Comprobante , M.Tipo_Comprobante, sum(DM.Cantidad_Producto*DM.Precio_Unitario) Monto from movimientos M
      inner join detalle_movimientos DM
          on M.Codigo_Movimiento=DM.Codigo_Movimiento
where M.Tipo_Comprobante='Factura' and M.Fecha like '2004-12%'
group by M.Codigo_Movimiento;


create procedure bol_fac(tipo varchar(100) , fecha varchar(100))
  begin
    select M.Codigo_Movimiento,M.Fecha, M.Numero_Comprobante , M.Tipo_Comprobante, sum(DM.Cantidad_Producto*DM.Precio_Unitario) Monto from movimientos M
          inner join detalle_movimientos DM
              on M.Codigo_Movimiento=DM.Codigo_Movimiento
    where M.Tipo_Comprobante=tipo and M.Fecha like concat(fecha,'%')
    group by M.Codigo_Movimiento;
  end;
drop procedure bol_fac;
call bol_fac('Boleta','2004-01');
call bol_fac(null ,null );


create procedure det_bol_fac(nro_co int,usu varchar(255))
  begin
    select M.Numero_Comprobante,M.Razon_Social,P.Descripcion_Producto,DM.Cantidad_Producto,(DM.Cantidad_Producto*DM.Precio_Unitario)Monto from movimientos M
                                                                                                                                                 inner join detalle_movimientos DM
                                                                                                                                                   on M.Codigo_Movimiento=DM.Codigo_Movimiento
                                                                                                                                                 inner join productos P
                                                                                                                                                   on P.Codigo_Producto=DM.Codigo_Producto
    where M.Numero_Comprobante=nro_co and M.Razon_Social=usu;
  end;
drop procedure det_bol_fac;
call det_bol_fac(2869,'A & C CONTRATISTAS GENERALES S.R.L.');