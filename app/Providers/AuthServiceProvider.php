<?php

namespace App\Providers;

use App\Models\Geral\Modulo;
use Illuminate\Http\Request;
use Illuminate\Contracts\Auth\Access\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        // 'App\Models\Geral\Usuario' => 'App\Policies\SecurityPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot(Gate $gate, Request $request)
    {
        
        $arayPath = array_filter(explode('/',$request->path()));
        $nomeModulo = isset($arayPath[0])? $arayPath[0] : '';

        $modulo = Modulo::with('recursos.permissoes')->where('str_nome', $nomeModulo)->first();

        if($modulo){
            // $gate->before(function(){
            //     return auth()->user()->hasPerfil('administrador');
            // });

            $modulo->recursos->each(function($recurso, $key) use($gate) {
                $recurso->permissoes->each(function($permissao, $key) use($recurso, $gate) {
                    $fullPermission = $recurso->str_nome .'.'. $permissao->str_nome;
    
                    $gate->define($fullPermission, function() use($fullPermission) {
                        return auth()->user()->hasPermission($fullPermission);
                    });
                });
            });

        } else {

            return false;
        }

    }
}