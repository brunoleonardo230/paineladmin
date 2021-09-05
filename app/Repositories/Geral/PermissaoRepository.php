<?php

namespace App\Repositories\Geral;

use App\Repositories\Repository;
use App\Models\Geral\Permissao;
use DB;

class PermissaoRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new Permissao();
    }

    public function getAll()
    {
        $sql = 'SELECT m.str_nome as modulo, r.str_nome as recurso, p.int_permissao_id, p.str_nome, p.str_descricao
                FROM geral.tb_permissao p
                INNER JOIN geral.tb_recurso r ON r.int_recurso_id = p.int_permissao_recurso_id
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = r.int_modulo_id
                ORDER BY m.str_nome, r.str_nome';

        return DB::select($sql);
    }
}
