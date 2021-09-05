<?php

namespace App\Repositories\Geral;

use App\Repositories\Repository;
use App\Models\Geral\Recurso;
use DB;

class RecursoRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new Recurso();
    }

    public function getAll()
    {
        $sql = 'SELECT cr.str_nome as categoria_recurso, m.str_nome as modulo, r.int_recurso_id, r.int_modulo_id, r.int_categoria_recurso_id, r.str_nome, r.int_ordem
                FROM geral.tb_recurso r
                INNER JOIN geral.tb_categoria_recurso cr ON cr.int_categoria_recurso_id = r.int_categoria_recurso_id
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = r.int_modulo_id
                ORDER BY m.str_nome';

        return DB::select($sql);
    }
}
