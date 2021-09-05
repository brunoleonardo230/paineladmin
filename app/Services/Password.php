<?php
namespace App\Services;

/**
 * Password
 * 
 * Gerador de senhas aleatórias.
 */
class Password
{
	/**
	 * @var integer
	 */
	private $tamanho = 8;

	/**
	 * @var boolean
	 */
	private $maiusculas = false;

	/**
	 * @var boolean
	 */
	private $numeros = false;

	/**
	 * @var boolean
	 */
	private $simbolos = false;

	/**
	 * @var string
	 */
	private $lmin = 'abcdefghijklmnopqrstuvwxyz';

	/**
	 * @var string
	 */
    private $lmai = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    /**
     * @var string
     */
	private $num = '1234567890';

	/**
	 * @var string
	 */
	private $simb = '!@#$%*-';

	/**
	 * Seta tamanho desejado,
	 * default 8
	 * @param int $tm Tamanho de senha desejado
	 */
	public function setTamanho($tm)
	{
		$this->tamanho = $tm;
		return $this;
	}

	/**
	 * Seta o uso de letras Maiusculas
	 * na geração da senha
	 * 
	 * @return bool
	 */
	public function comLMaiusculas()
	{
		$this->maiusculas = true;
		return $this;	
	}


	/**
	 * Seta o uso de numeros Maiusculas
	 * na geração da senha
	 * 
	 * @return bool
	 */
	public function comNumeros()
	{
		$this->numeros = true;
		return $this;
	}


	/**
	 * Seta o uso de caracters especiais Maiusculas
	 * na geração da senha
	 * 
	 * @return bool
	 */
	public function comCaractersEspeciais()
	{
		$this->simbolos = true;
		return $this;
	}

	/**
	 * Gera as senhas com as configuracoes
	 * especificadas. 
	 * Pode se gerar senhas com letras maiusculas e minusculas,
	 * numeros e caracteres especiais.
	 * 
	 * @return string Senha gerada
	 */
	public function generate()
	{
		$retorno = '';
		
		$caracteres = $this->mountCaracteres();

		$len = strlen($caracteres);
		
		for ($n = 1; $n <= $this->tamanho; $n++) {
			$rand = mt_rand(1, $len);
			$retorno .= $caracteres[$rand-1];
		}

		return $retorno;
	}

	/**
	 * Monta string a ser utilizada 
	 * na geracao de senha 
	 * 
	 * @return string
	 */
	private function mountCaracteres()
	{
		$caracteres = '';
		
		$caracteres .= $this->lmin;
		
		if ($this->maiusculas){
		    $caracteres .= $this->lmai;
		}
		
		if ($this->numeros){
			$caracteres .= $this->num;
		}
		
		if ($this->simbolos){
			$caracteres .= $this->simb;
		}

		return $caracteres;
	}
}