<?php
/**
 * Created by PhpStorm.
 * User: jacson
 * Date: 01/10/18
 * Time: 17:33
 */

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Anexo extends Model
{
    protected $table = 'geral.tb_anexo';

    protected $primaryKey = 'int_anexo_id';

    protected $fillable = ['str_nome','mimetype','str_nome_original'];

    public function usuariosanexo()
    {
        return $this->belongsToMany('App\Models\Geral\Usuario', 'geral.tb_usuario_anexo', 'int_anexo_id', 'int_usuario_id');
    }

    public function createAnexo($dados)
    {
        foreach ($dados as $fill => $value) {
            $this->{$fill} = $value;
        }

        return $this->save();
    }
}