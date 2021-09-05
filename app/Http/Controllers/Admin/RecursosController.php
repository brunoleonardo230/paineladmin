<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\StoreRecursoRequest;
use App\Repositories\Geral\CategoriaRecursoRepository;
use App\Repositories\Geral\ModuloRepository;
use App\Repositories\Geral\RecursoRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Flash;

class RecursosController extends Controller
{
    protected $recursoRepository;
    protected $moduloRepository;
    protected $categoriaRecursoRepository;

    public function __construct(RecursoRepository $recursoRepository, ModuloRepository $moduloRepository, CategoriaRecursoRepository $categoriaRecursoRepository)
    {
        $this->recursoRepository = $recursoRepository;
        $this->moduloRepository = $moduloRepository;
        $this->categoriaRecursoRepository = $categoriaRecursoRepository;
    }

    public function index()
    {
        $recursos = $this->recursoRepository->getAll();

        return view('admin.recursos.index', compact('recursos'));
    }

    public function getCreate()
    {
        $modulos = $this->moduloRepository->lists('str_nome', 'int_modulo_id');
        $categorias = $this->categoriaRecursoRepository->lists('str_nome', 'int_categoria_recurso_id');

        return view('admin.recursos.create', compact('modulos', 'categorias'));
    }

    public function postCreate(StoreRecursoRequest $request)
    {
        $recurso = $this->recursoRepository->create($request->all());

        if (!$recurso) {
            Flash::error('Erro ao tentar salvar.');

            return redirect()->back()->withInput($request->all());
        }

        Flash::success('Recurso criado com sucesso.');

        return redirect('admin/recursos');
    }

    public function postDelete(Request $request)
    {
        $id = $request->input('int_recurso_id');

        if ($this->recursoRepository->delete($id)) {
            Flash::success('Recurso excluída com sucesso.');
        } else {
            Flash::error('Erro ao tentar excluir o recurso');
        }

        return redirect()->back();
    }
}
