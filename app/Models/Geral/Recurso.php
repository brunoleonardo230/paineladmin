<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Recurso extends Model
{
    protected $table = 'geral.tb_recurso';

    protected $primaryKey = 'int_recurso_id';

    protected $fillable = ['int_modulo_id', 'int_categoria_recurso_id', 'str_nome', 'str_descricao', 'str_icone', 'bol_ativo', 'int_ordem'];

    public function permissoes()
    {
        return $this->hasMany(Permissao::class, 'int_permissao_recurso_id', 'int_recurso_id');
    }
}
