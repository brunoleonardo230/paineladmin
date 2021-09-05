<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Log\CustomLog;

use App\Models\Geral\Perfil;
use App\Models\Geral\Modulo;
use App\Models\Geral\Recurso;
use App\Models\Geral\PerfilUsuario;

/**
 * Class IndexController.
 */
class IndexController extends Controller
{
    /**
     * @return \Illuminate\View\View
     */
    public function index()
	{
       return view('admin.index.index');
    }
}
