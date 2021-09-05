@extends('layouts.admin')

@section('stylesheets')
    <link href="{{ asset('/css/plugins/jstree/jstree.css') }}" rel="stylesheet"/>
    <style type="text/css">
        .btnAtribuir {
            margin-top: 23px;
        }
    </style>
@stop

@section('titulo')
    <h2>Atribuir Perfil ao Usuário</h2>
@stop

@section('content')
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('')}}">App</a>
                </li>
                <li>
                    <a href="{{url('')}}/admin/index">Admin</a>
                </li>
                <li>
                    <a onclick="window.history.back()">Perfis Usuários</a>
                </li>
                <li class="active">
                    <strong>Atribuir Perfis</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Usuário: {{ $usuario->str_nome }}</h5>
        </div>
        <div class="ibox">
            <div class="ibox-content">
                <div class="row atribuir">
                    @if( preg_match('/admin\/perfisusuarios\/atribuirperfis/',\Request::path()) )
                        <form action="{{ url('/admin/perfisusuarios/atribuir') }}" method="POST" id="form">
                    @else
                        <form action="{{ url('/admin/usuarios/atribuir') }}" method="POST" id="form">
                    @endif
                        {{ csrf_field() }}

                        <div class="form-horizontal col-sm-2">
                            <label for="modulo">Escolha um Módulo:</label><span class="required">*</span>
                            <input type="hidden" name="int_usuario_id" value="{{$usuario->int_usuario_id}}" />
                            @if(isset($modulosNaoVinculados))
                                <select name="modulo" id="modulo" class="form-control select input-lg" aria-required="true" required>
                                    @foreach($modulosNaoVinculados as $key => $modulo)
                                        <option value="{{ $key }}">{{ $modulo }}</option>
                                    @endforeach
                                </select>
                            @else
                                <select name="modulo" id="modulo" class="form-control select input-lg" aria-required="true" required>
                                        <option></option>
                                </select>
                            @endif
                        </div>
                    </form>
                </div>
                <br />
        @if(count($perfis))
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>Módulo</th>
                        <th>Perfil</th>
                        <th>Descrição do Perfil</th>
                        <th style="width: 120px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($perfis as $perfil)
                        <tr>
                            <td>{{ $perfil->mod_nome }}</td>
                            <td>{{ $perfil->str_nome }}</td>
                            <td>{{ $perfil->str_descricao }}</td>
                            <td class="text-center">
                                @if( preg_match('/admin\/perfisusuarios\/atribuirperfis/',\Request::path()) )
                                    <form action="{{ url('/') }}/admin/perfisusuarios/desvincularperfil" method="POST">
                                @else
                                    <form action="{{ url('/') }}/admin/usuarios/desvincularperfil" method="POST">
                                @endif
                                    <input type="hidden" name="_token" value="{{csrf_token()}}" />
                                    <input type="hidden" name="int_usuario_id" value="{{$usuario->int_usuario_id}}" />
                                    <input type="hidden" name="int_perfil_id" value="{{$perfil->int_perfil_id}}" />
                                    <button type="submit" aria-label="Desvincular perfil {{ $perfil->str_nome }}" class="btn btn-danger btn-xs btn-excluir"><i class="fa fa-remove"></i></button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
        @endif

    </div>

@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/bootbox/bootbox.js') }}"></script>

    <script type="text/javascript">
            $(".btn-excluir").on("click" , function(e){
                $this = $(this);

                bootbox.confirm("Você tem certeza que deseja deletar esse registro?", function(result) {
                    if(result) {
                        $this.closest('form').submit();
                    }
                });

                e.preventDefault();
            });

            var baseUrl = "{{ url('/') }}";

            $( "#modulo" ).change(function() {
                if($(this).val() == 0){
                    $( ".divPerfis" ).remove();
                    $( ".btnAtribuir" ).remove();
                } else {
                    var urlPerfisAjax = baseUrl + '/admin/perfisusuarios/perfis?id=' + $( "#modulo" ).val();
                    $.getJSON( urlPerfisAjax, function( data ) {
                        $( ".divPerfis" ).remove();
                        $( ".btnAtribuir" ).remove();
                        $( "<div class='form-horizontal col-sm-2 divPerfis'>" ).appendTo( $( "#form" ) );
                        $( "<label>Escolha um Perfil:</label>" ).appendTo( $( ".divPerfis" ) );
                        $( "<select class='form-control select input-lg perfis' name='int_perfil_id'>" ).appendTo( $( ".divPerfis" ) );
                        $( "<div class='form-horizontal col-sm-2 divPerfis'><button type='submit' class='btn btn-primary  btnAtribuir'>Atribuir Perfil</button>" ).appendTo( $( "#form" ) );
                        var id;
                        for (id in data) {
                            $( "<option value="+ id +">"+data[id] +"</option>" ).appendTo( $( ".perfis" ) );
                        }
                        console.log( data.length );
                    })
                }
            });

    </script>
@stop