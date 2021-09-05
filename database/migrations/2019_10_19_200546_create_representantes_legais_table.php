<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateRepresentantesLegaisTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.representantes_legais', function(Blueprint $table)
		{
			$table->bigIncrements('representante_legal_id', true);
			$table->string('nome');
			$table->string('cpf', 15);
			$table->bigInteger('endereco_id')->index('fk_representante_legal_enderecos1_idx')->unsigned();
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
		Schema::drop('pnae.representantes_legais');
	}

}
