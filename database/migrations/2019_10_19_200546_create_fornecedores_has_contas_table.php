<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateFornecedoresHasContasTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.fornecedores_has_contas', function(Blueprint $table)
		{
			$table->bigInteger('fornecedor_id')->index('fk_fornecedores_has_contas_fornecedores1_idx')->unsigned();
			$table->bigInteger('conta_id')->index('fk_fornecedores_has_contas_contas1_idx')->unsigned();
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
		Schema::drop('pnae.fornecedores_has_contas');
	}

}
