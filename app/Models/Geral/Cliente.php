<?php
namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    protected $table = 'geral.tb_cliente';


    /**
     * Table Primary key and autoincrement.
     *
     * @var string
     */
    protected $primaryKey = 'int_cliente_id';

    protected $dates = ['dta_data_inicio_contrato'];

    protected $fillable = ['str_nome', 'dta_data_inicio_contrato', 'bol_ativo'];

    public function getDtaDataInicioContratoAttribute($dta) {
        return date_create_from_format('Y-m-d', $dta)->format('d/m/Y');
    }

    public function getDtaDataInicioContratoYmdAttribute($dta) {
        return date_create_from_format('Y-m-d', $dta)->format('d/m/Y');
    }

    public static function getClientesAtivos()
    {
        return self::where('bol_ativo', true)->get();
    }
}