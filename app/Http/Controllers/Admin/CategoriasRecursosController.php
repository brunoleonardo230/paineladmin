<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\StoreCategoriaRecursoRequest;
use App\Repositories\Geral\CategoriaRecursoRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Flash;

class CategoriasRecursosController extends Controller
{
    protected $categoriaRecursoRepository;

    public function __construct(CategoriaRecursoRepository $categoriaRecursoRepository)
    {
        $this->categoriaRecursoRepository = $categoriaRecursoRepository;
    }

    public function index()
    {
        $categoriasrecursos = $this->categoriaRecursoRepository->all();

        return view('admin.categoriasrecursos.index', compact('categoriasrecursos'));
    }

    public function getCreate()
    {
        return view('admin.categoriasrecursos.create');
    }

    public function postCreate(StoreCategoriaRecursoRequest $request)
    {
        $categoria = $this->categoriaRecursoRepository->create($request->all());

        if (!$categoria) {
            Flash::error('Erro ao tentar salvar.');

            return redirect()->back()->withInput($request->all());
        }

        Flash::success('Categoria criada com sucesso.');

        return redirect('admin/categoriasrecursos');
    }

    public function postDelete(Request $request)
    {
        $id = $request->input('int_categoria_recurso_id');

        if ($this->categoriaRecursoRepository->delete($id)) {
            Flash::success('Categoria excluída com sucesso.');
        } else {
            Flash::error('Erro ao tentar excluir a categoria');
        }

        return redirect()->back();
    }
}
