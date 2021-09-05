<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateTecnicosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.tecnicos', function(Blueprint $table)
		{
			$table->bigIncrements('tecnico_id', true);
			$table->string('nome');
			$table->string('cpf', 15);
			$table->string('portaria', 15);
			$table->bigInteger('endereco_id')->index('fk_tecnicos_enderecos1_idx')->unsigned();
			$table->bigInteger('cliente_id');
			$table->timestamps();
			$table->softDeletes();
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('pnae.tecnicos');
	}

}
