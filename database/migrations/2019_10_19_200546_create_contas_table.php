<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateContasTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.contas', function(Blueprint $table)
		{
			$table->bigIncrements('conta_id', true);
			$table->string('numero_conta', 15);
			$table->string('digito_verificador', 1);
			$table->enum('tipo_conta', array('C','P'));
			$table->bigInteger('agencia_id')->index('fk_contas_agencias1_idx')->unsigned();
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
		Schema::drop('pnae.contas');
	}

}
