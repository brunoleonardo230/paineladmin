<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProjecoesMensaisTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.projecoes_mensais', function(Blueprint $table)
		{
			$table->bigIncrements('projecao_mensal_id', true);
			$table->integer('quantidade');
			$table->integer('mes_referencia');
			$table->integer('ano_referencia');
			$table->bigInteger('projecao_id')->index('fk_projecoes_mensais_projecoes1_idx')->unsigned();
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
		Schema::drop('pnae.projecoes_mensais');
	}

}
