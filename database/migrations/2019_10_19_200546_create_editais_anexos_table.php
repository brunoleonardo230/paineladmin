<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEditaisAnexosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.editais_anexos', function(Blueprint $table)
		{
			$table->bigIncrements('edital_anexo_id');
			$table->bigInteger('edital_id')->index('fk_editais_anexos_editais_idx')->unsigned();
			$table->string('nome');
			$table->string('nome_original');
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
		Schema::drop('pnae.editais_anexos');
	}

}
