<?php

namespace App\Http\Requests\Admin;

use App\Http\Requests\Request;

class StoreRecursoRequest extends Request
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'int_modulo_id' => 'required',
            'int_categoria_recurso_id' => 'required',
            'str_nome' => 'required|min:3',
            'str_descricao' => 'required|min:4',
            'str_icone' => 'required|min:3',
            'bol_ativo' => 'required',
            'int_ordem' => 'required',
        ];
    }
}
