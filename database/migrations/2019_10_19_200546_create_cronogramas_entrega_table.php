<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateCronogramasEntregaTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.cronogramas_entrega', function(Blueprint $table)
		{
			$table->bigIncrements('cronograma_entrega_id', true);
			$table->string('frequencia');
			$table->integer('qtde_dias');
			$table->string('descricao', 255)->nullable();
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
		Schema::drop('pnae.cronogramas_entrega');
	}

}
