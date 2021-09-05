<?php

namespace App\Tools;

class Auxiliar
{
    public static function mascaraCpfCnpj($cpfCnpj)
    {
        if (strlen($cpfCnpj) == 11) {
            $mascara = "###.###.###-##";
            $maskared = '';
            $k = 0;
            for ($i = 0; $i < strlen($mascara); $i++) {
                if($mascara[$i] == '#'){
                    if(isset($cpfCnpj[$k])){
                        $maskared .= $cpfCnpj[$k++];
                    }
                } else {
                    if($mascara[$i])
                        $maskared .= $mascara[$i];
                }
            }
        }else {
            $mascara = "##.###.###/####-##";
            $maskared = '';
            $k = 0;
            for ($i = 0; $i < strlen($mascara); $i++) {
                if($mascara[$i] == '#'){
                    if(isset($cpfCnpj[$k])){
                        $maskared .= $cpfCnpj[$k++];
                    }
                } else {
                    if($mascara[$i])
                        $maskared .= $mascara[$i];
                }
            }
        }
        return $maskared;
    }
}
