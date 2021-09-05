<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToAgenciasTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.agencias', function(Blueprint $table)
		{
			$table->foreign('banco_id', 'fk_agencias_bancos1_idx')->references('banco_id')->on('pnae.bancos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.agencias', function(Blueprint $table)
		{
			$table->dropForeign('fk_agencias_bancos1_idx');
		});
	}

}
