<?php

namespace App\Repositories\Geral;

use App\Repositories\Repository;
use App\Models\Geral\CategoriaRecurso;

class CategoriaRecursoRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new CategoriaRecurso();
    }
}
