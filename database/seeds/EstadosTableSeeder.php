<?php

use Illuminate\Database\Seeder;
use App\Models\Pnae\Estado;

class EstadosTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	DB::table('pnae.estados')->delete();

        Estado::create([
            'codigo_uf' => '12',
            'estado' => 'Acre',
            'uf' => 'AC',
            'regiao' => 'Norte'
        ]);
        Estado::create([
            'codigo_uf' => '27',
            'estado' => 'Alagoas',
            'uf' => 'AL',
            'regiao' => 'Nordeste',
        ]);
        Estado::create([
            'codigo_uf' => '16',
            'estado' => 'Amapá',
            'uf' => 'AP',
            'regiao' => 'Norte',
        ]);
        Estado::create([
            'codigo_uf' => '13',
            'estado' =>'Amazonas',
            'uf' => 'AM',
            'regiao' => 'Norte',
        ]);
        Estado::create([
            'codigo_uf' => '29',
            'estado' => 'Bahia',
            'uf' => 'BA',
            'regiao' => 'Nordeste',
        ]);
        Estado::create([
            'codigo_uf' => '23',
            'estado' => 'Ceará',
            'uf' => 'CE',
            'regiao' => 'Nordeste',
        ]);
        Estado::create([
            'codigo_uf' => '53',
            'estado' => 'Distrito Federal',
            'uf' => 'DF',
            'regiao' => 'Centro-Oeste',
        ]);
        Estado::create([
            'codigo_uf' => '32',
            'estado' => 'Espírito Santo',
            'uf' => 'ES',
            'regiao' => 'Sudeste'
        ]);
        Estado::create([
            'codigo_uf' => '52',
            'estado' => 'Goiás',
            'uf' => 'GO',
            'regiao' => 'Centro-Oeste',
        ]);
        Estado::create([
            'codigo_uf' =>  '21',
            'estado' => 'Maranhão',
            'uf' => 'MA',
            'regiao' => 'Nordeste',
        ]);
        Estado::create([
            'codigo_uf' =>  '51',
            'estado' => 'Mato Grosso',
            'uf' => 'MT',
            'regiao' => 'Centro-Oeste',
        ]);
        Estado::create([
            'codigo_uf' =>  '50',
            'estado' => 'Mato Grosso do Sul',
            'uf' => 'MS',
            'regiao' => 'Centro-Oeste',
        ]);
        Estado::create([
            'codigo_uf' =>  '31',
            'estado' => 'Minas Gerais',
            'uf' => 'MG',
            'regiao' => 'Sudeste',
        ]);
        Estado::create([
            'codigo_uf' =>  '15',
            'estado' => 'Pará',
            'uf' => 'PA',
            'regiao' => 'Nordeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '25',
            'estado' => 'Paraíba',
            'uf' => 'PB',
            'regiao' => 'Nordeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '41',
            'estado' => 'Paraná', 
            'uf' => 'PR',
            'regiao' => 'Sul'
        ]);
        Estado::create([
            'codigo_uf' =>  '26',
            'estado' => 'Pernambuco',
            'uf' => 'PE',
            'regiao' =>'Nordeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '22',
            'estado' => 'Piauí',
            'uf' => 'PI',
            'regiao' => 'Nordeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '33',
            'estado' => 'Rio de Janeiro',
            'uf' => 'RJ',
            'regiao' => 'Sudeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '24',
            'estado' => 'Rio Grande do Norte',
            'uf' => 'RN',
            'regiao' => 'Nordeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '43',
            'estado' => 'Rio Grande do Sul',
            'uf' => 'RS',
            'regiao' => 'Sul'
        ]);
        Estado::create([
            'codigo_uf' =>  '11',
            'estado' => 'Rondônia',
            'uf' => 'RO',
            'regiao' => 'Norte'
        ]);
        Estado::create([
            'codigo_uf' =>  '14',
            'estado' => 'Roraima',
            'uf' => 'RR',
            'regiao' => 'Norte'
        ]);
        Estado::create([
            'codigo_uf' =>  '42',
            'estado' => 'Santa Catarina',
            'uf' => 'SC',
            'regiao' => 'Sul'
        ]);
        Estado::create([
            'codigo_uf' =>  '35',
            'estado' => 'São Paulo',
            'uf' => 'SP',
            'regiao' => 'Sudeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '28',
            'estado' => 'Sergipe',
            'uf' => 'SE',
            'regiao' => 'Nordeste'
        ]);
        Estado::create([
            'codigo_uf' =>  '17',
            'estado' => 'Tocantins',
            'uf' => 'TO',
            'regiao' => 'Norte'
        ]);
    }
}
