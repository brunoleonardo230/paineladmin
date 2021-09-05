<?php

namespace App\Models\Geral\Migracao;

use Illuminate\Database\Eloquent\Model;

class Permissao extends Model
{
	protected $connection= 'migracao';
	
    protected $table = 'geral.tb_permissao';

    protected $primaryKey = 'int_permissao_id';

    protected $fillable = ['str_nome', 'str_descricao', 'int_permissao_recurso_id'];

    public function hasPerfis()
    {
        return $this->belongsToMany('App\Models\Geral\Migracao\Perfil', 'geral.tb_perfil_permissao', 'int_perfil_permissao_permissao_id', 'int_perfil_permissao_perfil_id')->select('int_perfil_id', 'str_nome', 'str_descricao', 'int_perfil_modulo_id');
    }
}
