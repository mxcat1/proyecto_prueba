<?php
/**
 * Created by PhpStorm.
 * User: MXCAT_PC
 * Date: 04/11/2018
 * Time: 12:09
 */

require_once '../conexion/conexion.php';

class Usuarios extends conexion_dbfe_a{


    /**
     * Usuarios constructor.
     */
    public function __construct(){
        parent::__construct();
    }
    public function accesoususario($user,$pass){
        $sql='Select name,password from usuarios where name=? and password=?';
        $consu=$this->conexion_db->prepare($sql);
        $consu->bind_param('ss',$user,$pass);
        $consu->execute();
//        $consu->store_result();
//        $datos=$consu->num_rows;
        $respuesta=$consu->get_result();
        $datos=$respuesta->num_rows;
        if ($datos>0){
            while ($fila=$respuesta->fetch_assoc()){
                $lista[]=$fila;
            }
        }else{
            $lista=null;
        }
        return $lista;
    }
}