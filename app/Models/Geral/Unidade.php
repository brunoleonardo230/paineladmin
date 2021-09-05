<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Unidade extends Model
{
    protected $primaryKey = 'int_unidade_id';

    protected $table = 'geral.tb_unidade';

    protected $fillable = ['int_unidade_id', 'str_unidade', 'str_sigla', 'str_cnpj_unidade', 'str_cpf_representante', 'str_nome_representante'];

    public $timestamps = false;

    public function usuariosunidade()
    {
        return $this->belongsToMany('App\Models\Geral\Usuario', 'geral.tb_usuario_unidade', 'int_unidade_id', 'int_usuario_id');
    }

    public $createRules = [
        'int_unidade_id' => 'required|min:1',
        'str_unidade' => 'required|min:3',
    ];
}
