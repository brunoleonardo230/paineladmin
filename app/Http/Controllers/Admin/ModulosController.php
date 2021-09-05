<?php

namespace App\Http\Controllers\Admin;

use Flash;
use App\Models\Geral\Modulo;
use App\Models\Geral\Perfil;
use Illuminate\Http\Request;
//use Request;
use App\Models\Geral\Recurso;
use App\Models\Geral\PerfilUsuario;
use App\Http\Controllers\Controller;
use App\Repositories\Geral\ModuloRepository;
use App\Http\Requests\Admin\StoreModuloRequest;

class ModulosController extends Controller
{
    protected $moduloRepository;

    public function __construct(ModuloRepository $modulo)
    {
        $this->moduloRepository = $modulo;
    }

    public function index()
    {
        $modulos = $this->moduloRepository->all();

        return view('admin.modulos.index', compact('modulos'));
    }

    public function getCreate()
    {
        return view('admin.modulos.create');
    }

    public function postCreate(StoreModuloRequest $request)
    {
        $modulo = $this->moduloRepository->create($request->all());

        if (!$modulo) {
            Flash::error('Erro ao tentar salvar.');

            return redirect()->back()->withInput($request->all());
        }

        Flash::success('Módulo criado com sucesso.');

        return redirect('admin/modulos');
    }

    public function postDelete(Request $request)
    {
        $id = $request->input('int_modulo_id');

        if ($this->moduloRepository->delete($id)) {
            Flash::success('Módulo excluído com sucesso.');
        } else {
            Flash::error('Erro ao tentar excluir o módulo.');
        }

        return redirect()->back();
    }

    public function postDeleteCascade($moduloId)
    {
        try {

            $perfis = Perfil::where('int_perfil_modulo_id', $moduloId)->get();
            
            if($perfis){
                foreach($perfis as $perfil){
                    $perfil->permissoes()->detach();
                    
                    PerfilUsuario::where('int_perfil_usuario_perfil_id', $perfil->int_perfil_id)->delete();
                    
                    $perfil->delete();
                }
            }

            $recursos = Recurso::where('int_modulo_id', $moduloId)->get();

            if($recursos){
                foreach($recursos as $recurso) {
                    $recurso->permissoes()->delete();
                    $recurso->delete();
                }
            }

            Modulo::where('int_modulo_id', $moduloId)->delete();

            Flash::success('Módulo excluído com sucesso.');
        } catch (\Exception $th) {
            Flash::error('Erro ao tentar excluir o módulo.');
        }

        return redirect()->back();
    }
}
