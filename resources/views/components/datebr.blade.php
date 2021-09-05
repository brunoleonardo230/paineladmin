<?php
    setlocale(LC_TIME, 'pt_BR', 'pt_BR.utf-8', 'pt_BR.utf-8', 'portuguese');
    date_default_timezone_set('America/Sao_Paulo');

    $data = isset($date)? $date : date('Y-m-d');
    
    /*
    // %d = dia numerico
    // %a = nome do dia abreviado
    // %A = dia por extenso

    // %m = mes numerico
    // %b = nome do mes abreviado
    // %B = mês por extenso

    // %Y = ano
    // Doc. https://www.tutorialspoint.com/strftime-function-in-php
    */
    $formato = isset($format)? $format : "%d/%m/%Y";

?>

{{ utf8_encode(strftime($formato, strtotime($data))) }}

