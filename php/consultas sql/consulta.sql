# 3.1

SELECT Codigo_Producto,Descripcion_Producto,Estado_Producto,Stock_Actual,Stock_Minimo FROM productos;

# 3.2

SELECT Codigo_Producto,Descripcion_Producto,Estado_Producto,Stock_Actual,Stock_Minimo from productos where Stock_Actual<Stock_Minimo;

# 3.3

SELECT distinct Razon_Social ,if(Tipo_Movimiento = 'Venta','Cliente','Proveedor') as Tipo
from movimientos order by Razon_Social;

# 3.4 Cambiar 12 por el mes y 2004 por el año q tu vas a poner

select DATE_FORMAT(M.Fecha,'%Y-%m') Fecha,P.Descripcion_Producto,sum(DM.Cantidad_Producto) as Total from movimientos as M
    inner join detalle_movimientos as DM
      on M.Codigo_Movimiento=DM.Codigo_Movimiento
    inner join productos as P
      on P.Codigo_Producto=DM.Codigo_Producto where M.Fecha like '2004-01%'
group by P.Descripcion_Producto,DATE_FORMAT(M.Fecha,'%Y-%m') order by Total desc limit 0,30 ;

# 3.5 Cambiar 12 por el mes y 2004 por el año q tu vas a poner
use bdferreteria;
select sum(DM.Cantidad_Producto * DM.Precio_Unitario) as Total from movimientos as M
    inner join detalle_movimientos as DM
      on M.Codigo_Movimiento=DM.Codigo_Movimiento
    inner join productos as P
      on P.Codigo_Producto=DM.Codigo_Producto where M.Fecha like '2004-01%' #año y mes
group by M.Tipo_Movimiento;

# 3.6
select M.Fecha,M.Razon_Social,M.Tipo_Movimiento,sum(DM.Cantidad_Producto*DM.Precio_Unitario) Total from movimientos M
    inner join detalle_movimientos DM
      on M.Codigo_Movimiento=DM.Codigo_Movimiento
    inner join productos P
      on P.Codigo_Producto=DM.Codigo_Producto where M.Tipo_Movimiento='Compra' and M.Fecha like '2004-01%'
group by M.Fecha,M.Razon_Social;
# 3.7
select M.Fecha,M.Razon_Social,M.Tipo_Movimiento,sum(DM.Cantidad_Producto*DM.Precio_Unitario) Total from movimientos M
    inner join detalle_movimientos DM
      on M.Codigo_Movimiento=DM.Codigo_Movimiento
    inner join productos P
      on P.Codigo_Producto=DM.Codigo_Producto where M.Tipo_Movimiento='Venta' and M.Fecha like '2004-01%'
group by M.Fecha,M.Razon_Social;

# 3.8
select M.Fecha, M.Numero_Comprobante , M.Tipo_Comprobante, sum(DM.Cantidad_Producto*DM.Precio_Unitario) Monto from movimientos M
    inner join detalle_movimientos DM
      on M.Codigo_Movimiento=DM.Codigo_Movimiento
where M.Tipo_Comprobante='Factura' and M.Fecha like '2004-12%'
group by M.Codigo_Movimiento;
# 3.9
SELECT distinct Razon_Social from movimientos where Tipo_Movimiento='Compra' order by Razon_Social asc;

select Numero_Comprobante,Tipo_Comprobante from movimientos where Tipo_Comprobante='Factura' and Razon_Social='ALFREDO QUISPE TORRES';

select M.Numero_Comprobante,M.Razon_Social,P.Descripcion_Producto,DM.Cantidad_Producto,(DM.Cantidad_Producto*DM.Precio_Unitario)Monto
  from movimientos M
      inner join detalle_movimientos DM
            on M.Codigo_Movimiento=DM.Codigo_Movimiento
      inner join productos P
            on P.Codigo_Producto=DM.Codigo_Producto
where M.Numero_Comprobante=32910 and M.Razon_Social='BENEDICTO CABRERA FARFAN'

# 3.10
SELECT distinct Razon_Social from movimientos where Tipo_Movimiento='Compra' order by Razon_Social asc;

select Numero_Comprobante,Tipo_Comprobante from movimientos where Tipo_Comprobante='Factura' and Razon_Social='ALFREDO QUISPE TORRES';

select M.Numero_Comprobante,M.Razon_Social,P.Descripcion_Producto,DM.Cantidad_Producto,(DM.Cantidad_Producto*DM.Precio_Unitario)Monto
from movimientos M
       inner join detalle_movimientos DM
         on M.Codigo_Movimiento=DM.Codigo_Movimiento
       inner join productos P
         on P.Codigo_Producto=DM.Codigo_Producto
where M.Numero_Comprobante=32910 and M.Razon_Social='BENEDICTO CABRERA FARFAN'