<?php
namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Mensagem extends Model
{
    use SoftDeletes;

    protected $dates = ['deleted_at'];

    protected $table = 'geral.tb_mensagens';

    protected $primaryKey = 'int_mensagem_id';

    public $rules = array(
	   'str_titulo'     => 'required',
	   'dta_ini'        => 'required',
	   'dta_fim'        => 'required',
	   'int_sistema_id' => 'required',
	   'str_mensagem'  => 'required',
	   'bol_ativo'      => 'required',
	   'ind_tipo'      => 'required',
    );

    public function usuarios()
    {
        return $this->belongsToMany('App\Models\Geral\Usuario', 'geral.tb_usuario_mensagem', 'int_mensagem_id', 'int_usuario_id');
    }
}