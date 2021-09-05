<?php

namespace App\Models\Geral\Migracao;

use Illuminate\Database\Eloquent\Model;

class CategoriaRecurso extends Model
{
	protected $connection= 'migracao';
	
    protected $table = 'geral.tb_categoria_recurso';

    protected $primaryKey = 'int_categoria_recurso_id';

    protected $fillable = ['str_nome', 'str_icone', 'int_ordem', 'bol_ativo'];

    public function hasRecursos()
    {
    	return $this->hasMany('App\Models\Geral\Migracao\Recurso', 'int_categoria_recurso_id', 'int_categoria_recurso_id');
    }
}
