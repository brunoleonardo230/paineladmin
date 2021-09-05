<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToFornecedoresHasEnderecosProdutivosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.fornecedores_has_enderecos_produtivos', function(Blueprint $table)
		{
			$table->foreign('fornecedor_id', 'fk_fornecedores_has_enderecos_produtivos_fornecedores1_idx')->references('fornecedor_id')->on('pnae.fornecedores')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('endereco_id', 'fk_fornecedores_has_enderecos_produtivos_enderecos1_idx')->references('endereco_id')->on('pnae.enderecos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.fornecedores_has_enderecos_produtivos', function(Blueprint $table)
		{
			$table->dropForeign('fk_fornecedores_has_enderecos_produtivos_fornecedores1_idx');
			$table->dropForeign('fk_fornecedores_has_enderecos_produtivos_enderecos1_idx');
		});
	}

}
