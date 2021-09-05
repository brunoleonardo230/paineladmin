<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateAgenciasTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.agencias', function(Blueprint $table)
		{
			$table->bigIncrements('agencia_id', true);
			$table->string('numero');
			$table->string('nome');
			$table->bigInteger('banco_id')->index('fk_agencias_bancos1_idx')->unsigned();
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
		Schema::drop('pnae.agencias');
	}

}
