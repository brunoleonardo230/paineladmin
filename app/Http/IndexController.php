<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Auth\Guard;
use DB;
use App\Models\Geral\Mensagem;
use Illuminate\Http\Request;

class IndexController extends Controller
{
    protected $auth;

    /**
     * Cria uma nova instancia do controller.
     */
    public function __construct(Guard $auth)
    {
        $this->auth = $auth;
        $this->middleware('auth');
    }

    /**
     * Exibe a tela de boas vindas para o usuario.
     *
     * @return Response
     */
    public function index()
    {

        if($this->auth->user()->bol_alterar_senha == true) {
            $user = $this->auth->user();
            $this->auth->logout();

            // $token = app('auth.password.tokens')->create($user);
            $token = 'sdf';
            return view('auth.reset')->with('token', $token);
        }

        $modulos = $this->getUserModulos();

        $reads = $this->getUserReadedsToUser($modulos);

        $mensagens = $this->getNotificationsToUserModules($modulos, true);

        $total = (\App\Models\Geral\Mensagem::count() - \Auth::user()->mensagens()->count());

        return view('home', compact('modulos', 'mensagens', 'reads'));
    }

    public function notification(Request $request)
    {
        $query = $request->query();
        $modulos = $this->getUserModulos();

        if(isset($query['view'])) {
            $notification = Mensagem::find($query['view']);
            return view('notification-single', compact('notification'));
        }


        $reads = $this->getUserReadedsToUser($modulos);

        $mensagens = $this->getNotificationsToUserModules($modulos);

        return view('notification', compact('modulos', 'mensagens', 'reads'));
    }

    private function getUserModulos()
    {
        $sql = 'SELECT int_modulo_id, m.str_nome, m.str_nome_fantasia, m.str_descricao, m.str_icone
                FROM geral.tb_modulo m
                INNER JOIN geral.tb_perfil p ON p.int_perfil_modulo_id = m.int_modulo_id
                INNER JOIN geral.tb_perfil_usuario pu ON pu.int_perfil_usuario_perfil_id = p.int_perfil_id
                WHERE m.bol_ativo = true AND pu.int_perfil_usuario_usuario_id = :loggeduserid';

        $params = [
            'loggeduserid' => $this->auth->user()->int_usuario_id,
        ];

        return DB::select(DB::raw($sql), $params);
    }

    private function getNotificationsToUserModules($modulos, $limit = null)
    {
        $userModules = [];

        foreach($modulos as $k => $mod) {
            $userModules[] = $mod->int_modulo_id;
        }

        $msg = Mensagem::whereIn('int_sistema_id', $userModules)
                        ->join('geral.tb_modulo', 'tb_modulo.int_modulo_id', '=', 'tb_mensagens.int_sistema_id')
;

        if(!is_null($limit)) {
            $msg->whereRaw('date(current_timestamp) BETWEEN date(dta_ini) AND date(dta_fim)');
        }

        return $msg
                ->orderBy('dta_ini', 'DESC')
                ->get();
    }

    private function getUserReadedsToUser()
    {
        $reads = $this->auth->user()->mensagens()->select('geral.tb_usuario_mensagem.int_mensagem_id')->get()->toArray();
        return array_column($reads, 'int_mensagem_id');
    }

}
