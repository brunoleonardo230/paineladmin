<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateFornecedoresHasEnderecosProdutivosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.fornecedores_has_enderecos_produtivos', function(Blueprint $table)
		{
			$table->bigInteger('fornecedor_id')->index('fk_fornecedores_has_enderecos_produtivos_fornecedores1_idx')->unsigned();
			$table->bigInteger('endereco_id')->index('fk_fornecedores_has_enderecos_produtivos_enderecos1_idx')->unsigned();
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
		Schema::drop('pnae.fornecedores_has_enderecos_produtivos');
	}

}
