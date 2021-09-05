<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddForeignKeysToProjetosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pnae.projetos', function(Blueprint $table)
		{
			$table->foreign('fornecedor_id', 'fk_projetos_fornecedores1_idx')->references('fornecedor_id')->on('pnae.fornecedores')->onUpdate('NO ACTION')->onDelete('NO ACTION');
			$table->foreign('edital_id', 'fk_projetos_editais1_idx')->references('edital_id')->on('pnae.editais')->onUpdate('NO ACTION')->onDelete('NO ACTION');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pnae.projetos', function(Blueprint $table)
		{
			$table->dropForeign('fk_projetos_fornecedores1_idx');
			$table->dropForeign('fk_projetos_editais1_idx');
		});
	}

}
