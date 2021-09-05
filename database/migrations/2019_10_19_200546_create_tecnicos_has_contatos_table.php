<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateTecnicosHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.tecnicos_has_contatos', function(Blueprint $table)
		{
			$table->bigInteger('contato_id')->index('fk_tecnicos_has_contatos_contatos1_idx')->unsigned();
			$table->bigInteger('tecnico_id')->index('fk_tecnicos_has_contatos_tecnicos1_idx')->unsigned();
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
		Schema::drop('pnae.tecnicos_has_contatos');
	}

}
