<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProdutosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.produtos', function(Blueprint $table)
		{
			$table->bigIncrements('produto_id', true);
			$table->string('produto', 150);
			$table->bigInteger('unidade_medida_id')->index('fk_produtos_unidades_medida1_idx')->unsigned();
			$table->bigInteger('cliente_id');
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
		Schema::drop('pnae.produtos');
	}

}
