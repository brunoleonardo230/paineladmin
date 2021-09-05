<?php

namespace App\Repositories\Geral;

use App\Repositories\Repository;
use App\Models\Geral\Anexo;

class AnexoRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new Anexo();
    }

    /**
     * Sincroniza os usuarios a um anexo
     *
     * @param $anexoId
     * @param array $usuarios
     * @return mixed
     */
    public function sincronizarUsuarios($anexoId, array $usuarios)
    {
        return $this->model()->find($anexoId)->usuariosanexo()->sync($usuarios);
    }
}
