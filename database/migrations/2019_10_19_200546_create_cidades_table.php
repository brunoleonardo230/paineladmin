<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateCidadesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.cidades', function(Blueprint $table)
		{
			$table->bigIncrements('cidade_id', true);
			$table->bigInteger('estado_id')->index('fk_cidades_estados1_idx')->unsigned();
			$table->string('codigo_ibge');
			$table->string('cidade');
			$table->timestamps();
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('pnae.cidades');
	}

}
