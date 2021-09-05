<?php

namespace App\Services;

use DB;

class Menu
{
    protected $request;
    protected $auth;

    public function __construct($request, $auth)
    {
        $this->request = $request;
        $this->auth = $auth;
    }

    public function render()
    {
        $path = preg_split('/\//', $this->request->path());
        $modulo = current($path);
        $controller = next($path);

        $userId = $this->auth->user()->getAuthIdentifier();

        $permissoes = $this->getPermissoes($modulo, $userId);

        $navigation = $this->getNavigationArray($permissoes, $controller);

        $html = "<ul class='nav metismenu' id='side-menu'>";

        foreach ($navigation as $nav) {
            $active = '';
            if (array_key_exists('activeMenu', $nav)) {
                $active = "class='{$nav['activeMenu']}'";
            }
            $html .= "<li {$active}>";
            $html .= "<a href='{$nav['uri']}'><span class='nav-label'><i class='fa {$nav['icon']}'></i> {$nav['label']}</span> <span class='fa arrow'></span></a>";
            $html .= "<ul class='nav nav-second-level collapse'>";
            foreach ($nav['pages'] as $page) {
                $isActive = $page['active'] == true ? "class='active'" : '';
                $html .= "<li {$isActive}><a title='{$page['label']}' href='{$page['uri']}'>{$page['label']}</a></li>";
            }
            $html .= '</ul>';
            $html .= '</li>';
        }

        $html .= '</ul>';

        echo $html;
    }

    private function getPermissoes($modulo, $usuarioId)
    {
        $sql = "SELECT
                    DISTINCT m.str_nome as mod_nome, cr.str_nome as ctr_nome, cr.str_icone as ctr_icone, cr.int_ordem as ctr_ordem, r.str_descricao as rcs_descricao, r.str_nome as rcs_nome, r.int_ordem as rcs_ordem
                FROM
                    geral.tb_usuario AS u
                    INNER JOIN geral.tb_perfil_usuario AS pu ON pu.int_perfil_usuario_usuario_id = u.int_usuario_id
                    INNER JOIN geral.tb_perfil AS p ON p.int_perfil_id = pu.int_perfil_usuario_perfil_id
                    INNER JOIN geral.tb_modulo AS m ON m.int_modulo_id = p.int_perfil_modulo_id
                    INNER JOIN geral.tb_perfil_permissao AS pp ON pp.int_perfil_permissao_perfil_id = p.int_perfil_id
                    INNER JOIN geral.tb_permissao AS pm ON pm.int_permissao_id = pp.int_perfil_permissao_permissao_id
                    INNER JOIN geral.tb_recurso AS r ON r.int_recurso_id = pm.int_permissao_recurso_id
                    INNER JOIN geral.tb_categoria_recurso AS cr ON cr.int_categoria_recurso_id = r.int_categoria_recurso_id
                WHERE
                    m.str_nome = :mod_nome AND pm.str_nome ilike '%index%' AND u.int_usuario_id = :usuario_id AND cr.bol_ativo = true
                ORDER BY
                    cr.int_ordem, r.int_ordem";

        return DB::select($sql, ['mod_nome' => $modulo, 'usuario_id' => $usuarioId]);
    }

    private function getNavigationArray($permissoes, $activeController = null)
    {
        $navigation = [];
        if (!empty($permissoes)) {
            foreach ($permissoes as $key => $permissao) {
                $navigation[$permissao->ctr_nome]['label'] = $permissao->ctr_nome;
                $navigation[$permissao->ctr_nome]['uri'] = '#';
                $navigation[$permissao->ctr_nome]['icon'] = $permissao->ctr_icone;

                if ($activeController == strtolower($permissao->rcs_nome)) {
                    $navigation[$permissao->ctr_nome]['activeMenu'] = 'active';
                }

                $navigation[$permissao->ctr_nome]['pages'][$key] = [
                    'label' => $permissao->rcs_descricao,
                    'uri' => url(strtolower($permissao->mod_nome).'/'.strtolower($permissao->rcs_nome).'/index'),
                    'controller' => strtolower($permissao->rcs_nome),
                    'action' => 'index',
                    'active' => (strtolower($permissao->rcs_nome) == $activeController),
                ];
            }
        }

        return $navigation;
    }
}
