<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Permissao extends Model
{
    protected $table = 'geral.tb_permissao';

    protected $primaryKey = 'int_permissao_id';

    protected $fillable = ['str_nome', 'str_descricao', 'int_permissao_recurso_id'];

    public function recurso()
    {
        return $this->belongsTo('App\Models\Geral\Recurso', 'int_permissao_recurso_id', 'int_permissao_id');
    }
}
