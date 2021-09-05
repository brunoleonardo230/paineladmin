<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Geral\Mensagem;
use App\Models\Geral\Modulo;
use Auth;
use Request;
use Validator;
use Flash;
use DB;
use \App\Core\Generator\Password;
use App\Log\CustomLog;
use Illuminate\Http\Request as Req;
use Illuminate\Contracts\Auth\Guard;
use App\Repositories\Geral\ModuloRepository;

/**
 * Class UserController.
 */
class NotificacoesController extends Controller
{
    /**
     * @var Guard
     */
    private $auth;

    /**
     * @var Mensagem
     */
    private $mensagem;

    /**
     * @var ModuloRepository
     */
    private $modulos;

    /**
     * @param Guard $auth
     */
    public function __construct(Guard $auth, ModuloRepository $modulos, Mensagem $mensagem)
    {
        $this->auth     = $auth;
        $this->modulos  = $modulos; 
        $this->mensagem = $mensagem;
    }

    public function index()
    {
        $notificacoes = $this->mensagem
                             ->join('geral.tb_modulo', 'tb_modulo.int_modulo_id', '=', 'tb_mensagens.int_sistema_id')
                             ->orderBy('int_mensagem_id', 'DESC')->get();

        return view('admin.notificacoes.index', compact('notificacoes'));
    }

    public function getView($id = null)
    {   
        if(is_null($id)) {
            Flash::warning('Id inválido');
            
            return request()->back();    
        }

        $id = (int) $id;

        $notificacao = $this->mensagem->find($id);
        
        return view('admin.notificacoes.view', compact('notificacao'));        
    }

    public function getCreate()
    {
        $modulos = $this->modulos->lists('str_descricao', 'int_modulo_id');
        return view('admin.notificacoes.create', compact('modulos'));
    }

    public function postCreate(Req $request)
    {
        $this->validate($request, $this->mensagem->rules);

        $data = $request->all();

        $data['dta_ini'] = \Datetime::createFromFormat('d/m/Y', $data['dta_ini']);
        $data['dta_ini'] = $data['dta_ini']->format('Y-m-d');
        
        $data['dta_fim'] = \Datetime::createFromFormat('d/m/Y', $data['dta_fim']);
        $data['dta_fim'] = $data['dta_fim']->format('Y-m-d');
        
        try {
            DB::beginTransaction();
            
            unset($data['_token']);

            $this->mensagem->str_titulo     = $data['str_titulo'];
            $this->mensagem->dta_ini        = $data['dta_ini'];
            $this->mensagem->dta_fim        = $data['dta_fim'];
            $this->mensagem->int_sistema_id = $data['int_sistema_id'];
            $this->mensagem->str_mensagem   = htmlentities($data['str_mensagem']);
            $this->mensagem->bol_ativo      = $data['bol_ativo'];
            $this->mensagem->ind_tipo       = $data['ind_tipo'];
            
            $this->mensagem->save();

            DB::commit();

            Flash::success("Mensagem adicionada com sucesso.");

            return redirect()->to('/admin/notificacoes/view/' . $this->mensagem->int_mensagem_id);

        } catch(Exception $e) {
            DB::rollback();
            
            Flash::error('Ocorreu um erro na inserção da mensagem. Tente novamente mais tarde ou contacte o administrador.');

            return redirect()->back();            
        }

    }

    public function getEdit($idNot)
    {   
        if(is_null($idNot)) {
            Flash::warning('Id inválido');
            
            return request()->back();    
        }

        $idNot = (int) $idNot;

        $notificacao = $this->mensagem->find($idNot);
        $modulos = $this->modulos->lists('str_descricao', 'int_modulo_id');
        
        $notificacao['dta_ini'] = \Datetime::createFromFormat('Y-m-d H:i:s', $notificacao['dta_ini']);
        $notificacao['dta_ini'] = $notificacao['dta_ini']->format('d/m/Y');

        $notificacao['dta_fim'] = \Datetime::createFromFormat('Y-m-d H:i:s', $notificacao['dta_fim']);
        $notificacao['dta_fim'] = $notificacao['dta_fim']->format('d/m/Y');

        return view('admin.notificacoes.edit', compact('modulos', 'notificacao'));
    }

    public function postEdit(Req $request)
    {
        $this->validate($request, $this->mensagem->rules);

        $data = $request->all();

        $data['dta_ini'] = \Datetime::createFromFormat('d/m/Y', $data['dta_ini']);
        $data['dta_ini'] = $data['dta_ini']->format('Y-m-d');
        
        $data['dta_fim'] = \Datetime::createFromFormat('d/m/Y', $data['dta_fim']);
        $data['dta_fim'] = $data['dta_fim']->format('Y-m-d');
        
        try {
            DB::beginTransaction();
            
            unset($data['_token']);

            $mensagem = $this->mensagem->find($data['int_mensagem_id']);

            $mensagem->str_titulo     = $data['str_titulo'];
            $mensagem->dta_ini        = $data['dta_ini'];
            $mensagem->dta_fim        = $data['dta_fim'];
            $mensagem->int_sistema_id = $data['int_sistema_id'];
            $mensagem->str_mensagem   = htmlentities($data['str_mensagem']);
            $mensagem->bol_ativo      = $data['bol_ativo'];
            $mensagem->ind_tipo       = $data['ind_tipo'];
            
            $mensagem->save();

            DB::commit();

            Flash::success("Mensagem editada com sucesso.");

            return redirect()->to('/admin/notificacoes/edit/' . $mensagem->int_mensagem_id);

        } catch(Exception $e) {
            DB::rollback();
            
            Flash::error('Ocorreu um erro na inserção da mensagem. Tente novamente mais tarde ou contacte o administrador.');

            return redirect()->back();            
        }
    }

    public function getDelete($idNot = null)
    {
        if(is_null($idNot)) {
            Flash::warning('Id inválido');
            
            return request()->back();    
        }
        
        $idNot = (int) $idNot;

        try {
            DB::beginTransaction();

            $mensagem = $this->mensagem->find($idNot);

            
            $mensagem->delete();

            DB::commit();

            Flash::success("Mensagem excluida com sucesso.");

            return redirect()->to('/admin/notificacoes/index');

        } catch(Exception $e) {
            DB::rollback();
            
            Flash::error('Ocorreu um erro na exclusão da mensagem. Tente novamente mais tarde ou contacte o administrador.');

            return redirect()->back();            
        }
    }   
}
