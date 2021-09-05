<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToProjecoesMensaisTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.projecoes_mensais', function(Blueprint $table)
		{
			$table->foreign('projecao_id', 'fk_projecoes_mensais_projecoes1_idx')->references('projecao_id')->on('pnae.projecoes')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.projecoes_mensais', function(Blueprint $table)
		{
			$table->dropForeign('fk_projecoes_mensais_projecoes1_idx');
		});
	}

}
