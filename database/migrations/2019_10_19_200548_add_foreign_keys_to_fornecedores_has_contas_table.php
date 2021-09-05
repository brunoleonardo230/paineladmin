<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToFornecedoresHasContasTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.fornecedores_has_contas', function(Blueprint $table)
		{
			$table->foreign('fornecedor_id', 'fk_fornecedores_has_contas_fornecedores1_idx')->references('fornecedor_id')->on('pnae.fornecedores')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('conta_id', 'fk_fornecedores_has_contas_contas1_idx')->references('conta_id')->on('pnae.contas')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.entidades_has_contatos', function(Blueprint $table)
		{
			$table->dropForeign('fk_fornecedores_has_contas_fornecedores1_idx');
			$table->dropForeign('fk_fornecedores_has_contas_contas1_idx');
		});
	}

}
