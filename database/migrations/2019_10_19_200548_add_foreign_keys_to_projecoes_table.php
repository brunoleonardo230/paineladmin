<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToProjecoesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.projecoes', function(Blueprint $table)
		{
			$table->foreign('produto_id', 'fk_projecoes_produtos1_idx')->references('produto_id')->on('pnae.produtos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('levantamento_produtivo_id', 'fk_projecoes_levantamentos_produtivos1_idx')->references('levantamento_produtivo_id')->on('pnae.levantamentos_produtivos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.projecoes', function(Blueprint $table)
		{
			$table->dropForeign('fk_projecoes_produtos1_idx');
			$table->dropForeign('fk_projecoes_levantamentos_produtivos1_idx');
		});
	}

}
