<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildSoft</title>

    <link href="{{ asset('/css/app.css') }}" rel="stylesheet"/>

    <link rel="shortcut icon" href="{{ asset('favicon.ico') }}">

    @section('stylesheets')
    @show
</head>
<body class="skin-1 top-navigation">
@section('lockscreen')
    <div id="loading-overlay" class="loading"></div>
    <div id="loading-message" class="loading">
        <p>Carregando...</p>
        <div class="three-quarters"></div>
    </div>

@show
<div id="wrapper">
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <a href="{{url('/')}}" class="navbar-brand">BuildSoft</a>
                </div>

                @if(config('app.debug'))
                    @include('components.ambient')
                @endif
                
                <ul class="nav navbar-top-links navbar-right">
                    @if(Request::is('/'))
                        <li class="notification">
                           @if($total >= 1)
                               <span class="badge badge-error not-count">{{$total}}</span>
                           @endif
                           <i class="fa fa-bell-o"></i>
                        </li>
                    @endif
                    <li>
                        <span class="m-r-sm text-muted welcome-message">Você está logado como: <a href="{{url('/')}}/profile">{{ Auth::user()->str_usuario }}</a></span>
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

        <div class="wrapper wrapper-content">
            {{-- @include('flash::message') --}}

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