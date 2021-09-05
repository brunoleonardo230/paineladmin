<?php

namespace App\Traits;

use DB;

trait HasPerfilTrait
{
    /**
     * Verifica se o usuário tem o perfil de um determinado módulo.
     *
     * @param $modulo
     * @param $perfil
     *
     * @return bool
     */
    public function hasPerfil($modulo, $perfil)
    {
        $sql = 'SELECT true FROM geral.tb_perfil p
                INNER JOIN geral.tb_perfil_usuario pu ON (p.int_perfil_id = pu.int_perfil_usuario_perfil_id AND pu.int_perfil_usuario_usuario_id = :usuarioid)
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = p.int_perfil_modulo_id AND LOWER(m.str_nome) = LOWER(:modulo)
                WHERE LOWER(p.str_nome) = LOWER(:perfil)';
        $data = ['usuarioid' => $this->getAuthIdentifier(), 'modulo' => $modulo, 'perfil' => $perfil];

        $hasPerfil = current(DB::select($sql, $data));

        if (!empty($hasPerfil)) {
            return true;
        }

        return false;
    }

    /**
     * Verifica se o usuário tem varios perfis de um determinado módulo.
     *
     * @param $modulo
     * @param array $perfis
     *
     * @return bool
     */
    public function hasPerfis($modulo, array $perfis)
    {
        $str_perfis = "'".strtolower(implode("','",$perfis))."'";

        $sql = "SELECT true FROM geral.tb_perfil p
                INNER JOIN geral.tb_perfil_usuario pu ON (p.int_perfil_id = pu.int_perfil_usuario_perfil_id AND pu.int_perfil_usuario_usuario_id = :usuarioid)
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = p.int_perfil_modulo_id AND LOWER(m.str_nome) = LOWER(:modulo)
                WHERE LOWER(p.str_nome) in ({$str_perfis})";
        $data = ['usuarioid' => $this->getAuthIdentifier(), 'modulo' => $modulo];

        $hasPerfil = current(DB::select($sql, $data));

        if (!empty($hasPerfil)) {
            return true;
        }

        return false;
    }

    /**
     * Verifica se o usuário tem um determinado módulo.
     *
     * @param $modulo
     * @param array $perfis
     *
     * @return bool
     */
    public function hasModulo($modulo)
    {
        $sql = "SELECT true FROM geral.tb_perfil p
                INNER JOIN geral.tb_perfil_usuario pu ON (p.int_perfil_id = pu.int_perfil_usuario_perfil_id AND pu.int_perfil_usuario_usuario_id = :usuarioid)
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = p.int_perfil_modulo_id AND LOWER(m.str_nome) = LOWER(:modulo)";
        $data = ['usuarioid' => $this->getAuthIdentifier(), 'modulo' => $modulo];

        $hasModulo = current(DB::select($sql, $data));

        if (!empty($hasModulo)) {
            return true;
        }

        return false;
    }

    /**
     * Relação nxm com os perfis do usuário.
     *
     * @return mixed
     */
    public function perfis()
    {
        return $this->belongsToMany('App\Models\Geral\Perfil', 'geral.tb_perfil_usuario', 'int_perfil_usuario_usuario_id', 'int_perfil_usuario_perfil_id');
    }
}
