<?php

namespace App\Models\Geral;

use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Foundation\Auth\Access\Authorizable;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Traits\HasPerfilTrait;
use App\Traits\Suprema\HasRelacionamentoUnidadeTrait;
use App\Scopes\ScopeCliente;
use \DB;

class Usuario extends Model implements AuthenticatableContract, AuthorizableContract, CanResetPasswordContract
{
    use Notifiable, SoftDeletes, Authenticatable, CanResetPassword, Authorizable, HasPerfilTrait;

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'geral.tb_usuario';

    /**
     * Table Primary key and autoincrement.
     *
     * @var string
     */
    protected $primaryKey = 'int_usuario_id';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['str_nome', 'str_email', 'str_telefone', 'str_cargo', 'int_cpf', 'str_usuario', 'str_senha', 'bol_ativo', 'dta_ultimo_login', 'cliente_id'];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = ['str_senha', 'remember_token'];

    public function perfil()
    {
        return $this->belongsToMany('App\Models\Geral\Perfil', 'geral.tb_perfil_usuario', 'int_perfil_usuario_usuario_id', 'int_perfil_usuario_perfil_id');
    }

    public function unidade()
    {
        return $this->belongsToMany('App\Models\Geral\Unidade', 'geral.tb_usuario_unidade', 'int_usuario_id', 'int_unidade_id');
    }

    public function anexo()
    {
        return $this->belongsToMany('App\Models\Geral\Anexo', 'geral.tb_usuario_anexo', 'int_usuario_id', 'int_anexo_id');
    }

    public static $rules = [
        'str_nome' => 'required|min:3',
        'str_email' => 'required|email',
        'str_usuario' => 'required|min:3',
        'bol_ativo' => 'required'
    ];

    /**
     * Get the e-mail address where password reset links are sent.
     *
     * @return string
     */
    public function getEmailForPasswordReset()
    {
        return $this->str_email;
    }

    /**
     * Get the unique identifier for the user.
     *
     * @return mixed
     */
    public function getAuthIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Get the password for the user.
     *
     * @return string
     */
    public function getAuthPassword()
    {
        return $this->str_senha;
    }

    /**
     * Get the token value for the "remember me" session.
     *
     * @return string
     */
    public function getRememberToken()
    {
        return $this->remember_token;
    }

    /**
     * Set the token value for the "remember me" session.
     *
     * @param string $value
     */
    public function setRememberToken($value)
    {
        $this->{$this->getRememberTokenName()} = $value;
    }

    /**
     * Get the column name for the "remember me" token.
     *
     * @return string
     */
    public function getRememberTokenName()
    {
        return 'remember_token';
    }

    /**
     * Many To Many With Mensagem Entity
     */
    public function mensagens()
    {
        return $this->belongsToMany('App\Models\Geral\Mensagem', 'geral.tb_usuario_mensagem', 'int_usuario_id', 'int_mensagem_id');
    }

    public function hasPerfil($perfil, $modulo = null)
    {
        if(!$modulo){
            $modulo = $this->getAtualPathAsArray()['modulo'];
        }

       $query = $this->perfil()->whereHas('modulo', function($query) use($modulo) {
            return $query->where('str_nome', 'ilike', $modulo);
        });

        if(is_array($perfil)){
           return $query->whereIn('str_nome', 'ilike', $perfil)->exists();
        }

        return $query->where('str_nome', 'ilike', $perfil)->exists();
    }

    public function hasPermission($permission = null)
    {
        $urlPathArray = $this->getAtualPathAsArray();

        if(!is_null($permission)){
            $arrayPermissao = explode('.', $permission);
            
            $urlPathArray['recurso'] = $arrayPermissao[0] ?? 'index';
            $urlPathArray['permissao'] = $arrayPermissao[1] ?? 'index';
        }

        $sql = 'SELECT
                p.int_permissao_id, p.str_nome
            FROM geral.tb_permissao p
                INNER JOIN geral.tb_perfil_permissao pp ON pp.int_perfil_permissao_permissao_id = p.int_permissao_id
                INNER JOIN geral.tb_recurso r ON r.int_recurso_id = p.int_permissao_recurso_id
                INNER JOIN geral.tb_modulo m ON m.int_modulo_id = r.int_modulo_id
            WHERE m.str_nome = :mod_nome
                AND r.str_nome = :recurso
                AND p.str_nome = :permissao
                AND r.bol_ativo = true
                AND pp.int_perfil_permissao_perfil_id = (
                SELECT prf.int_perfil_id
                FROM geral.tb_perfil prf
                INNER JOIN geral.tb_modulo mm ON mm.int_modulo_id = prf.int_perfil_modulo_id
                INNER JOIN geral.tb_perfil_usuario pu ON pu.int_perfil_usuario_perfil_id = prf.int_perfil_id
                WHERE pu.int_perfil_usuario_usuario_id = :usuario_id AND mm.str_nome = :modulo
                )';

        return DB::select(DB::raw($sql), [
            'mod_nome'  => $urlPathArray['modulo'],
            'recurso'   => $urlPathArray['recurso'],
            'permissao' => $urlPathArray['permissao'],
            'usuario_id' => $this->int_usuario_id,
            'modulo' => $urlPathArray['modulo'],
        ]);
    }

    public function getAtualPathAsArray()
    {
        $path = array_filter(explode('/', parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)));
        
        $retorno['modulo'] = isset($path[1]) ? $path[1] : 'index';
        $retorno['recurso'] = isset($path[2]) ? $path[2] : 'index';
        $retorno['permissao'] = isset($path[3]) ? $path[3] : 'index';

        return $retorno;
    }

    protected static function boot()
    {
        parent::boot();
        if (session('cliente_logado')) {
            static::addGlobalScope(new ScopeCliente);
        }
    }
}
