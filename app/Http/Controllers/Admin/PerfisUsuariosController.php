<?php

namespace App\Http\Controllers\Admin;

use App\Repositories\Geral\PerfilUsuarioRepository;
use App\Repositories\Geral\ModuloRepository;
use App\Repositories\Geral\UsuarioRepository;
use App\Repositories\Geral\PerfilRepository;
use App\Models\Geral\Usuario;
use App\Http\Controllers\Controller;
use Flash;
use Request;

class PerfisUsuariosController extends Controller
{
    protected $perfilUsuarioRepository;
    protected $usuarioRepository;
    protected $perfilRepository;
    protected $moduloRepository;

    public function __construct(PerfilUsuarioRepository $perfilUsuarioRepository, UsuarioRepository $usuarioRepository, PerfilRepository $perfilRepository, ModuloRepository $moduloRepository)
    {
        $this->perfilUsuarioRepository = $perfilUsuarioRepository;
        $this->usuarioRepository = $usuarioRepository;
        $this->perfilRepository = $perfilRepository;
        $this->moduloRepository = $moduloRepository;
    }

    public function index()
    {
        $usuarios = Usuario::all();

        return view('admin.perfisusuarios.index', compact('usuarios'));
    }

    public function getAtribuirperfis($usuarioId)
    {
        $usuario = Usuario::find($usuarioId);

        $perfis = $this->perfilRepository->getPerfilWithModuloByUsuarioId($usuarioId);

        $modulosVinculados = $this->perfilRepository->getModulosByUsuarioId($usuarioId);

        $params = array();
        $i = 0;

        foreach ($modulosVinculados as $modulo) {
            $params[$i] = $modulo->int_perfil_modulo_id;
            ++$i;
        }

        $resultado = $this->moduloRepository->getModulosNaoVinculados($params);

        $modulosNaoVinculados = array();
        $modulosNaoVinculados[0] = '';

        foreach ($resultado as $modulo) {
            $modulosNaoVinculados[$modulo->int_modulo_id] = $modulo->str_nome;
        }

        return view('admin.perfisusuarios.atribuirperfis', compact('usuario', 'perfis', 'modulosNaoVinculados'));
    }

    public function getPerfis()
    {
        $requestData = Request::all();

        $perfisNaoAtribuidos = $this->perfilRepository->getPerfisNaoAtribuidos($requestData['id']);

        $perfis = array();

        foreach ($perfisNaoAtribuidos as $perfil) {
            $perfis[$perfil->int_perfil_id] = $perfil->str_nome;
        }

        $json = json_encode($perfis);

        return $json;
    }

    public function postDesvincularperfil($usuarioId = null, $perfilId = null, $redirect_url = '/admin/perfisusuarios/atribuirperfis/')
    {
        $usuarioId = (int) !is_null($usuarioId) ? $usuarioId : Request::input('int_usuario_id');
        $perfilId = (int) !is_null($perfilId) ? $perfilId : Request::input('int_perfil_id');

        $resultado = $this->perfilUsuarioRepository->desvincularPerfil($usuarioId, $perfilId);

        if ($resultado) {
            Flash::success('Perfil desvinculado com sucesso.');

            return redirect($redirect_url.$usuarioId);
        } else {
            Flash::success('Algo deu errado, tente novamente.');

            return redirect($redirect_url.$usuarioId);
        }
    }

    public function postAtribuir($usuarioId = null, $perfilId = null, $redirect_url = '/admin/perfisusuarios/atribuirperfis/')
    {
        $usuarioId = (int) !is_null($usuarioId) ? $usuarioId : Request::input('int_usuario_id');
        $perfilId = (int) !is_null($perfilId) ? $perfilId : Request::input('int_perfil_id');

        $resultado = $this->perfilUsuarioRepository->atribuirPerfil($usuarioId, $perfilId);
        //dd($resultado);
        if ($resultado) {
            Flash::success('Perfil atribuído com sucesso.');

            return redirect($redirect_url.$usuarioId);
        } else {
            Flash::success('Algo deu errado, tente novamente.');

            return redirect($redirect_url.$usuarioId);
        }
    }
}
