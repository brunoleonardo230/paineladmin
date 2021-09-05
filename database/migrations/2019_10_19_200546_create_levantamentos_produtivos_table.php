<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateLevantamentosProdutivosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.levantamentos_produtivos', function(Blueprint $table)
		{
			$table->bigIncrements('levantamento_produtivo_id', true);
			$table->bigInteger('unidade_operacional_id')->index('fk_levantamentos_produtivos_unidades_operacionais1_idx')->unsigned();
			$table->bigInteger('tecnico_id')->index('fk_levantamentos_produtivos_tecnicos1_idx')->unsigned();
			$table->bigInteger('fornecedor_id')->index('fk_levantamentos_produtivos_fornecedores1_idx')->unsigned();
			$table->bigInteger('endereco_id')->index('fk_levantamentos_produtivos_enderecos1_idx')->unsigned();
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
		Schema::drop('pnae.levantamentos_produtivos');
	}

}
