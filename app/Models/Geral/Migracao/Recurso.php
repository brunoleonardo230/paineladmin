<?php

namespace App\Models\Geral\Migracao;

use Illuminate\Database\Eloquent\Model;

class Recurso extends Model
{
	protected $connection= 'migracao';
	
    protected $table = 'geral.tb_recurso';

    protected $primaryKey = 'int_recurso_id';

    protected $fillable = ['int_modulo_id', 'int_categoria_recurso_id', 'str_nome', 'str_descricao', 'str_icone', 'bol_ativo', 'int_ordem'];

    public function hasCategoria()
    {
    	return $this->hasOne('App\Models\Geral\Migracao\CategoriaRecurso', 'int_categoria_recurso_id', 'int_categoria_recurso_id')->select('int_categoria_recurso_id', 'str_nome', 'str_icone', 'int_ordem', 'bol_ativo');
    }

	public function hasPermissoes()
    {
    	return $this->hasMany('App\Models\Geral\Migracao\Permissao', 'int_permissao_recurso_id', 'int_recurso_id')->select('int_permissao_id', 'str_nome', 'str_descricao', 'int_permissao_recurso_id');
    }
}
