<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToFornecedoresHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.fornecedores_has_contatos', function(Blueprint $table)
		{
			$table->foreign('fornecedor_id', 'fk_fornecedores_has_contatos_fornecedores1_idx')->references('fornecedor_id')->on('pnae.fornecedores')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('contato_id', 'fk_fornecedores_has_contatos_contatos1_idx')->references('contato_id')->on('pnae.contatos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.fornecedores_has_contatos', function(Blueprint $table)
		{
			$table->dropForeign('fk_fornecedores_has_contatos_fornecedores1_idx');
			$table->dropForeign('fk_fornecedores_has_contatos_contatos1_idx');
		});
	}

}
