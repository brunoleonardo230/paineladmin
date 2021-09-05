<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Services\Menu;

class MenuServiceProvider extends ServiceProvider
{
    /**
     * Indicates if loading of the provider is deferred.
     *
     * @var bool
     */
    protected $defer = true;

    /**
     * Register the application services.
     */
    public function register()
    {
        $this->app->singleton(Menu::class, function ($app) {
            return new Menu($app['request'], $app['auth']);
        });
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides()
    {
        return ['App\Services\Menu'];
    }
}
