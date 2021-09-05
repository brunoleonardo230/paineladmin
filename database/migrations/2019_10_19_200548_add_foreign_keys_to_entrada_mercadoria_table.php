<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToEntradaMercadoriaTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.entrada_mercadoria', function(Blueprint $table)
		{
			$table->foreign('entrada_id', 'fk_entrada_mercadoria_entrada1_idx')->references('entrada_id')->on('pnae.entrada')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('projeto_produtos_id', 'fk_entrada_mercadoria_projeto_produtos1_idx')->references('projeto_produtos_id')->on('pnae.projeto_produtos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.entrada_mercadoria', function(Blueprint $table)
		{
			$table->dropForeign('fk_entrada_mercadoria_entrada1_idx');
			$table->dropForeign('fk_entrada_mercadoria_projeto_produtos1_idx');
		});
	}

}
