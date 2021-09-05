<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToEntidadesHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.entidades_has_contatos', function(Blueprint $table)
		{
			$table->foreign('entidade_id', 'fk_entidades_has_contatos_entidades1_idx')->references('entidade_id')->on('pnae.entidades')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('contato_id', 'fk_entidades_has_contatos_contatos1_idx')->references('contato_id')->on('pnae.contatos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.entidades_has_contatos', function(Blueprint $table)
		{
			$table->dropForeign('fk_entidades_has_contatos_entidades1_idx');
			$table->dropForeign('fk_entidades_has_contatos_contatos1_idx');
		});
	}

}
