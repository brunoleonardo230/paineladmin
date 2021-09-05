<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEnderecosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.enderecos', function(Blueprint $table)
		{
			$table->bigIncrements('endereco_id', true);
			$table->string('cep', 45);
			$table->string('rua');
			$table->string('bairro');
			$table->string('numero');
			$table->string('complemento')->nullable();
			$table->bigInteger('cidade_id')->index('fk_enderecos_cidades_idx')->unsigned();
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
		Schema::drop('pnae.enderecos');
	}

}
