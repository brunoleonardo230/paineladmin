<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class CategoriaRecurso extends Model
{
    protected $table = 'geral.tb_categoria_recurso';

    protected $primaryKey = 'int_categoria_recurso_id';

    protected $fillable = ['str_nome', 'str_icone', 'int_ordem', 'bol_ativo'];
}
