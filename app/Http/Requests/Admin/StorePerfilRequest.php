<?php

namespace App\Http\Requests\Admin;

use App\Http\Requests\Request;

class StorePerfilRequest extends Request
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
            'str_descricao' => 'required|min:5',
            'int_perfil_modulo_id' => 'required',
        ];
    }
}
