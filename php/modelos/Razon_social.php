<?php
/**
 * Created by PhpStorm.
 * User: MXCAT_PC
 * Date: 23/09/2018
 * Time: 23:44
 */

require_once "../conexion/conexion.php";

class Razon_social extends conexion_dbfe_a {


    /**
     * Razon_social constructor.
     */
    public function __construct(){
        parent::__construct();
    }
    public function clis_provees(){
        $sql="SELECT distinct Razon_Social ,if(Tipo_Movimiento = 'Venta','Cliente','Proveedor') as Tipo 
              from movimientos order by Razon_Social;";
        $consulta=$this->conexion_db->prepare($sql);
        $consulta->execute();
        $resultado=$consulta->get_result();

        while ($fila=$resultado->fetch_assoc()){
            $lista[]=$fila;
        }
        return $lista;


    }
    public function sele_clis_proves($tipo){
        $sql="SELECT distinct Razon_Social from movimientos where Tipo_Movimiento=? order by Razon_Social asc ";
        $consu=$this->conexion_db->prepare($sql);
        $consu->bind_param("s",$tipo);
        $consu->execute();
        $resul=$consu->get_result();
        while ($fila=$resul->fetch_assoc()){
            $lista[]=$fila;
        }
        return $lista;
    }

}