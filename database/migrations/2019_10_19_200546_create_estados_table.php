<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEstadosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.estados', function(Blueprint $table)
		{
			$table->bigIncrements('estado_id', true);
			$table->string('codigo_uf');
			$table->string('estado');
			$table->string('uf');
			$table->string('regiao');
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
		Schema::drop('pnae.estados');
	}

}
