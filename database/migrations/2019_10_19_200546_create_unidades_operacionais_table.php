<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateUnidadesOperacionaisTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.unidades_operacionais', function(Blueprint $table)
		{
			$table->bigIncrements('unidade_operacional_id', true);
			$table->string('nome', 100);
			$table->string('sigla', 45);
			$table->bigInteger('entidade_id')->index('fk_unidades_operacionais_entidades1_idx')->unsigned();
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
		Schema::drop('pnae.unidades_operacionais');
	}

}
