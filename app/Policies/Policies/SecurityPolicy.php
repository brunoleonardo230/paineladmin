<?php

namespace App\Policies\Policies;

use App\Models\Geral\Usuario;
use Illuminate\Auth\Access\HandlesAuthorization;
use app\Models\Geral\Permissao;

class SecurityPolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function checkPermission()
    {
        
    }

    private function extractPathResources($fullPath)
    {
        if (is_string($fullPath)) {
            $fullPath = explode('/', $fullPath);
        }

        $pathArray[0] = isset($fullPath[0]) ? $fullPath[0] : 'index';
        $pathArray[1] = isset($fullPath[1]) ? $fullPath[1] : 'index';
        $pathArray[2] = isset($fullPath[2]) ? $fullPath[2] : 'index';

        return $pathArray;
    }
}
