<?php
/**
 * Created by PhpStorm.
 * User: Mxcat_LAP
 * Date: 23/10/2018
 * Time: 7:47
 */
require_once "../modelos/Productos.php";
require_once "../libs/dompdf/autoload.inc.php";
use Dompdf\Dompdf;
$productos=new Productos();
$array_pro=$productos->mo_pro_stock();
$html_text= "<style>
                @page { 
                    margin: 100px 50px; 
                }
                table, th, td {
                    border: 1px solid black;
                }
                th{
                    background: #5fcbc4;
                }
                h2{
                    text-align: center;
                }
                #header { 
                    position: fixed;
                    left: 0px; 
                    top: -90px;
                    right: 0px; 
                    height: 80px;
                }
                #footer {
                    position: fixed;
                    left: 600px;
                    bottom: -30px;
                    right: 0px;
                    height: 10px;
                }
                #footer .page:after { 
                    content: counter(page, upper-roman);
                }
            </style>";
$html_text.="<div id='header'>
                <img src='../../img/carro.png'>
             </div>
	     <div id='footer'>
		<p class='page'>Pagina </p>
	     </div>
             <h2>REPORTE PRODUCTOS</h2>
             <hr>
             <hr>
             <br>";
$html_text.="<table>
                <tr>
                    <th>Codigo Producto</th>
                    <th>Descripcion Producto</th>
                    <th>Estado Producto</th>
                    <th>Stock Actual</th>
                    <th>Stock Minimo</th>
                </tr>";
foreach ($array_pro as $elemento){
    $html_text.="<tr>
                    <td>".$elemento['Codigo_Producto']."</td>
                    <td>".$elemento['Descripcion_Producto']."</td>
                    <td>".$elemento['Estado_Producto']."</td>
                    <td>".$elemento['Stock_Actual']."</td>
                    <td>".$elemento['Stock_Minimo']."</td>
                  </tr>";
}
$html_text.="</table>";
//echo $html_text;
$dompdf=new Dompdf();
$dompdf->loadHtml($html_text);
$dompdf->setPaper('A4','portrait');
$dompdf->render();
$dompdf->stream('Reporte Productos.pdf');