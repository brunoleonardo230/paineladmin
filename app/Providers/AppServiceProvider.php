<?php

namespace App\Providers;

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(
            'App\Repositories\Pnae\Contracts\FornecedorRepositoryInterface',
            'App\Repositories\Pnae\FornecedorRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\UnidadeMedidaRepositoryInterface',
            'App\Repositories\Pnae\UnidadeMedidaRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EstadoRepositoryInterface',
            'App\Repositories\Pnae\EstadoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\CidadeRepositoryInterface',
            'App\Repositories\Pnae\CidadeRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ProdutoRepositoryInterface',
            'App\Repositories\Pnae\ProdutoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EnderecoRepositoryInterface',
            'App\Repositories\Pnae\EnderecoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ContatoRepositoryInterface',
            'App\Repositories\Pnae\ContatoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\TiposContatoRepositoryInterface',
            'App\Repositories\Pnae\TiposContatoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EntidadeRepositoryInterface',
            'App\Repositories\Pnae\EntidadeRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\RepresentanteLegalRepositoryInterface',
            'App\Repositories\Pnae\RepresentanteLegalRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EditalRepositoryInterface',
            'App\Repositories\Pnae\EditalRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\UsuarioRepositoryInterface',
            'App\Repositories\Pnae\UsuarioRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\CronogramaEntregaRepositoryInterface',
            'App\Repositories\Pnae\CronogramaEntregaRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ProjetoRepositoryInterface',
            'App\Repositories\Pnae\ProjetoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\BancoRepositoryInterface',
            'App\Repositories\Pnae\BancoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EntradaMercadoriaRepositoryInterface',
            'App\Repositories\Pnae\EntradaMercadoriaRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\AgenciaRepositoryInterface',
            'App\Repositories\Pnae\AgenciaRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ContaRepositoryInterface',
            'App\Repositories\Pnae\ContaRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ProjetoProdutoRepositoryInterface',
            'App\Repositories\Pnae\ProjetoProdutoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EditalProdutoRepositoryInterface',
            'App\Repositories\Pnae\EditalProdutoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\EntradaRepositoryInterface',
            'App\Repositories\Pnae\EntradaRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\LevantamentoProdutivoRepositoryInterface',
            'App\Repositories\Pnae\LevantamentoProdutivoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\UnidadeOperacionalRepositoryInterface',
            'App\Repositories\Pnae\UnidadeOperacionalRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\TecnicoRepositoryInterface',
            'App\Repositories\Pnae\TecnicoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ProjecaoRepositoryInterface',
            'App\Repositories\Pnae\ProjecaoRepository'
        );

        $this->app->bind(
            'App\Repositories\Pnae\Contracts\ProjecaoMensalRepositoryInterface',
            'App\Repositories\Pnae\ProjecaoMensalRepository'
        );
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Schema::defaultStringLength(191);
    }
}
