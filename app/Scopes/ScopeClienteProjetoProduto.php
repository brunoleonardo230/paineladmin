<?php

namespace App\Scopes;

use Illuminate\Database\Eloquent\Scope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use App\Models\Pnae\Projeto;

class ScopeClienteProjetoProduto implements Scope
{
    /**
     * Apply the scope to a given Eloquent query builder.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $builder
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @return void
     */
    public function apply(Builder $builder, Model $model)
    {
        if(session('cliente_logado')){
            $builder->whereHas('hasProjeto', function($query){
                return $query->where('cliente_id', session('cliente_logado'));
            });
        }
    }
}