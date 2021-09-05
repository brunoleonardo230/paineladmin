<?php

namespace App\DocumentsGenerators\Pnae\Documents;

use PDF;
use App\Models\Pnae\Entrada;
use App\Models\Pnae\Entidade;
use App\Models\Pnae\RepresentanteLegal;
use App\DocumentsGenerators\Pnae\Document;
use App\DocumentsGenerators\AbstractDocument;
use App\Repositories\Pnae\Contracts\ProjetoRepositoryInterface;


class ReciboEntradaDeMercadoriaPdf extends AbstractDocument
{

    use Document;

    protected $entrada_id;

	public function __construct($entrada_id)
	{
        $this->entrada_id = $entrada_id;
	}

    public function gerarDocumento()
    {
		$entidade = Entidade::first();
		$representanteLegal = RepresentanteLegal::first();

		$entrada = Entrada::with(['hasProjeto' => function($query){
            return $query->with('hasFornecedor', 'hasEdital');
        }, 'hasEntradaMercadoria.hasProjetoProduto.hasProduto'])->find($this->entrada_id);

		if (!$entidade) {
			echo "Por favor, adicione a entidade!";
			die();
		}
		if (!$representanteLegal) {
			echo "Por favor, adicione o representante legal!";
			die();
		}

        $token = $this->getToken();

        $view = view('pnae.movimentacao.impressao.entrada-mercadoria-impresso', compact('entrada', 'entidade', 'representanteLegal', 'token'));
		$pdf = PDF::loadHTML($view);

        $nomeDoArquivo = 'entrada_mercadoria_'.$entrada->hasProjeto->hasFornecedor->nome.'.pdf';

        $this->registrarEmissao($view->toHtml(), $nomeDoArquivo, $token);

		return $pdf->stream($nomeDoArquivo);
    }

}