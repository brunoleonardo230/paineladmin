<?php

namespace App\DocumentsGenerators\Pnae\Documents;

use PDF;
use App\DocumentsGenerators\Pnae\Document;
use App\DocumentsGenerators\AbstractDocument;
use App\Repositories\Pnae\Contracts\ProjetoRepositoryInterface;


class ProjetoPdf extends AbstractDocument
{

    use Document;

    protected $projeto_id;
	protected $projetoRepo;

	public function __construct($projeto_id, $projetoRepo)
	{
        $this->projeto_id = $projeto_id;
        $this->projetoRepo = $projetoRepo;
	}

    public function gerarDocumento()
    {
		$projeto = $this->projetoRepo->recuperar($this->projeto_id);
		$entidade = $this->projetoRepo->recuperarPrimeiroEntidade();
        $representanteLegal = $this->projetoRepo->recuperarPrimeiroRepresentante();
        $token = $this->getToken();

		$view = view('pnae.projeto.impressao.projeto-impresso', compact('projeto', 'entidade', 'representanteLegal', 'token'));
        $pdf = PDF::loadHTML($view);
        
        $nomeDoArquivo = 'Projeto - '.$projeto->nome.' - '.$projeto->hasEdital->titulo.'.pdf';

        $this->registrarEmissao($view->toHtml(), $nomeDoArquivo, $token);

		return $pdf->stream($nomeDoArquivo);
    }

}