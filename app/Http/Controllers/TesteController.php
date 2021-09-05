<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TesteController extends Controller
{
    public function show()
    {
        dd('ok1');
    }

    public function getTeste()
    {
        dd('ok');
    }
}
