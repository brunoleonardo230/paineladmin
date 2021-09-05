<!DOCTYPE html>
<html lang="pt-br" itemscope itemtype="http://schema.org/Article">
	<head>
		<!-- META tags -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<!-- Page properties -->
		<title>Agenda da Gente</title>
			<style type="text/css">
			 
			#share-buttons img {
			padding: 5px;
			border: 0;
			box-shadow: 0;
			display: inline;
			float:right;
			}
			 
			</style>
		<!-- CSS -->
		<link href="{{ asset( 'public_calendario/vendor/bootstrap/css/bootstrap.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/jqueryui/themes/smoothness/jquery-ui.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/chosen/chosen.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/wysihtml5x/bootstrap3-wysihtml5.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/css/agendacalendario.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/css/mobile.css' ) }}" rel="stylesheet">

		<!-- More Bootstrap-related stuff... -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
			<![endif]-->
		{{--Meta tags para Rede Socias--}}
		<meta property="og:image" content="@yield('imagem')" />
		<meta name="twitter:image" content="@yield('imagem')" />
		<meta itemprop="image" content="@yield('imagem')" />

	</head>
	<body>
		<div class="mainDiv content-fluid">
			<div class="pageTopBorder"></div>
			<div class="pageHead offPrint">
				<div class="hamburgerMenu">
					<button type="button" class="btn">
						<span class="glyphicon glyphicon-menu-hamburger"></span>
					</button>
				</div>
				<div>
					<a href="{{ url( 'calendario/eventos/index' ) }}">
						<img class="logo" src="{{ asset( 'public_calendario/img/logo.jpg' ) }}">
					</a>
					<div class="systemTitle">
						<a href="{{ url( 'calendario/eventos/index' ) }}">
						<img src="{{ asset('public_calendario/img/agente-logo.png') }}" class="logo-agenda" title="Agenda da Gente"/>
						</a>
					</div>
					<div class="userOptions">
						@if(Auth::check())
						<a href="{{url('/')}}/calendario/eventos/adm-index">
							<span class="glyphicon glyphicon-log-in"></span>
							Acessar administrativo
						</a>
						@endif
					</div>
				</div>
			</div>
			<form action="" method="get" class="fromBuscar offPrint">
			<div class="filtersBar offPrint">
				<div class="searchBar">
					<img src="{{ asset( 'public_calendario/img/lupa.png' ) }}">
					<input type="text" name="filter_titulo" class="form-control" placeholder="Buscar por palavra-chave" aria-describedby="basic-addon1">
				</div>

				<div class="userBasedFilters">
					<div>Ordenar:</div>
					<div class="dropdown userOptionsDropdown">
						<select class="btn btn-default btn-block dropdown-toggle" name="filter_order_by" id="filter_order_by" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							@foreach ( $FILTER_ORDER_BY_VALUES as $curOrderByFilterValue => $curOrderByFilterLabel )
								<option value="{{$curOrderByFilterValue}}" {{$filter_order_by == $curOrderByFilterValue ? 'selected="selected"' : ''}}>{{$curOrderByFilterLabel}}</option>
							@endforeach
						</select>
					</div>
				</div>
			</div>
			</form>
			<div class="lowerMainDiv">
				<div class="sideBar offPrint">
					<div id="calendario"></div>
				</div>
				<div class="pageContent">
					@yield( 'content' )
				</div>
			</div>
		</div>
		<script>
			var urlroot = "{{ url('/') }}";
		</script>
		<!-- Scripts -->
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/jquery/jquery.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/jqueryui/jquery-ui.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/jqueryui/ui/minified/i18n/datepicker-pt-BR.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/bootstrap/js/bootstrap.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/maskedinput/jquery.maskedinput.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/chosen/chosen.jquery.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/wysihtml5x/bootstrap3-wysihtml5.all.min.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/wysihtml5x/locales/bootstrap-wysihtml5.pt-BR.js' ) }}"></script>
		<script type="text/javascript" src="{{ asset( 'public_calendario/js/geral.js' ) }}"></script>
	</body>
</html>