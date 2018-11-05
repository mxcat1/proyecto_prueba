<?php
/**
 * Created by PhpStorm.
 * User: Mxcat_LAP
 * Date: 20/09/2018
 * Time: 18:12
 */

require_once ("config.php");

class conexion_dbfe_a{

    protected $conexion_db;

    /**
     * conexion_dbfe constructor.
     */
    public function __construct()
    {
        $this->conexion_db=new mysqli(DB_HOST,DB_USER,DB_PASS,DB_DBNAME);
        if ($this->conexion_db->errno){
            echo "FALLO LA CONECCION ALA BASE DE DATOS".$this->conexion_db->error;
        }
        $this->conexion_db->set_charset(DB_CHARSET);
        $this->conexion_db->query("SET NAMES 'utf8'");
    }


}