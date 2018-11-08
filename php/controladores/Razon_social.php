<?php
/**
 * Created by PhpStorm.
 * User: MXCAT_PC
 * Date: 23/09/2018
 * Time: 23:50
 */
require_once "../modelos/Razon_social.php";

$razon_social= new Razon_social();
$datos=json_decode(file_get_contents("php://input"));

$opcion=$datos->opcion;
switch ($opcion){
    case 'listar_clipro':
        echo json_encode($razon_social->clis_provees());
        break;
}