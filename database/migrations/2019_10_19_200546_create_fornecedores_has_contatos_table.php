<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateFornecedoresHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.fornecedores_has_contatos', function(Blueprint $table)
		{
			$table->bigInteger('fornecedor_id')->index('fk_fornecedores_has_contatos_fornecedores1_idx')->unsigned();
			$table->bigInteger('contato_id')->index('fk_fornecedores_has_contatos_contatos1_idx')->unsigned();
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
		Schema::drop('pnae.fornecedores_has_contatos');
	}

}
