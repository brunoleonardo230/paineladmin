<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Auth::routes();

Route::group(['prefix' => 'auth', 'namespace' => 'Auth'], function(){
    Route::post('login', 'AuthController@login');
});

Route::get('/', 'IndexController@index')->name('home');
Route::get('/home', 'IndexController@index')->name('home');

Route::group(['prefix' => 'admin', 'namespace' => 'Admin', 'middleware' =>'auth'], function(){
    Route::get('index', 'IndexController@index');
    Route::get('index/index', 'IndexController@index');

    Route::group(['prefix' => 'clientes'], function(){
        Route::get('/', 'ClienteController@index');
        Route::get('index', 'ClienteController@index');
        Route::get('edit/{id}', 'ClienteController@getEdit');
        Route::get('create', 'ClienteController@getCreate');
        Route::post('cliente', 'ClienteController@postCliente');
    });

    Route::group(['prefix' => 'categoriasrecursos'], function(){
        Route::get('/', 'CategoriasRecursosController@index');
        Route::get('index', 'CategoriasRecursosController@index');
        Route::get('create', 'CategoriasRecursosController@getCreate');
        Route::post('create', 'CategoriasRecursosController@postCreate');
        Route::post('delete', 'CategoriasRecursosController@postDelete');
    });

    Route::group(['prefix' => 'migracao'], function(){
        Route::get('index', 'MigracaoController@index');
        Route::get('migrar-modulo', 'MigracaoController@getMigrarModulo');
    });

    Route::group(['prefix' => 'modulos'], function(){
        Route::get('/', 'ModulosController@index');
        Route::get('index', 'ModulosController@index');
        Route::post('delete', 'ModulosController@postDelete');
        Route::get('create', 'ModulosController@getCreate');
        Route::post('create', 'ModulosController@postCreate');
    });

    Route::group(['prefix' => 'notificacoes'], function(){
        Route::get('/', 'NotificacoesController@index');
        Route::get('index', 'NotificacoesController@index');
        Route::get('delete/{id}', 'NotificacoesController@getDelete');
        Route::get('view/{id}', 'NotificacoesController@getView');
        Route::get('edit/{id}', 'NotificacoesController@getEdit');
        Route::get('create', 'NotificacoesController@getCreate');
        Route::post('create', 'NotificacoesController@postCreate');
    });

    Route::group(['prefix' => 'perfis'], function(){
        Route::get('/', 'PerfisController@index');
        Route::get('index', 'PerfisController@index');
        Route::post('delete', 'PerfisController@postDelete');
        Route::get('create', 'PerfisController@getCreate');
        Route::post('create', 'PerfisController@postCreate');
    });

    Route::group(['prefix' => 'perfispermissoes'], function(){
        Route::get('index', 'PerfisPermissoesController@index');
        Route::get('atribuirpermissoes/{perfil_id}', 'PerfisPermissoesController@getAtribuirpermissoes');
        Route::post('atribuirpermissoes', 'PerfisPermissoesController@postAtribuirpermissoes');
    });

    Route::group(['prefix' => 'perfisusuarios'], function(){
        Route::get('/', 'PerfisUsuariosController@index');
        Route::get('index', 'PerfisUsuariosController@index');
        Route::post('desvincularperfil', 'PerfisUsuariosController@postDesvincularperfil');
        Route::get('perfis', 'PerfisUsuariosController@getPerfis');
        Route::get('atribuirperfis/{usuario_id}', 'PerfisUsuariosController@getAtribuirperfis');
        Route::post('atribuir', 'PerfisUsuariosController@postAtribuir');
    });

    Route::group(['prefix' => 'permissoes'], function(){
        Route::get('/', 'PermissoesController@index');
        Route::get('index', 'PermissoesController@index');
        Route::post('delete', 'PermissoesController@postDelete');
        Route::get('create', 'PermissoesController@getCreate');
        Route::post('create', 'PermissoesController@postCreate');
    });

    Route::group(['prefix' => 'recursos'], function(){
        Route::get('/', 'RecursosController@index');
        Route::get('index', 'RecursosController@index');
        Route::post('delete', 'RecursosController@postDelete');
        Route::get('create', 'RecursosController@getCreate');
        Route::post('create', 'RecursosController@postCreate');
    });

    Route::group(['prefix' => 'unidades', 'middleware' => 'can:unidades.index'], function(){
        Route::get('index', 'UnidadesController@index');
        Route::post('delete', 'UnidadesController@postDelete');
        Route::get('create', 'UnidadesController@getCreate');
        Route::post('create', 'UnidadesController@postCreate');
    });

    Route::group(['prefix' => 'usuarios'], function(){
        Route::get('/', 'UsuariosController@index');
        Route::get('index', 'UsuariosController@index');
        Route::post('atribuir', 'UsuariosController@postAtribuir');
        Route::post('desvincularperfil', 'UsuariosController@postDesvincularperfil');
        Route::get('atribuirperfis/{usuario_id}', 'UsuariosController@getAtribuirperfis');
        Route::post('messagereaded', 'UsuariosController@postMessagereaded');
        Route::post('generatenewpassword', 'UsuariosController@postGeneratenewpassword');
        Route::get('delete/{id}', 'UsuariosController@getDelete');
        Route::get('edit/{id}', 'UsuariosController@getEdit');
        Route::post('edit', 'UsuariosController@postEdit');
        Route::get('create', 'UsuariosController@getCreate');
        Route::post('create', 'UsuariosController@postCreate');
    });
});

