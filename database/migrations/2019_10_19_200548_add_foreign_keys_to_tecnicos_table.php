<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToTecnicosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.tecnicos', function(Blueprint $table)
		{
			$table->foreign('endereco_id', 'fk_tecnicos_enderecos1_idx')->references('endereco_id')->on('pnae.enderecos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.tecnicos', function(Blueprint $table)
		{
			$table->dropForeign('fk_tecnicos_enderecos1_idx');
		});
	}

}
