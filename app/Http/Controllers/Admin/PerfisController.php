<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\StorePerfilRequest;
use App\Repositories\Geral\PerfilRepository;
use App\Repositories\Geral\PermissaoRepository;
use App\Repositories\Geral\ModuloRepository;
use App\Models\Geral\Perfil;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Flash;

class PerfisController extends Controller
{
    protected $perfilRepository;
    protected $permissaoRepository;
    protected $moduloRepository;

    public function __construct(PerfilRepository $perfilRepository, PermissaoRepository $permissaoRepository, ModuloRepository $moduloRepository)
    {
        $this->perfilRepository = $perfilRepository;
        $this->permissaoRepository = $permissaoRepository;
        $this->moduloRepository = $moduloRepository;
    }

    public function index()
    {
        $perfis = (object)$this->perfilRepository->getAllPerfisWithModulos();

        return view('admin.perfis.index', compact('perfis'));
    }

    public function getCreate()
    {
        $modulos = $this->moduloRepository->lists('str_nome', 'int_modulo_id');

        return view('admin.perfis.create', compact('modulos'));
    }

    public function postCreate(StorePerfilRequest $request)
    {
        $perfil = $this->perfilRepository->create($request->all());

        if (!$perfil) {
            Flash::error('Erro ao tentar salvar.');

            return redirect()->back()->withInput($request->all());
        }

        Flash::success('Perfil criado com sucesso.');

        return redirect('admin/perfis');
    }

    public function postDelete(Request $request)
    {
        $id = $request->input('int_perfil_id');

        if ($this->perfilRepository->delete($id)) {
            Flash::success('Perfil excluído com sucesso.');
        } else {
            Flash::error('Erro ao tentar excluir a perfil');
        }

        return redirect()->back();
    }
}
