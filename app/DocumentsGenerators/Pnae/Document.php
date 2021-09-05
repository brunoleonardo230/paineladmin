<?php

namespace App\DocumentsGenerators\Pnae;

use App\Models\Geral\Modulo;
use App\Models\Pnae\DocumentoEmitido;

trait Document 
{

    public function registrarEmissao($html, $nomeArquivo, $token)
    {
        $dados = [
            'html' => $html, 
            'nome_arquivo' => $nomeArquivo, 
            'cliente_id' => session('cliente_logado') ?? 0, 
            'usuario_emissor_id' => auth()->user()->int_usuario_id,
            'token' => $token
        ];

        return DocumentoEmitido::create($dados);
    }

    public function getToken()
    {
        $token = uniqid();
        $idModulo = Modulo::getIdModuloAtual();

        if($idModulo):
           return $token .= $idModulo . session('cliente_logado') ?? 0;
        else:
            throw new \Exception("Não foi possível localizar o módulo para gerar o token", 1);
        endif;
    }

}