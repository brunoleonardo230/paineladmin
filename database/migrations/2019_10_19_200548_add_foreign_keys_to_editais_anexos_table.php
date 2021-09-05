<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToEditaisAnexosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.editais_anexos', function(Blueprint $table)
		{
			$table->foreign('edital_id', 'fk_editais_anexos_editais_idx')->references('edital_id')->on('pnae.editais')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.editais_anexos', function(Blueprint $table)
		{
			$table->dropForeign('fk_editais_anexos_editais_idx');
		});
	}

}
