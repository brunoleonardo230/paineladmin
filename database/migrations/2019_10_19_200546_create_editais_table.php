<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEditaisTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.editais', function(Blueprint $table)
		{
			$table->bigIncrements('edital_id', true);
			$table->string('titulo', 150);
			$table->text('descricao');
			$table->date('data_inicial');
			$table->date('data_final');
			$table->integer('ano');
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
		Schema::drop('pnae.editais');
	}

}
