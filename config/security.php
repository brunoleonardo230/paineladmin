<?php

return [
    'prelogin_openactions' => [
        'auth/login/index',
        'auth/login/login',
        'auth/api/login',
        'pnae/consultar-documentos/exibir-documento',
        'pnae/consultar-documentos/index',
        'pnae/consultar-documentos/verificar-existencia-do-documento'
    ],
    'postlogin_openactions' => [
        'index/index/index',
        'auth/logout/index',
        'home',
        '/home',
        '/'
    ]
];
