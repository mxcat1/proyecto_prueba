<?php
/**
 * Created by PhpStorm.
 * User: MXCAT_PC
 * Date: 04/11/2018
 * Time: 12:29
 */
require_once '../modelos/Usuarios.php';

$usuarios= new Usuarios();

$datos=json_decode(file_get_contents("php://input"));

$opcion=$datos->opcion;

switch ($opcion){
    case 'login':
        $name=$datos->usuarios->usuario;
        $password=$datos->usuarios->contrasena;
        $datos_usuario=$usuarios->accesoususario($name,$password);
        $errores=['errores'=>[]];
        if ($datos_usuario!=null){
            foreach ($datos_usuario as $item){
                session_start();
                $_SESSION['usuario']=$item['name'];
                $_SESSION['contraseña']=$item['password'];
            }
            echo json_encode($datos_usuario);

        }else{
            http_response_code(400);
            array_push($errores['errores'],"Usuario Incorrecto");
            echo json_encode($errores);
        }
        break;
    case 'cerrar':
        session_destroy();
        $mensaje=['m1'=>'Session Cerrada'];
        echo json_encode($mensaje);
        break;
}