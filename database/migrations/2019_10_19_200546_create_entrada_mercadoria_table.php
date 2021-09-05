<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEntradaMercadoriaTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.entrada_mercadoria', function(Blueprint $table)
		{
			$table->bigIncrements('entrada_mercadoria_id', true);
			$table->bigInteger('cliente_id');
			$table->bigInteger('entrada_id')->index('fk_entrada_mercadoria_entrada1_idx')->unsigned();
			$table->bigInteger('projeto_produtos_id')->index('fk_entrada_mercadoria_projeto_produtos1_idx')->unsigned();
			$table->integer('qtd_entregue');
			$table->date('dta_entrega');
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
		Schema::drop('pnae.entrada_mercadoria');
	}

}
