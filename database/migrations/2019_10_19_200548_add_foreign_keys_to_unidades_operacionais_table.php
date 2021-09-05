<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToUnidadesOperacionaisTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.unidades_operacionais', function(Blueprint $table)
		{
			$table->foreign('entidade_id', 'fk_unidades_operacionais_entidades1_idx')->references('entidade_id')->on('pnae.entidades')->onUpdate('NO ACTION')->onDelete('NO ACTION');
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
			$table->dropForeign('fk_unidades_operacionais_entidades1_idx');
		});
	}

}
