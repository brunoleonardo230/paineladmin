<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\StorePermissaoRequest;
use App\Repositories\Geral\RecursoRepository;
use App\Repositories\Geral\PermissaoRepository;
use App\Models\Geral\Permissao;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Flash;

class PermissoesController extends Controller
{
    protected $recursoRepository;
    protected $permissaoRepository;

    public function __construct(RecursoRepository $recursoRepository, PermissaoRepository $permissaoRepository)
    {
        $this->recursoRepository = $recursoRepository;
        $this->permissaoRepository = $permissaoRepository;
    }

    public function index()
    {
        $permissoes = $this->permissaoRepository->getAll();

        return view('admin.permissoes.index', compact('permissoes'));
    }

    public function getCreate()
    {
        // $recursos = $this->recursoRepository->lists('str_nome', 'int_recurso_id');
        // dd($recursos);
        $arrayRecursos = $this->recursoRepository->getAll();
        $recursos = [];
        foreach ($arrayRecursos as $key => $recurso) {
            $recursos [$recurso->int_recurso_id] = $recurso->modulo .' / '. $recurso->str_nome;
        }
        // // dd($recursos);
        return view('admin.permissoes.create', compact('recursos'));
    }

    public function postCreate(StorePermissaoRequest $request)
    {
        $permissoes = explode(';', $request->str_nome);
        $descricoes = explode(';', $request->str_descricao);
        $permissoesSalvas = null;
        
        if(count($permissoes)) {
            foreach ($permissoes as $key => $permissao) {
                $arrayPermissao = $request->all();
                $arrayPermissao['str_nome'] = $permissao;
                $arrayPermissao['str_descricao'] = $descricoes[$key];
                
                $permissoesSalvas = $this->permissaoRepository->create($arrayPermissao);  
            }
        } else {
            $permissoesSalvas = $this->permissaoRepository->create($request->all());
        }

        if (!$permissoesSalvas) {
            Flash::error('Erro ao tentar salvar.');

            return redirect()->back()->withInput($request->all());
        }

        Flash::success('Permissao criada com sucesso.');

        return redirect('admin/permissoes');
    }

    public function postDelete(Request $request)
    {
        $id = $request->input('int_permissao_id');

        if ($this->permissaoRepository->delete($id)) {
            Flash::success('Permissão excluída com sucesso.');
        } else {
            Flash::error('Erro ao tentar excluir a permissão');
        }

        return redirect()->back();
    }
}
