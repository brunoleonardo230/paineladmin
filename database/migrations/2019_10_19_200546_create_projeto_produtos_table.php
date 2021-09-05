<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProjetoProdutosTable extends Migration {
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.projeto_produtos', function(Blueprint $table)
		{
			$table->bigIncrements('projeto_produtos_id', true);
			$table->bigInteger('produto_id')->index('fk_projeto_produtos_produtos1_idx')->unsigned();
			$table->bigInteger('projeto_id')->index('fk_projeto_produtos_projetos1_idx')->unsigned();
			$table->integer('quantidade')->default(1);
			$table->decimal('valor_unitario', 10);
			$table->date('data_inicial_entrega');
			$table->date('data_final_entrega');
			$table->bigInteger('cronograma_entrega_id')->index('fk_projeto_produtos_cronogramas_entrega1_idx')->unsigned();
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
