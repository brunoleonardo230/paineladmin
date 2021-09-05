<?php
namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class UsuarioMensagem extends Model
{
    protected $table = 'geral.tb_usuario_mensagem';


    /**
     * Table Primary key and autoincrement.
     *
     * @var string
     */
    protected $primaryKey = 'int_usuario_mensagem_id';
}