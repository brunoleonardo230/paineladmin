<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProjetosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.projetos', function(Blueprint $table)
		{
			$table->bigIncrements('projeto_id', true);
			$table->bigInteger('fornecedor_id')->index('fk_projetos_fornecedores1_idx')->unsigned();
			$table->bigInteger('edital_id')->index('fk_projetos_editais1_idx')->unsigned();
			$table->bigInteger('cliente_id');
			$table->date('data_projeto');
			$table->date('data_final_projeto');
			$table->timestamps();
			$table->softDeletes();
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('pnae.projetos');
	}

}
