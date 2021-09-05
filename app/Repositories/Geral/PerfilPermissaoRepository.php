<?php

namespace App\Repositories\Geral;

use App\Models\Geral\PerfilPermissao;
use App\Repositories\Repository;

class PerfilPermissaoRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new PerfilPermissao();
    }
}
