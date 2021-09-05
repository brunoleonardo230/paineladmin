<?php

namespace App\Repositories\Geral;

use App\Repositories\Repository;
use App\Models\Geral\Perfil;
use DB;

class PerfilRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new Perfil();
    }

    public function getAllPerfisWithModulos()
    {
        $sql = 'SELECT
                    p.int_perfil_id,
                    p.str_nome,
                    p.str_descricao,
                    m.str_nome as mod_nome
                FROM geral.tb_perfil p
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = p.int_perfil_modulo_id
                ORDER BY m.int_modulo_id, m.str_nome';

        return DB::select($sql);
    }

    public function getPerfilWithModulo($perfilId)
    {
        $sql = 'SELECT
                    p.int_perfil_id,
                    p.str_nome,
                    p.str_descricao,
                    p.int_perfil_modulo_id,
                    m.str_nome as mod_nome
                FROM geral.tb_perfil p
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = p.int_perfil_modulo_id
                WHERE p.int_perfil_id = :perfilid';

        return DB::selectOne($sql, ['perfilid' => $perfilId]);
    }

    public function getTreeOfPermissoesByPefilAndModulo($perfilId, $moduloId)
    {
        $sql = 'SELECT
                  int_recurso_id, str_nome, int_permissao_id, prm_nome, (CASE WHEN bol=1 THEN 1 ELSE 0 END) AS habilitado
                FROM (
                    SELECT r.int_recurso_id, r.str_nome, p.int_permissao_id, p.str_nome as prm_nome FROM geral.tb_permissao p
                    LEFT JOIN geral.tb_recurso r ON r.int_recurso_id = p.int_permissao_recurso_id
                    WHERE r.int_modulo_id = :moduloid
                ) AS todas
                LEFT JOIN (
                    SELECT p.int_permissao_id as temp, 1 as bol FROM geral.tb_permissao p
                    LEFT JOIN geral.tb_recurso r ON r.int_recurso_id = p.int_permissao_recurso_id
                    LEFT JOIN geral.tb_perfil_permissao pp ON pp.int_perfil_permissao_permissao_id = p.int_permissao_id
                    WHERE pp.int_perfil_permissao_perfil_id = :perfilid
                ) menos ON todas.int_permissao_id = menos.temp';

        $permissoes = DB::select($sql, ['moduloid' => $moduloId, 'perfilid' => $perfilId]);

        $retorno = [];
        if (count($permissoes)) {
            foreach ($permissoes as $key => $perm) {
                if (isset($retorno[$perm->int_recurso_id])) {
                    $retorno[$perm->int_recurso_id]['permissoes'][$perm->int_permissao_id] = array('int_permissao_id' => $perm->int_permissao_id, 'prm_nome' => $perm->prm_nome, 'habilitado' => $perm->habilitado);
                } else {
                    $retorno[$perm->int_recurso_id]['int_recurso_id'] = $perm->int_recurso_id;
                    $retorno[$perm->int_recurso_id]['str_nome'] = $perm->str_nome;
                    $retorno[$perm->int_recurso_id]['permissoes'][$perm->int_permissao_id] = array('int_permissao_id' => $perm->int_permissao_id, 'prm_nome' => $perm->prm_nome, 'habilitado' => $perm->habilitado);
                }
            }
        }

        return $retorno;
    }

    public function getPerfilWithModuloByUsuarioId($usuarioId)
    {
        $result = DB::select('SELECT
                    p.int_perfil_id,
                    p.str_nome,
                    p.str_descricao,
                    p.int_perfil_modulo_id,
                    m.str_nome as mod_nome
                FROM geral.tb_perfil p
                INNER JOIN geral.tb_perfil_usuario pu ON p.int_perfil_id = pu.int_perfil_usuario_perfil_id
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = p.int_perfil_modulo_id
                WHERE pu.int_perfil_usuario_usuario_id = :usuarioid', ['usuarioid' => $usuarioId]);

        return $result;
    }

    /**
     * Sincroniza as permissões do perfil na base.
     *
     * @param $perfilId
     * @param array $permissoes
     */
    public function sincronizarPermissoes($perfilId, array $permissoes)
    {
        return $this->model()->find($perfilId)->permissoes()->sync($permissoes);
    }

    public function getModulosByUsuarioId($usuarioId)
    {
        $result = DB::select('SELECT
                    p.int_perfil_modulo_id
                FROM geral.tb_perfil p
                INNER JOIN geral.tb_perfil_usuario pu ON p.int_perfil_id = pu.int_perfil_usuario_perfil_id
                WHERE pu.int_perfil_usuario_usuario_id = :usuarioid', ['usuarioid' => $usuarioId]);

        return $result;
    }

    public function getPerfis($moduloId)
    {
        $modulosNaoVinculados = DB::table('geral.tb_perfil')->select('int_perfil_id', 'str_nome')
                    ->where('int_perfil_modulo_id', $moduloId)->get();

        return $modulosNaoVinculados;
    }

    public function getPerfisNaoAtribuidos($moduloId)
    {
        $perfisNaoAtribuidos = DB::table('geral.tb_perfil')->select('int_perfil_id', 'str_nome')
                    ->where('int_perfil_modulo_id', $moduloId)->get();

        return $perfisNaoAtribuidos;
    }

    public function delete($perfilId)
    {
        try {
            $perfil = Perfil::find($perfilId);

            $perfil->permissoes()->detach();
            $perfil->usuarios()->detach();
            $perfil->delete();
            
            return true;
        } catch (\Exception $th) {
            dd($th->getMessage());
            return false;
        }
    }
}
