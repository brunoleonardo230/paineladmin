<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateEditalProdutosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.edital_produtos', function(Blueprint $table)
		{
			$table->bigIncrements('edital_produtos_id', true);
			$table->bigInteger('edital_id')->index('fk_edital_produtos_editais1_idx')->unsigned();
			$table->bigInteger('produto_id')->index('fk_edital_produtos_produtos_id1_idx')->unsigned();
			$table->bigInteger('quantidade')->default(1);
			$table->decimal('valor', 10);
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
		Schema::drop('pnae.edital_produtos');
	}

}
