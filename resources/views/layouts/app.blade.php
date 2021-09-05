<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildSoft - Apps</title>

    <link href="{{ asset('/css/app.css') }}" rel="stylesheet"/>

    <link rel="shortcut icon" href="{{ asset('favicon.ico') }}">
    @section('stylesheets')
        <style type="text/css">
            .breadcrumb {
                padding-top: 20px;
            }
            .voltar {
                margin-top: 10px;
            }
        </style>
    @stop
    @section('stylesheets')
    @show
</head>
<body class="skin-1 mini-navbar">
    @section('lockscreen')
        <div id="loading-overlay" class="loading"></div>
        <div id="loading-message" class="loading">
        	<p>Carregando...</p>
        	<div class="three-quarters"></div>
        </div>

    @show
    <div id="wrapper">
        <!--
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="active">
                        <a href="#"><i class="fa fa-home"></i> <span class="nav-label">Consultas</span> <span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse in">
                            <li class="active"><a href="{{url('/')}}/sia/consultadespesas">Consulta de despesas</a></li>
                        </ul>
                    </li>
                    <li class="nav">
                        <a href="#" title="Configurações"><i class="fa fa-cog"></i> <span class="nav-label">Configurações</span></a>
                    </li>
                </ul>
            </div>
        </nav>
        -->
        <div id="page-wrapper" class="gray-bg">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header">
                        <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                        <p class="navbar-header-text">BuildSoft</p>
                    </div>
                    <ul class="nav navbar-top-links navbar-right" style="margin-top: 10px">
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

            <div class="row">
                <div class="col-md-10">
                    <ol class="breadcrumb">
                        <li>
                            <a href="{{url()}}">Home</a>
                        </li>
                        <li class="active">
                            <strong>Perfil</strong>
                        </li>
                    </ol>
                </div>
                <div class="col-md-2">
                    <a class="pull-right btn btn-sm btn-info voltar" href="{{ URL::previous() }}" role="button"><i class="fa fa-arrow-left"></i> Voltar à página anterior</a>
                </div>
            </div>

            <div class="wrapper wrapper-content">
            	@include('flash::message')

                @yield('content')
            </div><!-- /.wrapper-content -->

        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->

    <script src="{{ asset('/js/jquery.js') }}"></script>
    <script src="{{ asset('/js/bootstrap.js') }}"></script>
    <script src="{{ asset('/js/all.js') }}"></script>
    @section('scripts')
    @show
</body>
</html>
