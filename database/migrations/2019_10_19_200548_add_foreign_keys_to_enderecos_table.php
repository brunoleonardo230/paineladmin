<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToEnderecosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.enderecos', function(Blueprint $table)
		{
			$table->foreign('cidade_id', 'fk_enderecos_cidades_idx')->references('cidade_id')->on('pnae.cidades')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.enderecos', function(Blueprint $table)
		{
			$table->dropForeign('fk_enderecos_cidades_idx');
		});
	}

}
