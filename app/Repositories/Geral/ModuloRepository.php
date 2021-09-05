<?php

namespace App\Repositories\Geral;

use App\Repositories\Repository;
use App\Models\Geral\Modulo;
use DB;

class ModuloRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new Modulo();
    }

    public function getModulosNaoVinculados($modulosVinculados)
    {
        $modulosNaoVinculados = DB::table('geral.tb_modulo')->select('int_modulo_id', 'str_nome')
                    ->whereNotIn('int_modulo_id', $modulosVinculados)->get();

        return $modulosNaoVinculados;
    }
}
