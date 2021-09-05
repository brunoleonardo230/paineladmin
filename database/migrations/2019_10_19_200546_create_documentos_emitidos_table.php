<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateDocumentosEmitidosTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('pnae.documentos_emitidos', function(Blueprint $table)
		{
			$table->bigIncrements('documento_emitido_id', true);
			$table->longText('html');
			$table->string('nome_arquivo');
			$table->bigInteger('cliente_id');
			$table->bigInteger('usuario_emissor_id');
			$table->string('token');

			$table->timestamps();
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('pnae.documentos_emitidos');
	}

}
