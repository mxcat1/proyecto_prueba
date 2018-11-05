<?php
/**
 * Created by PhpStorm.
 * User: MXCAT_PC
 * Date: 04/11/2018
 * Time: 13:59
 */
session_start();
session_destroy();
header('Location: ../../index.html');
