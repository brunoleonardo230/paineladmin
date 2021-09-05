<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToCotacoesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.cotacoes', function(Blueprint $table)
		{
			$table->foreign('produto_id', 'fk_valores_unitarios_produtos1_idx')->references('produto_id')->on('pnae.produtos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.cotacoes', function(Blueprint $table)
		{
			$table->dropForeign('fk_valores_unitarios_produtos1_idx');
		});
	}

}
