<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Log\CustomLog;

//Models de origem
use App\Models\Geral\Migracao\Recurso as oRecurso;
use App\Models\Geral\Migracao\Modulo as oModulo;
use App\Models\Geral\Migracao\CategoriaRecurso as oCategoriaRecurso;

//Models de destino
use App\Models\Geral\Recurso as dRecurso;
use App\Models\Geral\Permissao as dPermissao;
use App\Models\Geral\CategoriaRecurso as dCategoriaRecurso;
use App\Models\Geral\Modulo as dModulo;
use App\Models\Geral\Perfil as dPerfil;
use App\Models\Geral\PerfilPermissao as dPerfilPermissao;

use Illuminate\Http\Request;
use \DB;
use Flash;
/**
 * Class MigracaoController.
 */
class MigracaoController extends Controller
{

    /**
     * @return \Illuminate\View\View
     */
    public function index()
	{

		$modulos = oModulo::where('bol_ativo', true)->get();
		
       	return view('admin.migracao.index', compact('modulos'));
    }

    public function getMigrarModulo(Request $request)
    {

    	try {	
    		$modulo_id = $request->modulo_id;

    		if(empty($modulo_id)){
    			throw new \Exception("Selecione um Módulo");
    		}

    		$moduloOrigem = oModulo::select('str_nome', 'str_nome_fantasia', 'str_descricao', 'str_icone', 'bol_ativo')->find($modulo_id);

	    	if(is_null($moduloOrigem)){
	    		throw new \Exception("Módulo não encontrado");
	    	}

			DB::transaction(function ()use($modulo_id, $moduloOrigem) {
		    	
				$moduloDestino = dModulo::where('str_nome', $moduloOrigem->str_nome)->first();

				if(is_null($moduloDestino)){			
			    	$moduloDestino = new dModulo();

			    	$moduloDestino->fill($moduloOrigem->toArray());
			  		$moduloDestino->save();
				}

				$oCategorias = oCategoriaRecurso::with(['hasRecursos'=>function($query)use($modulo_id){
									return $query->select('int_recurso_id', 'int_modulo_id', 'int_categoria_recurso_id', 'str_nome', 'str_descricao', 'str_icone', 'bol_ativo', 'int_ordem')
											->with(['hasPermissoes' => function($query){
												return $query->with('hasPerfis');
											}])
											->where('int_modulo_id', $modulo_id);
								}])->whereHas('hasRecursos', function($query)use($modulo_id){
									return $query->where('int_modulo_id', $modulo_id);
								})->select('int_categoria_recurso_id', 'str_nome', 'str_icone', 'int_ordem', 'bol_ativo')
								->get();

				foreach ($oCategorias as $key => $oCategoria) {

					$categoriaOrigem = $oCategoria->toArray();
				
		    		$dCategoria = dCategoriaRecurso::where('str_nome', $categoriaOrigem['str_nome'])->first();
		    		if(is_null($dCategoria)){
		    			unset($categoriaOrigem['int_categoria_recurso_id']);
		    			unset($categoriaOrigem['has_recurso']);

		    			$dCategoria = new dCategoriaRecurso();

		    			$dCategoria->fill($categoriaOrigem);
		    			$dCategoria->save();
		    		}

			    	foreach ($oCategoria->hasRecursos as $key => $oRecurso) {
			    		
			    		$dRecurso = dRecurso::where('int_modulo_id', $modulo_id)
			    							->where('str_nome', $oRecurso->str_nome)
			    							->where('bol_ativo', $oRecurso->bol_ativo)
		    								->where('int_categoria_recurso_id', $dCategoria->int_categoria_recurso_id)
		    								->first();
						
		    			if(is_null($dRecurso)){
		    				$oRecursoArr = $oRecurso->toArray();
		    				$oRecursoArr['int_categoria_recurso_id'] = $dCategoria->int_categoria_recurso_id;

		    				unset($oRecursoArr['has_categoria']);
		    				unset($oRecursoArr['has_permissoes']);
		    				unset($oRecursoArr['int_recurso_id']);

		    				$dRecurso = new dRecurso();
		    				$dRecurso->fill($oRecursoArr);
		    				$dRecurso->save();
		    			}

		    			foreach ($oRecurso->hasPermissoes as $key => $oPermissao) {
		    				$dPermissao = dPermissao::where('int_permissao_recurso_id', $dRecurso->int_recurso_id)
		    										->where('str_nome', $oPermissao->str_nome)
		    										->first();

		    				if(is_null($dPermissao)){
		    					$oPermissaoArr = $oPermissao->toArray();
		    					$oPermissaoArr['int_permissao_recurso_id'] = $dRecurso->int_recurso_id;

		    					unset($oPermissaoArr['int_permissao_id']);

		    					$dPermissao = new dPermissao();
		    					$dPermissao->fill($oPermissaoArr);
		    					$dPermissao->save();
		    				}

		    				if(count($oPermissao->hasPerfis)){
			    				foreach ($oPermissao->hasPerfis as $key => $oPerfil) {
			    					$dPerfil = dPerfil::where('str_nome', $oPerfil->str_nome)->where('int_perfil_modulo_id', $moduloDestino->int_modulo_id)->first();

			    					if(is_null($dPerfil)){
			    						$oPerfilArr = $oPerfil->toArray();

			    						unset($oPerfilArr['int_perfil_id']);

			    						$dPerfil = new dPerfil();
			    						$dPerfil->fill($oPerfilArr);
			    						$dPerfil->save();
			    					}

			    					$dPerfilPermissao = dPerfilPermissao::where('int_perfil_permissao_perfil_id', $dPerfil->int_perfil_id)
	    																->where('int_perfil_permissao_permissao_id', $dPermissao->int_permissao_id)
	    																->first();
			    					if(is_null($dPerfilPermissao)){
			    						$dPerfil->permissoes()->attach([$dPermissao->int_permissao_id]);
			    					}
			    				}
		    				}
		    			}
			    	}
		    	}
			});

			Flash::success('Migração do módulo '. strtoupper($moduloOrigem->str_nome) .' realizada com sucesso!.');
			return redirect()->back();

    	} catch (\Exception $e) {
    		Flash::error($e->getMessage());
			return redirect()->back();
    	}

    }
}
