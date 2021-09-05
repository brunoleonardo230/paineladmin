<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEntidadesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.entidades', function(Blueprint $table)
		{
			$table->bigIncrements('entidade_id', true);
			$table->string('nome');
			$table->string('cnpj', 25);
			$table->bigInteger('endereco_id')->index('fk_entidades_enderecos1_idx')->unsigned();
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
		Schema::drop('pnae.entidades');
	}

}
