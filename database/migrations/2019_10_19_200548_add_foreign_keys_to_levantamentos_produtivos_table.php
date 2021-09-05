<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToLevantamentosProdutivosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.levantamentos_produtivos', function(Blueprint $table)
		{
			$table->foreign('unidade_operacional_id', 'fk_levantamentos_produtivos_unidades_operacionais1_idx')->references('unidade_operacional_id')->on('pnae.unidades_operacionais')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('tecnico_id', 'fk_levantamentos_produtivos_tecnicos1_idx')->references('tecnico_id')->on('pnae.tecnicos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('fornecedor_id', 'fk_levantamentos_produtivos_fornecedores1_idx')->references('fornecedor_id')->on('pnae.fornecedores')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('endereco_id', 'fk_levantamentos_produtivos_enderecos1_idx')->references('endereco_id')->on('pnae.enderecos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.levantamentos_produtivos', function(Blueprint $table)
		{
			$table->dropForeign('fk_levantamentos_produtivos_unidades_operacionais1_idx');
			$table->dropForeign('fk_levantamentos_produtivos_tecnicos1_idx');
			$table->dropForeign('fk_levantamentos_produtivos_fornecedores1_idx');
			$table->dropForeign('fk_levantamentos_produtivos_enderecos1_idx');
		});
	}

}
