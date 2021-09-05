<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Geral\Anexo;
use App\Models\Geral\Unidade;
use App\Models\Geral\Usuario;
use App\Repositories\Geral\AnexoRepository;
use App\Repositories\Geral\ModuloRepository;
use App\Repositories\Geral\PerfilRepository;
use App\Repositories\Geral\PerfilUsuarioRepository;
use App\Repositories\Geral\UsuarioRepository;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request as Req;
use Illuminate\Contracts\Auth\Guard;
use App\Models\Geral\UsuarioMensagem;
use App\Services\Password;
use App\Log\CustomLog;
use App\Models\Geral\Cliente;
use Auth;
use Request;
use Validator;
use Flash;

/**
 * Class UserController.
 */
class UsuariosController extends Controller
{
    /**
     * @var Guard
     */
    private $auth;

    /**
     * @var PerfisUsuariosController
     */
    private $perfisUsuarioController;
    /**
     * @var AnexoRepository
     */
    private $anexoRepository;

    /**
     * @param Guard $auth
     */
    public function __construct(Guard $auth, AnexoRepository $anexoRepository)
    {
        $this->auth = $auth;
        $this->perfisUsuarioController = new PerfisUsuariosController(
                                            new PerfilUsuarioRepository(app(),collect()),
                                            new UsuarioRepository(),
                                            new PerfilRepository(app(),collect()),
                                            new ModuloRepository(app(),collect())
                                        );

        $this->anexoRepository = $anexoRepository;
    }

    /**
     * @return \Illuminate\View\View
     */
    public function index()
    {
        $users = Usuario::all();

        CustomLog::log('Usuário ' . $this->auth->user()->int_usuario_id . ' acessou a listagem de usuários');

        return view('admin.usuarios.index', compact('users'));
    }

    /**
     * @return \Illuminate\View\View
     */
    public function getCreate()
    {
        $clientes = Cliente::getClientesAtivos();
        CustomLog::log('Usuário ' . $this->auth->user()->int_usuario_id . ' acessou a tela de cadastro de novo usuário.');

        return view('admin.usuarios.create', compact('clientes'));
    }

    /**
     * @return \Illuminate\View\View
     */
    public function postCreate()
    {
        $requestData = Request::all();
        $user = new Usuario();

        if(!empty($requestData['int_cpf'])) {
            $requestData['int_cpf'] = preg_replace("/[^0-9]/", "", $requestData['int_cpf']);
        }
        else {
            $requestData['int_cpf'] = null;
        }

        $validator = Validator::make($requestData, Usuario::$rules);

        if ($validator->fails()) {
            Flash::error('Preencha todos os campos adequadamente.');

            return redirect('/admin/usuarios/create')->withErrors($validator->errors()->all())->withInput();
        }
        
        $generate = new Password();
        $generate->setTamanho(6);
        $generate->comNumeros();
        $generate->comLMaiusculas();
        $generate->comCaractersEspeciais();

        $pass = $generate->generate();

        $requestData['str_senha'] = bcrypt($pass);

        $user->fill($requestData);
        $user->save();
        
        CustomLog::log('Usuário ' . $this->auth->user()->int_usuario_id . ' inseriu novo usuário.', $requestData);
        
        // \Mail::send('emails.password-temp-cad', ['password' => $pass, 'nome' => $user->str_nome, 'username' => $user->str_usuario], function($message) use ($user)
        // {
        //     $message->to($user->str_email, $user->str_nome)->subject('Senha temporária gerada no ato do seu cadastro.');
        // });

        Flash::success('Usuário adicionado com sucesso & senha gerada automaticamente foi enviada pro e-mail do mesmo.');

        return redirect('/admin/usuarios');
    }

    /**
     * @return \Illuminate\View\View
     */
    public function getEdit($id)
    {
        
        $usuario = Usuario::find($id);
        $clientes = Cliente::getClientesAtivos();

        CustomLog::log('Usuário ' . $this->auth->user()->int_usuario_id . ' acessou a tela de edição do usuário ID: ' . $id);

        return view('admin.usuarios.edit', compact('usuario','clientes'));
    }

    /**
     * @return \Illuminate\View\View
     */
    public function postEdit(Req $request, Anexo $anexo)
    {
        $requestData = Request::all();

        if(!empty($requestData['int_cpf'])) {
            $requestData['int_cpf'] = preg_replace("/[^0-9]/","", $requestData['int_cpf']);
        } else {
            $requestData['int_cpf'] = null;
        }

        $validator = Validator::make($requestData, Usuario::$rules);

        if ($validator->fails()) {
            return redirect('/admin/usuarios/edit/'.$requestData['int_usuario_id'])->withErrors($validator->errors()->all())->withInput();
        }

        $usuario = Usuario::find($requestData['int_usuario_id']);

        $usuario->fill($requestData);
        if (Auth::user()->perfil == 'admin') {
            $usuario->ativo = $requestData['ativo'];
        }

        if ($usuario->save()) {

            if($this->auth->user()->int_usuario_id == $usuario->int_usuario_id){
                $request->session()->put('cliente_logado', $usuario->cliente_id);
            }

            Flash::success('Usuário editado com sucesso.');
            
            CustomLog::log('Usuário ' . $this->auth->user()->int_usuario_id . ' editou usuário ID: ' . $usuario->int_usuario_id, $requestData);

            return redirect('/admin/usuarios/edit/' . $usuario->int_usuario_id);
        } else {
            Flash::error('Algo deu errado.');

           CustomLog::log('Usuário ' . $this->auth->user()->int_usuario_id . ' obteve erro na edição do usuário ID: ' . $usuario->int_usuario_id, $requestData);

            return view('admin.usuarios.edit', compact('usuario'));
        }
    }

    public function postGeneratenewpassword(Req $request)
    {
        $generate = new Password();
        $generate->setTamanho(6);
        $generate->comNumeros();
        $generate->comLMaiusculas();
        $generate->comCaractersEspeciais();

        $password = $generate->generate();

        $user = Usuario::find($request->input('usuario_id'));
        $user->str_senha = bcrypt($password);
        $user->bol_alterar_senha = true;

        if(!$user->save()){
           #colocar em uma exception.
           return json_encode(['status' => false]);
        } 
        
        \Mail::send('emails.password-temp', ['password' => $password, 'nome' => $user->str_nome], function($message) use ($user)
        {
            $message->to($user->str_email, $user->str_nome)->subject('Senha temporária gerada.');
        });
        
        CustomLog::log('Nova senha gerada automaticamente pro usuário ID: ' . $request->input('usuario_id') . '. Operação realizado pelo usuário ID: ' . $this->auth->user()->int_usuario_id, $user->toArray());

        return json_encode(['status' => $user->str_email]);
    }

    /**
     * @return \Illuminate\View\View
     */
    public function getDelete($id)
    {
        $usuario = Usuario::find($id);

        $usuario->delete();
        Flash::success('Usuário deletado com sucesso.');
        
        CustomLog::log('Delete do usuário ID: ' . $id . '. Operação realizado pelo usuário ID: ' . $this->auth->user()->int_usuario_id);

        return redirect('/admin/usuarios');
    }

    public function postMessagereaded(Req $request)
    {
        $usuarioMensagem = new UsuarioMensagem();
        $count           = $usuarioMensagem->where('int_usuario_id', $this->auth->user()->int_usuario_id)
                                           ->where('int_mensagem_id', $request->input('msgID'))
                                           ->count();
        if($count <= 0) {
            $usuarioMensagem->int_usuario_id  =  $this->auth->user()->int_usuario_id;
            $usuarioMensagem->int_mensagem_id = (int) $request->input('msgID');
            $usuarioMensagem->bol_lido        = true;
            $usuarioMensagem->int_num_leitura = 1;

            if(!$usuarioMensagem->save()) {
                return \Response::json(['status' => false, 'msg' => 'Erro ao salvar mensagem como lida.']);
            }

            return \Response::json(['status' => true, 'msg' => 'Mensagem salva como lida com sucesso.']);
        } else {
            return \Response::json(['status' => true, 'msg' => 'Mensagem salva como lida com sucesso.']);
        }
    }

    public function getAtribuirperfis($usuarioId)
    {
        return $this->perfisUsuarioController->getAtribuirperfis($usuarioId);
    }

    public function postAtribuir()
    {
        $usuarioId = (int) Request::input('int_usuario_id');
        $perfilId = (int) Request::input('int_perfil_id');
        $url_retorno = '/admin/usuarios/atribuirperfis/';

        return $this->perfisUsuarioController->postAtribuir($usuarioId,$perfilId,$url_retorno);
    }

    public function postDesvincularperfil()
    {
        $usuarioId = (int) Request::input('int_usuario_id');
        $perfilId = (int) Request::input('int_perfil_id');
        $url_retorno = '/admin/usuarios/atribuirperfis/';

        return $this->perfisUsuarioController->postDesvincularperfil($usuarioId,$perfilId,$url_retorno);
    }
}
