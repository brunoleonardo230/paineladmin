<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.contatos', function(Blueprint $table)
		{
			$table->foreign('tipo_contato_id', 'fk_contatos_tipos_contatos1_idx')->references('tipo_contato_id')->on('pnae.tipos_contatos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.contatos', function(Blueprint $table)
		{
			$table->dropForeign('fk_contatos_tipos_contatos1_idx');
		});
	}

}
