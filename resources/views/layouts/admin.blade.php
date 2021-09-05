<!DOCTYPE html>
<html lang="pt_br">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BuildSoft - ADMIN</title>

    <link href="{{ asset('/css/app.css') }}" rel="stylesheet"/>

    <link rel="shortcut icon" href="{{ asset('favicon.ico') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('js/plugins/data_tables_bootstrap_4/datatables.min.css') }}">

    <style type="text/css">
        /*PARA DATATABLES*/
        .dataTables_length{
          text-align: left !important;
        }

        .dataTables_filter{
          text-align: right !important;
        }

        .dataTables_filter input{
          margin-left: 5px !important;
          border-radius: 5px !important;
        }

        .dataTables_info{
          text-align: left !important;
        }

        .dataTables_paginate {
          text-align: left !important;
        }

        .required {
            color: red;
        }
    </style>

    @section('stylesheets')
    @show
</head>
<body class="skin-1">
<div class="skiplinks"><a class="skip" href="#main-content">Ir para o conteúdo principal</a></div>
@section('lockscreen')
    <div id="loading-overlay" class="loading"></div>
    <div id="loading-message" class="loading">
        <p>Carregando...</p>
        <div class="three-quarters"></div>
    </div>
@show
<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            {{ Menu::render() }}
        </div>

    </nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="col-lg-6">
                    @yield('titulo')

                    @if(config('app.debug'))
                        @include('components.ambient')
                    @endif
                </div>


                <ul class="nav navbar-top-links navbar-right" style="margin-top: 10px;">
                    <li>
                        <span class="m-r-sm text-muted welcome-message">Você está logado como: <a title="Usuário {{ Auth::user()->str_usuario }}" href="{{url('/')}}/profile">{{ Auth::user()->str_usuario }}</a></span>
                    </li>
                    <li>
                        <form action="{{ url('logout') }}" method="post">
                            {{ csrf_field() }}

                            <button style="border-color:transparent;"><i class="fa fa-sign-out"></i> Sair</button>
                        </form>
                    </li>
                </ul>
            </nav><!-- /.navbar -->
        </div>

        <section role="main" id="main-content" class="wrapper wrapper-content">
            @include('flash::message')
            @yield('content')
        </section><!-- /.wrapper-content -->

    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->

<script src="{{ asset('/js/jquery.js') }}"></script>
<script src="{{ asset('/js/bootstrap.js') }}"></script>
<script src="{{ asset('/js/plugins/metismenu/metismenu.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/plugins/data_tables_bootstrap_4/datatables.min.js') }}"></script>
<script src="{{ asset('/js/all.js') }}"></script>
<script type="text/javascript">
    $("#side-menu").metisMenu();

    $('.data-table').DataTable({
        "language":{
            "decimal":        "",
            "emptyTable":     "Tabela limpa",
            "info":           "Exibindo _START_ até _END_ de _TOTAL_ registros",
            "infoEmpty":      "Exibindo 0 até 0 de 0 entries",
            "infoFiltered":   "(filtrado por _MAX_ total de registros)",
            "infoPostFix":    "",
            "thousands":      ",",
            "lengthMenu":     "Exibir _MENU_",
            "loadingRecords": "Carregando...",
            "processing":     "Processando...",
            "search":         "Buscar:",
            "zeroRecords":    "Nenhum registro encontrado",
            "paginate": {
                "first":      "Primeiro",
                "last":       "Ultimo",
                "next":       "Proximo",
                "previous":   "Anterior"
            },
            "aria": {
                "sortAscending":  ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            }
        }
    });
</script>
@section('scripts')
@show
</body>
</html>
