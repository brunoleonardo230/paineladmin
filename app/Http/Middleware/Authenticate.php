<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\Auth\Factory as Auth;
use App\Log\CustomLog;
use Closure;
use Flash;

class Authenticate extends Middleware
{

    /**
     * The Laravel Application.
     *
     * @var \Illuminate\Contracts\Foundation\Application
     */
    protected $app;

    public function __construct(Auth $auth, Application $app)
    {
        $this->auth = $auth;
        $this->app = $app;
    }

    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    protected function redirectTo($request)
    {
        if (! $request->expectsJson()) {
            return route('login');
        }
    }

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, ...$guards)
    {

        $usuario = isset(auth()->user()->str_nome)? auth()->user()->str_nome : $_SERVER['REMOTE_ADDR'];

        if($this->isPreLoginOpenActions()){
            CustomLog::log("Usuário {$usuario} acessou a rota: {$_SERVER['REQUEST_URI']} passando os parâmetros:", $request->all());

	        return $next($request);
        }

        parent::authenticate($request, $guards);

        if ($this->isPostLoginOpenActions() || $this->isPreLoginOpenActions() || auth()->user()->haspermission()) {

            CustomLog::log("Usuário {$usuario} acessou a rota: {$_SERVER['REQUEST_URI']} passando os parâmetros:", $request->all());

	        return $next($request);
        } else {
            CustomLog::log("Usuário {$usuario} tentou acessar a rota: {$_SERVER['REQUEST_URI']} passando os parâmetros:", $request->all(), 2);

            if($request->ajax()){
                return response()->json(['msg' => 'Você não term permissão para acessar esse recurso' , 'status' => 'error'], 400);
            }

	        Flash::error('Você não term permissão para acessar esse recurso.');

	        return redirect()->back();
        }
    }

    /**
     * Verifica se a rota eh liberada para usuarios que nao estao logados no sistema.
     *
     * @param $modulo
     * @param $recurso
     * @param $permissao
     *
     * @return bool
     */
    private function isPreLoginOpenActions()
    {
        $openActions = $this->app['config']->get('security.prelogin_openactions', []);

        return in_array($this->getPathAsString(), $openActions);
    }

    /**
     * Verifica se a rota eh liberada para usuarios que estao logados no sistema.
     *
     * @param $modulo
     * @param $recurso
     * @param $permissao
     *
     * @return bool
     */
    private function isPostLoginOpenActions()
    {
        $openActions = $this->app['config']->get('security.postlogin_openactions', []);

        return in_array($this->getPathAsString(), $openActions);
    }

    private function getPathAsString()
    {
        $path = array_filter(explode('/', parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)));

        $retorno['modulo'] = isset($path[1]) ? $path[1] : 'index';
        $retorno['recurso'] = isset($path[2]) ? $path[2] : 'index';
        $retorno['permissao'] = isset($path[3]) ? $path[3] : 'index';

        return implode('/', $retorno);
    }
}
