<?php

namespace App\Http\Requests\Admin;

use App\Http\Requests\Request;

class StoreCategoriaRecursoRequest extends Request
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
            'str_nome' => 'required|min:3',
            'str_icone' => 'required|min:3',
            'int_ordem' => 'required',
            'bol_ativo' => 'required',
        ];
    }
}
