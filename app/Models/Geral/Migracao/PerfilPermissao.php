<?php

namespace App\Models\Geral\Migracao;

use Illuminate\Database\Eloquent\Model;

class PerfilPermissao extends Model
{
	protected $connection= 'migracao';
	
    protected $table = 'geral.tb_perfil_permissao';

    protected $fillable = ['int_perfil_permissao_perfil_id', 'int_perfil_permissao_permissao_id'];
}
