<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateRepresentantesLegaisHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.representantes_legais_has_contatos', function(Blueprint $table)
		{
			$table->bigInteger('contato_id')->index('fk_representantes_legais_has_contatos_contatos1_idx')->unsigned();
			$table->bigInteger('representante_legal_id')->index('fk_representantes_legais_has_contatos_representantes_legais1_idx')->unsigned();
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
		Schema::drop('pnae.representantes_legais_has_contatos');
	}

}
