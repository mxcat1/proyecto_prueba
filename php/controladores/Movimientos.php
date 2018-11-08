<?php
/**
 * Created by PhpStorm.
 * User: Mxcat_LAP
 * Date: 28/09/2018
 * Time: 11:20
 */
require_once "../modelos/Movimientos.php";

$movimientos=new Movimientos();

$datos=json_decode(file_get_contents("php://input"));

$opcion=$datos->opcion;
switch ($opcion){
    case 'totaldinero':
        $fecha=$datos->fecha;
        $totalventacompras=$movimientos->ventas_compras_total($fecha);
        if ($totalventacompras==null){
            http_response_code(400);
            $error="No se encontro productos en dicha fecha";
            echo json_encode($error);
        }else{
            echo json_encode($totalventacompras);
        }
        break;
}

