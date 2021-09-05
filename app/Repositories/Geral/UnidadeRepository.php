<?php

namespace App\Repositories\Geral;

use Illuminate\Database\Eloquent\Collection;
use App\Repositories\Repository;
use App\Models\Geral\Unidade;
use DB;

class UnidadeRepository extends Repository
{
    /**
     * Specify Model class name.
     *
     * @return string
     */
    public function model()
    {
        return new Unidade();
    }

    /**
     * Pega todos os usuarios do sistema e adiciona o campo vinculado àqueles que estao vinculados a unidade informada
     *
     * @param $unidadeId
     * @return mixed
     */
    public function getAllUsuariosWithRelation($unidadeId)
    {
        $sql = 'SELECT
                  int_usuario_id, str_nome, str_email, (CASE WHEN bol=1 THEN 1 ELSE 0 END) AS vinculado
                FROM (
                    SELECT int_usuario_id, str_nome, str_email FROM geral.tb_usuario
                ) AS todos
                LEFT JOIN (
                    SELECT u.int_usuario_id as temp, 1 as bol FROM geral.tb_usuario u
                    LEFT JOIN geral.tb_usuario_unidade uni ON uni.int_usuario_id = u.int_usuario_id
                    WHERE uni.int_unidade_id = :unidadeid
                ) as menos ON todos.int_usuario_id = menos.temp';

        return DB::select($sql, ['unidadeid' => $unidadeId]);
    }

    /**
     * Sincroniza os usuarios a uma unidade
     *
     * @param $unidadeId
     * @param array $usuarios
     * @return mixed
     */
    public function sincronizarUsuarios($unidadeId, array $usuarios)
    {
        return $this->model()->find($unidadeId)->usuariosunidade()->sync($usuarios);
    }

    /**
     * Retorna todas as unidades as quais o usuario esta vinculado. Exemplos de unidades: SEC. DE ESTADO DA TRANSPARENCIA E CONTROLE, ASSEMBLEIA LEGISLATIVA...
     *
     * @param $usuarioId
     * @return array
     */
    public function getAllUnidadesVinculadasWithUsuario($usuarioId)
    {
        $sql = "SELECT
                    u.int_unidade_id, u.str_unidade
                FROM geral.tb_unidade u
                WHERE u.int_unidade_id IN (SELECT int_unidade_id FROM geral.tb_usuario_unidade WHERE int_usuario_id = :usuarioid)
                ORDER BY u.str_unidade";

        $unidades = DB::select($sql, ['usuarioid' => $usuarioId]);

        $unidadesRetorno = [];

        foreach ($unidades as $unidade) {
            $unidadesRetorno[$unidade->int_unidade_id] = $unidade->str_unidade;
        }

        return $unidadesRetorno;
    }

    /**
     * Retorna um array com o código de todas as unidades as quais os usuario esta vinculado.
     *
     * @param $usuarioId
     *
     * @return array|bool
     */
    public function getUnidadesByUsuario($usuarioId)
    {
        $unidades = $this->getAllUnidadesVinculadasWithUsuario($usuarioId);

        if (!count($unidades)) {
            return false;
        }

        //captura o código das unidades.
        foreach ($unidades as $key => $unidade) {
            $returnData[] = $key;
        }

        return $returnData;
    }

    public function getAcronymOfUnits($unidadesId){
        $mUnidade = $this->model();

        $unidades = $mUnidade->select('int_unidade_id','str_unidade')->whereIn('int_unidade_id',$unidadesId)->distinct()->get();

        return $unidades;
    }

    /**
     * Verifica se o usuario tem vinculo com a unidade
     *
     * @param $usuarioId
     * @param $unidadeId
     * @return bool
     */
    public function usuarioHasVinculoUnidade($usuarioId, $unidadeId)
    {
        $sql = "SELECT
                  true
                FROM geral.tb_usuario_unidade
                WHERE int_usuario_id = :usuarioid AND int_unidade_id = :unidadeid";

        $result = DB::select($sql, ['usuarioid' => $usuarioId, 'unidadeid' => $unidadeId]);

        if($result) {
            return true;
        }

        return false;
    }

    /**
     * Retorna todas as unidades administrativas nas quais o usuario faz parte
     * Caso alguma das unidades que o usuario faz parte seja uma unidade administradora (ex. COGE), entao retorna todas as demais unidades.
     *
     * @param $unidadesId
     *
     * @return array
     */
    public function getAllByUnidadeUsuario($unidadesId)
    {
        if (empty($unidadesId)) {
            return [];
        }

        if ($this->hasUnidadeAdministradora($unidadesId)) {
            return $this->listsUnidade($this->all());
        }

        $unidades = DB::table('geral.tb_unidade')->whereIn('int_unidade_id', $unidadesId)->get();

        return $this->listsUnidade($unidades);
    }

    /**
     * Cria um array listando as unidades para popular os selects da aplicacao.
     *
     * @param $unidades
     *
     * @return array
     */
    private function listsUnidade($unidades)
    {
        $returnData = [];

        foreach ($unidades as $unidade) {
            $returnData[$unidade->int_unidade_id] = $unidade->str_sigla.' - '.$unidade->str_unidade;
        }

        return $returnData;
    }

    /**
     * Verifica se alguma das unidades das quais o usuario faz parte eh uma unidade administradora.
     *
     * @param $unidadesId
     *
     * @return bool
     */
    public function hasUnidadeAdministradora(array $unidadesId)
    {
        if (empty($unidadesId)) {
            return false;
        }

        //110120 = CORREGEDORIA GERAL DO ESTADO || 222222 = "MINISTÉRIO PÚBLICO DO MARNHÃO"
        foreach ($unidadesId as $id) {
            if ($id == '110120' || $id == '222222') {        
                return true;
            }
        }

        return false;
    }

    /**
     * Retorna todos os items de acordo com os parametros de filtros e order para usar no pagination
     *
     * @param int $offset
     * @param int $limit
     * @param array $where
     * @param array $orderBy
     *
     * @return Collection
     */
    public function getAllForPagination($offset = 1, $limit = 20, $where = [], $orderBy = [])
    {
        $offset = ($offset - 1) * $limit;

        $queryBuilder = $this->makeQueryBuilderForPagination($where, $orderBy);

        $queryBuilder->skip($offset)->take($limit);

        $returnObject = new Collection();

        foreach ($queryBuilder->get() as $unidade) {
            $returnObject->add(with($this->model())->newInstance($unidade));
        }

        return $returnObject;
    }

    /**
     * Retorna a quantidade de unidades cadastradas
     *
     * @return mixed
     */
    public function getTotalCount($where = [])
    {
        $queryBuilder = $this->makeQueryBuilderForPagination($where);

        $count = $queryBuilder->count();

        return $count;
    }

    /**
     * Gera o query builder basico que eh usado na paginacao na funcao que retorna os items e na funcao que retorna o quantitativo de items da query
     *
     * @param array $where
     * @param array $orderBy
     *
     * @return mixed
     */
    private function makeQueryBuilderForPagination($where = [], $orderBy = [])
    {
        $queryBuilder = DB::table('geral.tb_unidade');

        foreach($where as $filter => $value)
        {
            if ($filter == 'int_unidade_id') {
                $queryBuilder->orWhere($filter, $value);
            } else {
                $queryBuilder->orWhere($filter, "ILIKE", "%{$value}%");
            }
        }

        if (!empty($orderBy)) {
            switch ($orderBy['field']) {
                case 'codigo':
                    $queryBuilder->orderBy('int_unidade_id', $orderBy['order']);
                    break;
                case 'sigla':
                    $queryBuilder->orderBy('str_sigla', $orderBy['order']);
                    break;
                case 'unidade':
                    $queryBuilder->orderBy('str_unidade', $orderBy['order']);
                    break;
                case 'representante':
                    $queryBuilder->orderBy('str_nome_representante', $orderBy['order']);
                    break;
                default:
                    $queryBuilder->orderBy('int_unidade_id', 'desc');
            }
        }

        return $queryBuilder;
    }

    /**
     * Retorna as regras de criacao de uma nova unidade
     *
     * @return mixed
     */
    public function createRules()
    {
        return $this->model()->createRules;
    }

    public function getUnidadeByUsuario($unidadeId)
    {
        if (empty($unidadeId)) {
            return [];
        }

        if ($this->hasUnidadeAdministradora($unidadeId)) {
            $unidades = DB::table('geral.tb_unidade')->get();
            return $unidades;
        }

        $unidades = DB::table('geral.tb_unidade')->whereIn('int_unidade_id', $unidadeId)->get();

        return $unidades;
    }

    public function getUnidadeIDByUsuario($usuarioId)
    {
        $sql = "SELECT
                    u.int_unidade_id, u.str_unidade
                FROM geral.tb_unidade u
                WHERE u.int_unidade_id IN (SELECT int_unidade_id FROM geral.tb_usuario_unidade WHERE int_usuario_id = :usuarioid)
                ORDER BY u.str_unidade";

        $unidades = current(DB::select($sql, ['usuarioid' => $usuarioId]));

        if (!count($unidades)) {
            return false;
        }

        return $unidades;
    }
}
