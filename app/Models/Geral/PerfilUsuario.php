<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class PerfilUsuario extends Model
{
    protected $table = 'geral.tb_perfil_usuario';

    protected $fillable = ['int_perfil_usuario_usuario_id', 'int_perfil_usuario_perfil_id'];
}
