<?php

namespace App\Http\Controllers\Admin;

use App\Repositories\Geral\PerfilRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Flash;

class PerfisPermissoesController extends Controller
{
    protected $perfilRepository;

    public function __construct(PerfilRepository $perfilRepository)
    {
        $this->perfilRepository = $perfilRepository;
    }

    public function index()
    {
        $perfis = $this->perfilRepository->getAllPerfisWithModulos();

        return view('admin.perfispermissoes.index', compact('perfis'));
    }

    public function getAtribuirpermissoes($perfilId)
    {
        $perfil = $this->perfilRepository->getPerfilWithModulo($perfilId);

        $permissoes = $this->perfilRepository->getTreeOfPermissoesByPefilAndModulo($perfil->int_perfil_id, $perfil->int_perfil_modulo_id);

        return view('admin.perfispermissoes.atribuirpermissoes', compact('perfil', 'permissoes'));
    }

    public function postAtribuirpermissoes(Request $request)
    {
        $perfilId = $request->int_perfil_id;

        if ($request->input('permissoes') == '') {
            Flash::error('Não existem permissões cadastradas para o módulo no qual esse perfil faz parte.');

            return redirect('admin/perfispermissoes/atribuirpermissoes/'.$perfilId);
        }

        $permissoes = explode(',', $request->input('permissoes'));

        $this->perfilRepository->sincronizarPermissoes($perfilId, $permissoes);

        Flash::success('Permissões atribuidas com sucesso.');

        return redirect('admin/perfispermissoes/atribuirpermissoes/'.$perfilId);
    }
}
