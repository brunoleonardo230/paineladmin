<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.contatos', function(Blueprint $table)
		{
			$table->bigIncrements('contato_id', true);
			$table->string('contato');
			$table->bigInteger('tipo_contato_id')->index('fk_contatos_tipos_contatos1_idx')->unsigned();
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
		Schema::drop('pnae.contatos');
	}

}
