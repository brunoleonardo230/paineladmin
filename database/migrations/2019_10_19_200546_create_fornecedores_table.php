<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateFornecedoresTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.fornecedores', function(Blueprint $table)
		{
			$table->bigIncrements('fornecedor_id', true);
			$table->string('nome', 200);
			$table->string('cpf_cnpj', 15)->unique();
			$table->string('dap_fisica', 80)->nullable();
			$table->bigInteger('endereco_id')->index('fk_fornecedores_enderecos1_idx')->unsigned();
			$table->enum('tipo_pessoa', array('PF','PJ'));
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
		Schema::drop('pnae.fornecedores');
	}

}
