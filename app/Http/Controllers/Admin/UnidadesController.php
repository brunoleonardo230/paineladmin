<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Contracts\Auth\Guard;
use App\Http\Controllers\Controller;
use App\Repositories\Geral\UnidadeRepository;
use DB;
use Flash;
use Illuminate\Pagination\LengthAwarePaginator as Paginator;

/**
 * Class UnidadesController.
 */
class UnidadesController extends Controller
{
    protected $auth;
    protected $unidadeRepository;

    /**
     * Construtor da classe
     *
     * @param Guard $auth
     */
    public function __construct(
        Guard $auth,
        UnidadeRepository $unidadeRepository
    )
    {
        $this->auth = $auth;
        $this->unidadeRepository = $unidadeRepository;
    }

    /**
     * Acao que exibe a view index
     *
     * @return \Illuminate\View\View
     */
    public function index(Request $request)
    {
        $currentPage = (int)$request->input('page') ?: 1;
        $itemsPerPage = 20;

        $where = [];
        if($request->has('int_unidade_id')) {
            $where['int_unidade_id'] = $request->input('int_unidade_id');
        }
        if ($request->has('str_unidade')) {
            $where['str_unidade'] = $request->input('str_unidade');
        }
        if ($request->has('str_nome_representante')) {
            $where['str_nome_representante'] = $request->input('str_nome_representante');
        }

        if ($request->input('asort')) {
            $orderBy = [
                'field' => $request->input('asort'),
                'order' => 'asc',
                'sort' => 'asort',
                'nextSort' => 'dsort'
            ];
        } else if ($request->input('dsort')) {
            $orderBy = [
                'field' => $request->input('dsort'),
                'order' => 'desc',
                'sort' => 'dsort',
                'nextSort' => 'asort'
            ];
        } else {
            $orderBy = [
                'field' => 'int_contrato_id',
                'order' => 'desc',
                'sort' => 'dsort',
                'nextSort' => 'asort'
            ];
        }

        $items = $this->unidadeRepository->getAllForPagination($currentPage, $itemsPerPage, $where, $orderBy);
        $totalItems = $this->unidadeRepository->getTotalCount($where);

        $unidades = new Paginator($items, $totalItems, $itemsPerPage, $currentPage, ['path' => $request->url()]);

        if (!empty($orderBy)) {
            $unidades->appends([$orderBy['sort'] => $orderBy['field']]);
        }

        if (!empty($where)) {
            foreach($where as $field => $value) {
                $unidades->appends([$field => $value]);
            }
        }

        $baseUrl = $request->url();
        if (empty($where)) {
            $baseUrl .= '?' . $orderBy['nextSort'] . '=';
        } else {
            $i = 0;
            foreach($where as $field => $value) {
                if ($i == 0) {
                    $baseUrl .= '?' . $field . '=' . $value;
                } else {
                    $baseUrl .= '&' . $field . '=' . $value;
                }
                $i++;
            }
            $baseUrl .= '&' . $orderBy['nextSort'] . '=';
        }

        return view('admin.unidades.index', compact('unidades', 'orderBy', 'baseUrl', 'totalItems'));
    }

    /**
     * Acao que exibe o formulario para alterar uma unidade
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\View\View
     */
    public function getEdit($id)
    {
        $unidadeId = (int) $id;

        $unidade = $this->unidadeRepository->find($unidadeId);

        if (!$unidade) {
            Flash::error('Esta unidade não existe');

            return redirect()->back();
        }

        return view('admin.unidades.edit', compact('unidade'));
    }

    /**
     * Acao que atualiza as informacoes de uma unidade
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Exception
     */
    public function postEdit(Request $request)
    {
        $this->validate($request, $this->unidadeRepository->createRules());
        $request['str_cpf_representante'] = preg_replace("/[^0-9]/","", $request['str_cpf_representante']);
        $request['str_cnpj_unidade'] = preg_replace("/[^0-9]/","", $request['str_cnpj_unidade']);

        try {
            $unidade = $this->unidadeRepository->find($request->input('int_unidade_id'));

            if (!$unidade) {
                Flash::error('Esta unidade não existe');

                return redirect()->back();
            }

            DB::beginTransaction();

            $unidade->update($request->all());

            DB::commit();

            Flash::success('Unidade alterada com sucesso');

            return redirect()->to('/admin/unidades/index');
        } catch (\Exception $e) {
            DB::rollback();

            if(!config('app.debug')) {
                Flash::error($e->getMessage());

                return redirect()->back();
            } else {
                throw $e;
            }
        }
    }

    /**
     * Acao que exibe a view para vincular usuarios à unidade
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\View\View
     */
    public function getAtribuirusuarios($id)
    {
        $unidadeId = (int) $id;

        $unidade = $this->unidadeRepository->find($unidadeId);

        if (!$unidade) {
            Flash::error('Esta unidade não existe');

            return redirect()->back();
        }

        $usuarios = $this->unidadeRepository->getAllUsuariosWithRelation($unidadeId);

        return view('admin.unidades.atribuirusuarios', compact('unidade', 'usuarios'));
    }

    /**
     * Acao que atribui os usuários à unidade
     *
     * @param Request $request
     * @return $this|\Illuminate\Http\RedirectResponse
     * @throws \Exception
     */
    public function postAtribuirusuarios(Request $request)
    {
        $unidadeId = (int) $request->input('int_unidade_id');

        $unidade = $this->unidadeRepository->find($unidadeId);

        if (!$unidade) {
            Flash::error('Esta unidade não existe');

            return redirect()->back();
        }

        try {
            DB::beginTransaction();

            $usuarios = count($request->input('usuarios')) ? $request->input('usuarios') : [];

            $this->unidadeRepository->sincronizarUsuarios($unidadeId, $usuarios);

            DB::commit();

            Flash::success('Usuários vinculados com sucesso');

            return redirect()->to('/admin/unidades/index');
        } catch (\Exception $e) {
            DB::rollback();

            if(!config('app.debug')) {
                Flash::error($e->getMessage());

                return redirect()->back()->withInput($request->all());
            } else {
                throw $e;
            }
        }
    }
}
