<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEntidadesHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.entidades_has_contatos', function(Blueprint $table)
		{
			$table->bigInteger('entidade_id')->index('fk_entidades_has_contatos_entidades1_idx')->unsigned();
			$table->bigInteger('contato_id')->index('fk_entidades_has_contatos_contatos1_idx')->unsigned();
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
		Schema::drop('pnae.entidades_has_contatos');
	}

}
