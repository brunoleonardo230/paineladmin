<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToProdutosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.produtos', function(Blueprint $table)
		{
			$table->foreign('unidade_medida_id', 'fk_produtos_unidades_medida1_idx')->references('unidade_medida_id')->on('pnae.unidades_medida')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.produtos', function(Blueprint $table)
		{
			$table->dropForeign('fk_produtos_unidades_medida1_idx');
		});
	}

}
