<?php

namespace App\DocumentsGenerators;

use App\Models\Pnae\DocumentoEmitido;

abstract class AbstractDocument 
{
    abstract public function gerarDocumento();
}