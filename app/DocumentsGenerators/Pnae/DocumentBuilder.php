<?php

namespace App\DocumentsGenerators\Pnae;

use DB;
use App\Log\CustomLog;

class DocumentBuilder 
{
    
    private $namespace = "App\\DocumentsGenerators\\Pnae\\Documents\\";

    public function __call($method, $arguments)
    {
        $class = ucfirst($method);

        $fullClass = $this->namespace.$class;

        if(!class_exists($fullClass)){
            throw new \Exception("Class not found. Class: ".$class, 1);
            die;
        }

        $usuario = auth()->user();

        try {

            DB::beginTransaction();
                $dados = call_user_func([new $fullClass(...$arguments), 'gerarDocumento']);
            DB::commit();

            CustomLog::log("Usuário {$usuario->int_usuario_id}:{$usuario->str_nome} obteve: Sucesso ao gerar documento. class: {$class}.", [$arguments]);

            return $dados;

        } catch (\Exception $ex) {
            DB::rollBack();

            echo "Não foi possível Gerar o Documento.";

            CustomLog::log("Usuário {$usuario->int_usuario_id}:{$usuario->str_nome} obteve: Erro ao gerar documento. class: {$class}. Excetion: {$ex->getMessage()}", [$arguments], 2);

        }
    }
}