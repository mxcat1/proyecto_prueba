<?php
/**
 * Created by PhpStorm.
 * User: Mxcat_LAP
 * Date: 28/09/2018
 * Time: 11:16
 */

require_once ("../conexion/conexion.php");

class Movimientos extends conexion_dbfe_a {


    /**
     * Movimientos constructor.
     */
    public function __construct(){
        parent::__construct();
    }

    public function ventas_compras_total($fecha){
        $sql="CALL total_ventas_compras(?);";
        $consu=$this->conexion_db->prepare($sql);
        $consu->bind_param("s",$fecha);
        $consu->execute();
        $resultado=$consu->get_result();

        while ($fila=$resultado->fetch_assoc()){
            $lista[]=$fila;
        }
        if (isset($lista)){
            return $lista;
        }else{
            return null;
        }
    }
    public function compras_proves($fecha){
        $sql="CALL compras_prove(?)";
        $consulta=$this->conexion_db->prepare($sql);
        $consulta->bind_param("s",$fecha);
        $consulta->execute();
        $resul=$consulta->get_result();
        while ($fila=$resul->fetch_assoc()){
            $lista[]=$fila;
        }
        if (isset($lista)){
            return $lista;
        }else{
            return null;
        }

    }
    public function ventas_clis($fecha){
        $sql="CALL ventas_cli(?)";
        $consulta=$this->conexion_db->prepare($sql);
        $consulta->bind_param("s",$fecha);
        $consulta->execute();
        $resul=$consulta->get_result();
        while ($fila=$resul->fetch_assoc()){
            $lista[]=$fila;
        }
        if (isset($lista)){
            return $lista;
        }else{
            return null;
        }

    }
    public function bol_fac($tipo,$fecha){
        $sql="CALL bol_fac(?,?)";
        $consu=$this->conexion_db->prepare($sql);
        $consu->bind_param( "ss",$tipo,$fecha);
        $consu->execute();
        $resultado=$consu->get_result();
        while ($fila=$resultado->fetch_assoc()){
            $lista[]=$fila;
        }
        if (isset($lista)){
            return $lista;
        }else{
            return null;
        }

    }
    public function mostrar_nro_compro($tipo,$prove){
        $sql="select Numero_Comprobante,Tipo_Comprobante from movimientos where Tipo_Comprobante=? and Razon_Social=? order by Numero_Comprobante desc ;";
        $consu=$this->conexion_db->prepare($sql);
        $consu->bind_param("ss",$tipo,$prove);
        $consu->execute();
        $resul=$consu->get_result();
        while ($fila=$resul->fetch_assoc()){
            $lista[]=$fila;
        }
        if (isset($lista)){
            return $lista;
        }else{
            return null;
        }

    }
    public function det_bol_fac($nro_com,$usu){
        $sql="CALL det_bol_fac(?,?)";
        $consu=$this->conexion_db->prepare($sql);
        $consu->bind_param("is",$nro_com,$usu);
        $consu->execute();
        $resul=$consu->get_result();
        while ($fila=$resul->fetch_assoc()){
            $lista[]=$fila;
        }
        if (isset($lista)){
            return $lista;
        }else{
            return null;
        }
    }

}