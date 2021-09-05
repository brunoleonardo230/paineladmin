<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToRepresentantesLegaisHasContatosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.representantes_legais_has_contatos', function(Blueprint $table)
		{
			$table->foreign('contato_id', 'fk_representantes_legais_has_contatos_contatos1_idx')->references('contato_id')->on('pnae.contatos')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('representante_legal_id', 'fk_representantes_legais_has_contatos_representantes_legais1_idx')->references('representante_legal_id')->on('pnae.representantes_legais')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.representantes_legais_has_contatos', function(Blueprint $table)
		{
			$table->dropForeign('fk_representantes_legais_has_contatos_contatos1_idx');
			$table->dropForeign('fk_representantes_legais_has_contatos_representantes_legais1_idx');
		});
	}

}
