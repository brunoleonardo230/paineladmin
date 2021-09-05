<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProjecoesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.projecoes', function(Blueprint $table)
		{
			$table->bigIncrements('projecao_id', true);
			$table->bigInteger('produto_id')->index('fk_projecoes_produtos1_idx')->unsigned();
			$table->bigInteger('levantamento_produtivo_id')->index('fk_projecoes_levantamentos_produtivos1_idx')->unsigned();
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
		Schema::drop('pnae.projecoes');
	}

}
