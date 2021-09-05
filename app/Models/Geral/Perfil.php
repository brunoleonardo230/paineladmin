<?php

namespace App\Models\Geral;

use Illuminate\Database\Eloquent\Model;

class Perfil extends Model
{
    protected $table = 'geral.tb_perfil';

    protected $primaryKey = 'int_perfil_id';

    protected $fillable = ['str_nome', 'str_descricao', 'int_perfil_modulo_id'];

    /**
     * Relacionamento NxN com a tabela de permissoes.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function permissoes()
    {
        return $this->belongsToMany('App\Models\Geral\Permissao', 'geral.tb_perfil_permissao', 'int_perfil_permissao_perfil_id', 'int_perfil_permissao_permissao_id');
    }

    /**
     * Relacionamento 1xN com a tabela de módulos.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function modulo()
    {
        return $this->belongsTo('App\Models\Geral\Modulo', 'int_perfil_modulo_id', 'int_modulo_id');
    }

	public function usuarios()
	{
		return $this->belongsToMany('App\Models\Geral\Usuario', 'geral.tb_perfil_usuario', 'int_perfil_usuario_perfil_id', 'int_perfil_usuario_usuario_id');
	}

}
