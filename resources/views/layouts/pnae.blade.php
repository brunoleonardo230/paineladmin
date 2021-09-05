<!DOCTYPE html>

<html lang="pt-br" dir="ltr">
    <head>
        <meta charset="utf-8" />
        <title>Programa Nacional de Alimentação Escolar - PNAE | @yield('title')</title>
        <meta name="description" content="Latest updates and statistic charts">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="csrf-token" id="csrf-token" content="{{ csrf_token() }}">

        <script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
        <script>
        WebFont.load({
            google: {"families":["Poppins:300,400,500,600,700","Roboto:300,400,500,600,700"]},
            active: function() {
                sessionStorage.fonts = true;
            }
        });
        </script>

        <script type="text/javascript">
            var urlBase = "{{ url('/') }}";
            var urlAsset = "{{ asset('/') }}";
            var urlAtual = window.location.href;
        </script>

        <link href="{{ asset('templates/metronic/vendors/base/vendors.bundle.css') }}" rel="stylesheet" type="text/css" />
        <link href="{{ asset('templates/metronic/demo/default/base/style.bundle.css') }}" rel="stylesheet" type="text/css" />
        <link href="{{ asset('templates/metronic/css/style.css') }}" rel="stylesheet" type="text/css" />
        <link href="{{ asset('pnae/css/build.css') }}" rel="stylesheet" type="text/css"/>
        <link href="{{ asset('pnae/css/pnae.css') }}" rel="stylesheet" type="text/css"/>

        <link rel="shortcut icon" href="{{asset('templates/metronic/demo/default/media/img/logo/favicon.ico')}}" />

        @yield('css')
        <style>
            .padding-top-25 {
                padding-top: 25px;
            }
        </style>

    </head>
    <body class="m-page--fluid m--skin- m-content--skin-light2 m-header--fixed m-header--fixed-mobile m-aside-left--enabled m-aside-left--skin-dark m-aside-left--offcanvas m-footer--push m-aside--offcanvas-default" >

        <div class="m-grid m-grid--hor m-grid--root m-page" >

            @include('pnae.partials.menu-superior')

            <div class="m-grid__item m-grid__item--fluid m-grid m-grid--ver-desktop m-grid--desktop m-body">
                {{-- @include('pnae.partials.menu-lateral') --}}

                <button class="m-aside-left-close  m-aside-left-close--skin-dark " id="m_aside_left_close_btn">
                    <i class="la la-close"></i>
                </button>
                <div id="m_aside_left" class="m-grid__item	m-aside-left  m-aside-left--skin-dark ">
                    <div id="m_ver_menu" class="m-aside-menu m-aside-menu--skin-dark m-aside-menu--submenu-skin-dark" m-menu-vertical="1" m-menu-scrollable="0" m-menu-dropdown-timeout="500" >
                        {{ MenuPnae::render() }}
                    </div>
                </div>

                <div id="app" class="m-grid__item m-grid__item--fluid m-wrapper" v-cloak>
                    @yield('conteudo')
                </div>
            </div>

            @include('pnae.partials.rodape')

        </div>

        <div id="m_scroll_top" class="m-scroll-top">
            <i class="la la-arrow-up"></i>
        </div>

        <script src="{{ asset('templates/metronic/vendors/base/vendors.bundle.js') }}" type="text/javascript"></script>
        <script src="{{ asset('templates/metronic/demo/default/base/scripts.bundle.js') }}" type="text/javascript"></script>

        @yield('script')

        @yield('js-init')

        <script src="{{ asset('pnae/js/build.js') }}" type="text/javascript"></script>


    </body>
</html>
