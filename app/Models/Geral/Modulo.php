<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Modulo extends Model
{
    protected $table = 'geral.tb_modulo';

    protected $primaryKey = 'int_modulo_id';

    protected $fillable = ['str_nome', 'str_nome_fantasia', 'str_descricao', 'str_icone', 'bol_ativo'];

    public function recursos(){
        return $this->hasMany(Recurso::class, 'int_modulo_id');
    }

    static function getIdModuloAtual()
    {
        $path = array_filter(preg_split('/\//', $_SERVER["REQUEST_URI"]));
        $modulo = current($path);

        $modulo = self::where('str_nome', 'ilike', $modulo)->first();

        return isset($modulo->int_modulo_id) ? $modulo->int_modulo_id : null;
    }
}
