<?php
/**
 * Created by PhpStorm.
 * User: MXCAT_PC
 * Date: 21/09/2018
 * Time: 12:25
 */
require_once "../modelos/Productos.php";

$productos= new Productos();

$datos=json_decode(file_get_contents("php://input"));

$opcion=$datos->opcion;
switch ($opcion){
    case 'listarpro':
        $lista_pro=$productos->listar_productos();
        echo json_encode($lista_pro);
        break;
    case 'prostock':
        $prostock=$productos->mo_pro_stock();
        echo json_encode($prostock);
        break;
    case 'stockmin':
        $minstock=$productos->stock_min();
        echo json_encode($minstock);
        break;
    case 'masvendidos':
        $fecha=$datos->fecha;
        $vendidos=$productos->productos_mas_vendidos($fecha);
        if ($vendidos==null){
            http_response_code(400);
            $error="No se encontro productos en dicha fecha";
            echo json_encode($error);
        }else{
            echo json_encode($vendidos);
        }
        break;
}
