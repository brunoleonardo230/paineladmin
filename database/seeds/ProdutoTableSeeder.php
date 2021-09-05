<?php

use Illuminate\Database\Seeder;
use App\Models\Pnae\Produto;
use Illuminate\Support\Facades\Hash;

class ProdutoTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	DB::table('pnae.produtos')->delete();

        Produto::create([
            'produto'           => 'ABÓBORA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'ALFACE',
            'unidade_medida_id' => 4,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'FEIJÃO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BANANA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BATATA DOCE',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BERINJELA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BETERRABA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BOLO DE MACAXEIRA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BOLO DE PUBA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'BOLO DE TAPIOCA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'CEBOLINHA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'CENOURA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'COENTRO',
            'unidade_medida_id' => 3,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'COUVE',
            'unidade_medida_id' => 3,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'FAVA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);

        Produto::create([
            'produto'           => 'FEIJÃO VERDE',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'LARANJA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'LIMÃO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'MACAXEIRA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'MAMÃO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'MARACUJÁ',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'MAXIXE',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'MELANCIA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'MILHO VERDE',
            'unidade_medida_id' => 1,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'PEPINO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'PIMENTA DE CHEIRO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'PIMENTÃO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'QUIABO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'REPOLHO',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'RÚCULA',
            'unidade_medida_id' => 3,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'TAPIOCA',
            'unidade_medida_id' => 2,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
        Produto::create([
            'produto'           => 'VINAGREIRA',
            'unidade_medida_id' => 3,
            'created_at'        => date('Y-m-d H:i:s'),
            'updated_at'        => date('Y-m-d H:i:s')
        ]);
    }
}
