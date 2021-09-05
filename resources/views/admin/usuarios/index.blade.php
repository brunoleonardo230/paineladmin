@extends('layouts.admin')

@section('titulo')
    <h2>Usuários</h2>
@stop

@section('stylesheets')
    <style type="text/css">
        div.dataTables_filter label {
          float: right;
          font-weight: normal;
        }

        div.dataTables_paginate {
          float: right;
          margin: 0;
        }
        
        .breadcrumb {
              padding-top: 10px;
        }
    </style>
@stop

@section('content')
    <div class="row">
        <div class="col-md-10">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('')}}">App</a>
                </li>
                <li>
                    <a href="{{url('')}}/admin/index">Admin</a>
                </li>
                <li class="active">
                    <strong>Usuários</strong>
                </li>
            </ol>
        </div>
        <div class="col-md-2">
            <a class="pull-right btn btn-w-m btn-info" href="{{url('/')}}/admin/usuarios/create" role="button">Novo Usuário</a>
        </div>
    </div>
   
    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-content">
            <table class="table table-striped table-hover data-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Usuário</th>
                        <th>Email</th>
                        <th>Telefone</th>
                        <th>Status</th>
                        <th class="col-md-2 col-lg-3">Opções</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($users as $user)
                        <tr>
                            <td>{{ $user->str_nome }}</td>
                            <td>{{ $user->str_usuario }}</td>
                            <td>{{ $user->str_email }}</td>
                            <td>{{ $user->str_telefone }}</td>
                            @if ($user->bol_ativo == true) <td>{{ "Ativo" }}</td>@else <td>{{ "Inativo" }}</td> @endif
                            <th>
                                <a href="{{ url('/admin/usuarios/atribuirperfis/'. $user->int_usuario_id) }}" class="btn-sm btn-w-m btn-info">Atribuir perfil</a>
                                <a href="{{ url('/admin/usuarios/edit/'. $user->int_usuario_id) }}" class="btn-sm btn-w-m btn-primary" role="button">Editar</a>
                                <a href="{{ url('/admin/usuarios/delete/'. $user->int_usuario_id) }}" class="btn-sm btn-w-m btn-danger deletar" role="button">Deletar</a>
                            </th>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/datatables/datatebles.js') }}"></script>
    <script src="{{ asset('/js/plugins/bootbox/bootbox.js') }}"></script>

    <script type="text/javascript">
        var baseUrl = "{{ url('/') }}";
        $("#data-table").DataTable();

        $("a.deletar").click(function( event ){
            var elemento = this;
            event.preventDefault();
            bootbox.confirm("Você tem certeza que deseja deletar?", function(result) {
                window.location = baseUrl + '/admin/' + $(elemento).attr('href');
            });
        })
    </script>
@endsection