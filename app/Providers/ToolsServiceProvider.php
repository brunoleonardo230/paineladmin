<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Tools\NumberFormat;

class ToolsServiceProvider extends ServiceProvider
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
        $this->app->singleton(NumberFormat::class, function ($app) {
            return new NumberFormat();
        });
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides()
    {
        return ['App\Tools\NumberFormat'];
    }
}
