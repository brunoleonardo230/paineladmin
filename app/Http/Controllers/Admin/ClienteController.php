<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Geral\Cliente;
use Flash;

class ClienteController extends Controller
{

    public function index()
    {
        $clientes = Cliente::all();

        return view('admin.clientes.index', compact('clientes'));
    }

    public function getCreate()
    {
        return view('admin.clientes.create');
    }

    public function postCliente(Request $request)
    {
        $dados = $request->all();
        $dados['bol_ativo'] = $dados['bol_ativo'] == '1' ? true : false;
        
        $cliente = Cliente::updateOrCreate(['int_cliente_id' => $request->int_cliente_id], $request->all());

        if (!$cliente) {
            Flash::error('Erro ao tentar salvar.');

            return redirect()->back()->withInput($request->all());
        }

        Flash::success('Cliente salvo com sucesso.');

        return redirect('admin/clientes');
    }

    public function getEdit($clienteId)
    {
        $cliente = Cliente::find($clienteId);
        
        return view('admin.clientes.edit', compact('cliente'));
    }

    public function postDelete(Request $request)
    {
        $id = $request->input('int_recurso_id');

        if ($this->recursoRepository->delete($id)) {
            Flash::success('Recurso excluída com sucesso.');
        } else {
            Flash::error('Erro ao tentar excluir o recurso');
        }

        return redirect()->back();
    }
}
