<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateCotacoesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.cotacoes', function(Blueprint $table)
		{
			$table->bigIncrements('valor_unitario_id', true);
			$table->decimal('valor', 10);
			$table->dateTime('validade_inicial')->nullable();
			$table->dateTime('validade_final')->nullable();
			$table->bigInteger('produto_id')->index('fk_valores_unitarios_produtos1_idx')->unsigned();
			$table->boolean('bol_vigente')->default(1);
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
		Schema::drop('pnae.cotacoes');
	}

}
