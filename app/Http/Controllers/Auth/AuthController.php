<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Contracts\Auth\Guard;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Log\CustomLog;
use App\Models\Geral\Usuario;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    use AuthenticatesUsers;

    protected $redirectTo = '/';

    /**
     * Create a new authentication controller instance.
     */
    public function __construct(Guard $auth)
    {
        $this->auth = $auth;

        $this->middleware('guest', ['except' => 'getLogout']);
    }

    /**
     * Handle a login request to the application.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\Response
     */
    public function login(Request $request)
    {
        $validation = [
            'str_usuario' => 'required|min:3',
            'str_senha'   => 'required|min:6'
        ];

        $this->validate($request, $validation);
        $credentials = $this->getCredentials($request);

        if ($this->auth->attempt($credentials, $request->has('remember'))) {

            $this->auth->user()->update(['dta_ultimo_login' => date('Y-m-d H:i:s')]);

            $request->session()->put('cliente_logado', $this->auth->user()->cliente_id);

            if(auth()->user()->hasPerfil('Administrador', 'Admin')){
                $request->session()->put('adm_geral', true);
            }

            CustomLog::log($this->auth->user()->str_usuario .', id '. $this->auth->user()->int_usuario_id .  ', fez login no sistema!');

            \Session::forget('error_password');

            return redirect()->intended('/');
        }

        \Session::set("error_password", true);

        CustomLog::log('Usuário ' . $request->input('str_usuario') .  ' não conseguiu efetuar login no sistema!');

        return redirect('/auth/login')
            ->withInput($request->only('str_usuario', 'remember'))
            ->withErrors([
                'bad_credential' => 'Usuário e/ou senha inválidos.',
            ]);
    }

    public function getApiLogin()
    {
        header('Access-Control-Allow-Origin: *');

        return response()->json(['token' => csrf_token()]);
    }

    public function postApilogin(Request $request)
    {
        header('Access-Control-Allow-Origin: *');

        $credentials = $this->getCredentials($request);

        if ($this->auth->attempt($credentials, $request->has('remember'))) {

            CustomLog::log($this->auth->user()->str_usuario .', id '. $this->auth->user()->int_usuario_id .  ', fez login no sistema!');

            return response()->json($this->auth->user());
        }
    }

    /**
     * Get the needed authorization credentials from the request.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return array
     */
    protected function getCredentials(Request $request)
    {
        return [
            'str_usuario' => $request->input('str_usuario'),
            'password' => $request->input('str_senha'),
            'bol_ativo' => 1,
        ];
    }
}
