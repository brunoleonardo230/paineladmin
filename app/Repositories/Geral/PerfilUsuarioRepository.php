<?php

namespace App\Repositories\Geral;

use App\Models\Geral\PerfilUsuario;
use App\Repositories\Repository;
use DB;
use Carbon\Carbon;

class PerfilUsuarioRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new PerfilUsuario();
    }

    public function desvincularPerfil($usuarioId, $perfilId)
    {
        $sql = 'DELETE
                FROM geral.tb_perfil_usuario
                WHERE int_perfil_usuario_usuario_id = :usuarioid AND int_perfil_usuario_perfil_id = :perfilid';

        return DB::delete($sql, ['usuarioid' => $usuarioId, 'perfilid' => $perfilId]);
    }

    public function atribuirPerfil($usuarioId, $perfilId)
    {
        $sql = "INSERT INTO geral.tb_perfil_usuario (int_perfil_usuario_usuario_id, int_perfil_usuario_perfil_id, created_at, updated_at)
				VALUES (:usuarioid, :perfilid, '".Carbon::now()."', '".Carbon::now()."')";

        return DB::insert($sql, ['usuarioid' => $usuarioId, 'perfilid' => $perfilId]);
    }
}
