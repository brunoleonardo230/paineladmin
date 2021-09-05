<?php

use Illuminate\Database\Seeder;
use App\Models\Pnae\UnidadeMedida;
use Illuminate\Support\Facades\Hash;

class UnidadeMedidaTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	DB::table('pnae.unidades_medida')->delete();

        UnidadeMedida::create([
            'nome'          => 'Espiga/UND',
            'sigla'         => 'UND',
            'created_at'    => date('Y-m-d H:i:s'),
            'updated_at'    => date('Y-m-d H:i:s')
        ]);

        UnidadeMedida::create([
            'nome'          => 'Quilograma',
            'sigla'         => 'Kg',
            'created_at'    => date('Y-m-d H:i:s'),
            'updated_at'    => date('Y-m-d H:i:s')
        ]);

        UnidadeMedida::create([
            'nome'          => 'Maço',
            'sigla'         => 'Mç',
            'created_at'    => date('Y-m-d H:i:s'),
            'updated_at'    => date('Y-m-d H:i:s')
        ]);

        UnidadeMedida::create([
            'nome'          => 'Pé/UND',
            'sigla'         => 'UND',
            'created_at'    => date('Y-m-d H:i:s'),
            'updated_at'    => date('Y-m-d H:i:s')
        ]);
    }
}
