<?php

namespace App\Models\Geral\Migracao;

use Illuminate\Database\Eloquent\Model;

class Modulo extends Model
{
	protected $connection= 'migracao';
	
    protected $table = 'geral.tb_modulo';

    protected $primaryKey = 'int_modulo_id';

    protected $fillable = ['str_nome', 'str_descricao', 'str_icone', 'bol_ativo'];

}
