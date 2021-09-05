<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToContasTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.contas', function(Blueprint $table)
		{
			$table->foreign('agencia_id', 'fk_contas_agencias1_idx')->references('agencia_id')->on('pnae.agencias')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.contas', function(Blueprint $table)
		{
			$table->dropForeign('fk_contas_agencias1_idx');
		});
	}

}
