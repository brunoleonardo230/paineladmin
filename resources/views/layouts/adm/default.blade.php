<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<!-- META tags -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<!-- Page properties -->
		<title>Agenda da Gente</title>

		<!-- CSS -->
		<link href="{{ asset( 'public_calendario/vendor/bootstrap/css/bootstrap.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/jqueryui/themes/smoothness/jquery-ui.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/chosen/chosen.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/wysihtml5x/bootstrap3-wysihtml5.min.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/css/agendacalendario-admin.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/css/mobile-admin.css' ) }}" rel="stylesheet">
		<link href="{{ asset( 'public_calendario/vendor/bootstrap-duallistbox/bootstrap-duallistbox.css' ) }}" rel="stylesheet">
		<link rel="stylesheet" href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css">

		<!-- More Bootstrap-related stuff... -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
			<![endif]-->
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
						<span>{{Auth::check() ? 'Você está logado como:' : 'Você não está logado'}}</span>
						@if ( Auth::check() )
							<a href="{{url('/')}}/profile">{{ Auth::user()->str_usuario }}</a>
						@endif
						<a href="{{ Auth::check() ? url('auth/logout') : action( 'Calendario\EventosController@getAdmIndex' ) }}">
							<span class="glyphicon glyphicon-log-{{Auth::check() ? 'out' : 'in'}}"></span>
							{{Auth::check() ? 'Sair' : 'Fazer login'}}
						</a><br>
						<div style="color: red;font-size: 20px;float: left;font-weight: bold;">Ambiente de Homologação</div>
					</div>
				</div>
			</div>
			<div class="lowerMainDiv-admin">
				<div class="row offPrint">
					<div class="menu">
						@if ( Auth::check() )
							<a class="btn esquerda {{ (\Request::is("calendario/eventos/adm-index") || \Request::is("calendario/eventos/edit") || \Request::is("calendario/eventos/edit/*") || \Request::is("calendario/eventos/view/*"))?"active-btn":"btn-default" }}" @if( url() == '/calendario/eventos/adm-index') style="background-color: #0098DB;" @endif href="{{ action( 'Calendario\EventosController@getAdmIndex' ) }}">
								<span class="glyphicon glyphicon-list-alt"></span>
								Meus Eventos
							</a>
						@endif
						@if(Auth::user()->hasPerfil( 'calendario', 'vicegovernadoria' ) || Auth::user()->hasPerfil( 'calendario', 'cerimonial' ) || Auth::user()->hasPerfil( 'calendario', 'administrador' ) || Auth::user()->hasPerfil( 'calendario', 'gabinete'))
							<a class="btn esquerda {{ (\Request::is("calendario/eventos/todos-eventos") || \Request::is("calendario/eventos/view-todos-eventos/*"))?"active-btn":"btn-default" }}" href="{{ action( 'Calendario\EventosController@getTodosEventos' ) }}">
								<span class="glyphicon glyphicon-list-alt"></span>
								Todos os Eventos
							</a>
						@endif
						@if ( Auth::user()->hasPerfil( 'calendario', 'administrador' ) || Auth::user()->hasPerfil( 'calendario', 'gabinete' ) )
							<a class="btn esquerda {{ (\Request::is("calendario/eventos/externos") || \Request::is("calendario/eventos/confirmar-presenca-governador/*"))?"active-btn":"btn-default" }}" href="{{ action( 'Calendario\EventosController@getExternos' ) }}">
								<span class="glyphicon glyphicon-hourglass"></span>
								Eventos a aprovar
							</a>
						@endif
						@if ( Auth::user()->hasPerfil( 'calendario', 'cerimonial' ) || Auth::user()->hasPerfil( 'calendario', 'administrador' ) || Auth::user()->hasPerfil( 'calendario', 'gabinete') )
							<a class="btn esquerda {{ (\Request::is("calendario/eventos/eventos-com-governador") || \Request::is("calendario/eventos/eventos-com-governador/*"))?"active-btn":"btn-default" }}" href="{{ action('Calendario\EventosController@getEventosComGovernador') }}">
								<span class="glyphicon glyphicon-list-alt"></span>
								Eventos com o Governador
							</a>
						@endif
						@if ( Auth::user()->hasPerfil( 'calendario', 'cerimonial' ) || Auth::user()->hasPerfil( 'calendario', 'administrador')  || Auth::user()->hasPerfil( 'calendario', 'gabinete') || Auth::user()->hasPerfil( 'calendario', 'normal') )
							<a class="btn esquerda {{ (\Request::is("calendario/convidados") || \Request::is("calendario/convidados/edit-convidado") || \Request::is("calendario/convidados/edit-convidado/*"))?"active-btn":"btn-default" }}" href="{{ action( 'Calendario\ConvidadosController@getIndex' ) }}">
								<span class="glyphicon glyphicon-user"></span>
								Contatos
							</a>
							@if ( Auth::user()->hasPerfil( 'calendario', 'cerimonial' ) || Auth::user()->hasPerfil( 'calendario', 'administrador'))
								<a class="btn esquerda {{ (\Request::is("calendario/convidados/index-grupo-convidados") || \Request::is("calendario/convidados/edit-grupo-convidados") || \Request::is("calendario/convidados/edit-grupo-convidados/*"))?"active-btn":"btn-default" }}" href="{{ action( 'Calendario\ConvidadosController@getIndexGrupoConvidados' ) }}">
    								<span class="glyphicon glyphicon-user"></span>
    									Grupos de Contatos
								</a>
							@endif
							@if ( Auth::user()->hasPerfil( 'calendario', 'cerimonial' ) || Auth::user()->hasPerfil( 'calendario', 'administrador')  || Auth::user()->hasPerfil( 'calendario', 'gabinete') )
							<a class="btn esquerda {{ (\Request::is("calendario/grupo-unidades/unidade-index") || \Request::is("calendario/grupo-unidades/unidade-edit") || \Request::is("calendario/grupo-unidades/unidade-edit/*"))?"active-btn":"btn-default" }}" href="{{ action( 'Calendario\GruposUnidadesController@getUnidadeIndex' ) }}">
        						<span class="glyphicon glyphicon-user"></span>
        							Unidades
    						</a>
							@endif
							@if ( Auth::user()->hasPerfil( 'calendario', 'cerimonial' ) || Auth::user()->hasPerfil( 'calendario', 'administrador'))
								<a class="btn esquerda {{ (\Request::is("calendario/grupo-unidades") || \Request::is("calendario/grupo-unidades/edit") || \Request::is("calendario/grupo-unidades/edit/*"))?"active-btn":"btn-default" }}" href="{{ action( 'Calendario\GruposUnidadesController@getIndex' ) }}">
									<span class="glyphicon glyphicon-user"></span>
									Grupos de Unidades
								</a>
							@endif
                                {{--<a class="btn btn-default esquerda" href="{{ action( 'Calendario\NotificationController@getIndex' ) }}">--}}
									{{--<span class="glyphicon glyphicon-comment"></span>--}}
									{{--Notificação--}}
								{{--</a>--}}
						@endif
                            @if(\Request::is("calendario/eventos/adm-index"))
							<a class="btn esquerda" data-toggle="modal" data-target="#baixar">
								<span class="glyphicon glyphicon-save"></span>
								Baixar Manual
							</a>
                            @endif
@if ( isset( $showSideBarCalendar ) && $showSideBarCalendar )
<div id="calendario"></div>
@endif
</div>

</div>

<div class="pageContent-admin">
@yield( 'content' )
</div>
</div>
</div>
		<!-- Modal -->
		<div class="modal fade" id="baixar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">Baixar Anexos</h4>
					</div>
					<div class="modal-body">
						<ur>
							<li><a href="{{ \Request::url().'?f=manual' }}" target="_blank">Manual</a></li>
							<li><a href="{{ \Request::url().'?f=apresentacao' }}" target="_blank">Apresentação</a></li>
						</ur>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
					</div>
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
<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/bootstrap-duallistbox/jquery.bootstrap-duallistbox.js' ) }}"></script>
<script type="text/javascript" src="{{ asset( 'public_calendario/js/validacaoFrontFormEvento.js') }}"></script>
{{--		@yield('scripts')--}}
<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/pdfmake/build/pdfmake.min.js') }}"></script>
<script type="text/javascript" src="{{ asset( 'public_calendario/vendor/pdfmake/build/vfs_fonts.js') }}"></script>

		@yield('script')

		<script>
			var con = true;
			$( ".previewC" ).click(function() {
				$( ".convite" ).slideToggle( "slow", function() {
					if (con) {
						$('.iconPre').removeClass('glyphicon-arrow-down');
						$('.iconPre').addClass('glyphicon-arrow-up');
						con = false;
					} else {
						$('.iconPre').removeClass('glyphicon-arrow-up');
						$('.iconPre').addClass('glyphicon-arrow-down');
						con = true;
					}
				});
			});
		</script>

<script>
$('table.tabled').DataTable({
language: {
search: "Buscar: ",
"infoEmpty": "Nada encontrado para esta pesquisa",
"lengthMenu": "Exibir _MENU_",
"info": "Página _PAGE_ de _PAGES_ de _MAX_ resultado(s)",
"infoFiltered": "(De _MAX_ resultados)",
"infoEmpty": "Nenhum resultado disponivel",
"zeroRecords": "Nada encontrado",
"decimal": ",",
"thousands": ".",
paginate: {
first:      "Primeiro",
previous:   "Anterior",
next:       "Próximo",
last:       "Último"
}
},
	"ordering": false,
//	"order":[[0,"desc"]]
});
$('table.tablede').DataTable({
	language: {
		search: "Buscar: ",
		"infoEmpty": "Nada encontrado para esta pesquisa",
		"lengthMenu": "Exibir _MENU_",
		"info": "Página _PAGE_ de _PAGES_ de _MAX_ resultado(s)",
		"infoFiltered": "(De _MAX_ resultados)",
		"infoEmpty": "Nenhum resultado disponivel",
		"zeroRecords": "Nada encontrado",
		"decimal": ",",
		"thousands": ".",
		paginate: {
			first:      "Primeiro",
			previous:   "Anterior",
			next:       "Próximo",
			last:       "Último"
		}
	},
	"ordering": false,
//	"order":[[0,"desc"]]
	dom: 'lBfrtip',
	buttons: [
		'excelHtml5',
		{
			extend: 'pdfHtml5',
			customize: function ( doc ) {
				doc.content.splice( 1, 0, {
					margin: [0, 0, 0, 12],
					width: 200,
					alignment: 'center',
					image: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA10AAACqCAYAAABWBCVjAAAKQ2lDQ1BJQ0MgcHJvZmlsZQAAeNqdU3dYk/cWPt/3ZQ9WQtjwsZdsgQAiI6wIyBBZohCSAGGEEBJAxYWIClYUFRGcSFXEgtUKSJ2I4qAouGdBiohai1VcOO4f3Ke1fXrv7e371/u855zn/M55zw+AERImkeaiagA5UoU8Otgfj09IxMm9gAIVSOAEIBDmy8JnBcUAAPADeXh+dLA//AGvbwACAHDVLiQSx+H/g7pQJlcAIJEA4CIS5wsBkFIAyC5UyBQAyBgAsFOzZAoAlAAAbHl8QiIAqg0A7PRJPgUA2KmT3BcA2KIcqQgAjQEAmShHJAJAuwBgVYFSLALAwgCgrEAiLgTArgGAWbYyRwKAvQUAdo5YkA9AYACAmUIszAAgOAIAQx4TzQMgTAOgMNK/4KlfcIW4SAEAwMuVzZdL0jMUuJXQGnfy8ODiIeLCbLFCYRcpEGYJ5CKcl5sjE0jnA0zODAAAGvnRwf44P5Dn5uTh5mbnbO/0xaL+a/BvIj4h8d/+vIwCBAAQTs/v2l/l5dYDcMcBsHW/a6lbANpWAGjf+V0z2wmgWgrQevmLeTj8QB6eoVDIPB0cCgsL7SViob0w44s+/zPhb+CLfvb8QB7+23rwAHGaQJmtwKOD/XFhbnauUo7nywRCMW735yP+x4V//Y4p0eI0sVwsFYrxWIm4UCJNx3m5UpFEIcmV4hLpfzLxH5b9CZN3DQCshk/ATrYHtctswH7uAQKLDljSdgBAfvMtjBoLkQAQZzQyefcAAJO/+Y9AKwEAzZek4wAAvOgYXKiUF0zGCAAARKCBKrBBBwzBFKzADpzBHbzAFwJhBkRADCTAPBBCBuSAHAqhGJZBGVTAOtgEtbADGqARmuEQtMExOA3n4BJcgetwFwZgGJ7CGLyGCQRByAgTYSE6iBFijtgizggXmY4EImFINJKApCDpiBRRIsXIcqQCqUJqkV1II/ItchQ5jVxA+pDbyCAyivyKvEcxlIGyUQPUAnVAuagfGorGoHPRdDQPXYCWomvRGrQePYC2oqfRS+h1dAB9io5jgNExDmaM2WFcjIdFYIlYGibHFmPlWDVWjzVjHVg3dhUbwJ5h7wgkAouAE+wIXoQQwmyCkJBHWExYQ6gl7CO0EroIVwmDhDHCJyKTqE+0JXoS+cR4YjqxkFhGrCbuIR4hniVeJw4TX5NIJA7JkuROCiElkDJJC0lrSNtILaRTpD7SEGmcTCbrkG3J3uQIsoCsIJeRt5APkE+S+8nD5LcUOsWI4kwJoiRSpJQSSjVlP+UEpZ8yQpmgqlHNqZ7UCKqIOp9aSW2gdlAvU4epEzR1miXNmxZDy6Qto9XQmmlnafdoL+l0ugndgx5Fl9CX0mvoB+nn6YP0dwwNhg2Dx0hiKBlrGXsZpxi3GS+ZTKYF05eZyFQw1zIbmWeYD5hvVVgq9ip8FZHKEpU6lVaVfpXnqlRVc1U/1XmqC1SrVQ+rXlZ9pkZVs1DjqQnUFqvVqR1Vu6k2rs5Sd1KPUM9RX6O+X/2C+mMNsoaFRqCGSKNUY7fGGY0hFsYyZfFYQtZyVgPrLGuYTWJbsvnsTHYF+xt2L3tMU0NzqmasZpFmneZxzQEOxrHg8DnZnErOIc4NznstAy0/LbHWaq1mrX6tN9p62r7aYu1y7Rbt69rvdXCdQJ0snfU6bTr3dQm6NrpRuoW623XP6j7TY+t56Qn1yvUO6d3RR/Vt9KP1F+rv1u/RHzcwNAg2kBlsMThj8MyQY+hrmGm40fCE4agRy2i6kcRoo9FJoye4Ju6HZ+M1eBc+ZqxvHGKsNN5l3Gs8YWJpMtukxKTF5L4pzZRrmma60bTTdMzMyCzcrNisyeyOOdWca55hvtm82/yNhaVFnMVKizaLx5balnzLBZZNlvesmFY+VnlW9VbXrEnWXOss623WV2xQG1ebDJs6m8u2qK2brcR2m23fFOIUjynSKfVTbtox7PzsCuya7AbtOfZh9iX2bfbPHcwcEh3WO3Q7fHJ0dcx2bHC866ThNMOpxKnD6VdnG2ehc53zNRemS5DLEpd2lxdTbaeKp26fesuV5RruutK10/Wjm7ub3K3ZbdTdzD3Ffav7TS6bG8ldwz3vQfTw91jicczjnaebp8LzkOcvXnZeWV77vR5Ps5wmntYwbcjbxFvgvct7YDo+PWX6zukDPsY+Ap96n4e+pr4i3z2+I37Wfpl+B/ye+zv6y/2P+L/hefIW8U4FYAHBAeUBvYEagbMDawMfBJkEpQc1BY0FuwYvDD4VQgwJDVkfcpNvwBfyG/ljM9xnLJrRFcoInRVaG/owzCZMHtYRjobPCN8Qfm+m+UzpzLYIiOBHbIi4H2kZmRf5fRQpKjKqLupRtFN0cXT3LNas5Fn7Z72O8Y+pjLk722q2cnZnrGpsUmxj7Ju4gLiquIF4h/hF8ZcSdBMkCe2J5MTYxD2J43MC52yaM5zkmlSWdGOu5dyiuRfm6c7Lnnc8WTVZkHw4hZgSl7I/5YMgQlAvGE/lp25NHRPyhJuFT0W+oo2iUbG3uEo8kuadVpX2ON07fUP6aIZPRnXGMwlPUit5kRmSuSPzTVZE1t6sz9lx2S05lJyUnKNSDWmWtCvXMLcot09mKyuTDeR55m3KG5OHyvfkI/lz89sVbIVM0aO0Uq5QDhZML6greFsYW3i4SL1IWtQz32b+6vkjC4IWfL2QsFC4sLPYuHhZ8eAiv0W7FiOLUxd3LjFdUrpkeGnw0n3LaMuylv1Q4lhSVfJqedzyjlKD0qWlQyuCVzSVqZTJy26u9Fq5YxVhlWRV72qX1VtWfyoXlV+scKyorviwRrjm4ldOX9V89Xlt2treSrfK7etI66Trbqz3Wb+vSr1qQdXQhvANrRvxjeUbX21K3nShemr1js20zcrNAzVhNe1bzLas2/KhNqP2ep1/XctW/a2rt77ZJtrWv913e/MOgx0VO97vlOy8tSt4V2u9RX31btLugt2PGmIbur/mft24R3dPxZ6Pe6V7B/ZF7+tqdG9s3K+/v7IJbVI2jR5IOnDlm4Bv2pvtmne1cFoqDsJB5cEn36Z8e+NQ6KHOw9zDzd+Zf7f1COtIeSvSOr91rC2jbaA9ob3v6IyjnR1eHUe+t/9+7zHjY3XHNY9XnqCdKD3x+eSCk+OnZKeenU4/PdSZ3Hn3TPyZa11RXb1nQ8+ePxd07ky3X/fJ897nj13wvHD0Ivdi2yW3S609rj1HfnD94UivW2/rZffL7Vc8rnT0Tes70e/Tf/pqwNVz1/jXLl2feb3vxuwbt24m3Ry4Jbr1+Hb27Rd3Cu5M3F16j3iv/L7a/eoH+g/qf7T+sWXAbeD4YMBgz8NZD+8OCYee/pT/04fh0kfMR9UjRiONj50fHxsNGr3yZM6T4aeypxPPyn5W/3nrc6vn3/3i+0vPWPzY8Av5i8+/rnmp83Lvq6mvOscjxx+8znk98ab8rc7bfe+477rfx70fmSj8QP5Q89H6Y8en0E/3Pud8/vwv94Tz+4A5JREAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAADcWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS41LWMwMTQgNzkuMTUxNDgxLCAyMDEzLzAzLzEzLTEyOjA5OjE1ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjNlNGQzYTI4LTJhMTItMDM0MC1hMDU5LTZmYzE5NzMwZjIyMiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpFNEM4NjVGN0E4M0IxMUU2QThENEUyM0IwNzQ1NEVENyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpFNEM4NjVGNkE4M0IxMUU2QThENEUyM0IwNzQ1NEVENyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NzNmNzI1MWItYmEyZC1hYTRhLTlmMjgtMzA3YjQ4ZmVjZWMyIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjNlNGQzYTI4LTJhMTItMDM0MC1hMDU5LTZmYzE5NzMwZjIyMiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PtRy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"
				})
			}
		}
	]
});
$(function () {
$('[data-toggle="tooltip"]').tooltip()
})
</script>
</body>
</html>
