<?php

use Illuminate\Database\Seeder;
use App\Models\Pnae\User;
use Illuminate\Support\Facades\Hash;

class UsuarioTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	DB::table('pnae.users')->delete();

        User::create([
            'name'          => 'Teste PNAE',
            'email'         => 'teste@buildsoft.com.br',
            'cliente_id'    => 1,
            'password'      => bcrypt('123'),
        ]);
    }
}
