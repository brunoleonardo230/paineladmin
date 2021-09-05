<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysTotecnicosHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.tecnicos_has_contatos', function(Blueprint $table)
		{
			$table->foreign('contato_id', 'fk_tecnicos_has_contatos_contatos1_idx')->references('contato_id')->on('pnae.contatos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('tecnico_id', 'fk_tecnicos_has_contatos_tecnicos1_idx')->references('tecnico_id')->on('pnae.tecnicos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.tecnicos_has_contatos', function(Blueprint $table)
		{
			$table->dropForeign('fk_tecnicos_has_contatos_contatos1_idx');
			$table->dropForeign('fk_tecnicos_has_contatos_tecnicos1_idx');
		});
	}

}
