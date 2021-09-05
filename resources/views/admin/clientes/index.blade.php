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
            <a class="pull-right btn btn-w-m btn-info" href="{{url('/')}}/admin/clientes/create" role="button">Novo Cliente</a>
        </div>
    </div>
   
    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-content">
            <table class="table table-striped table-hover data-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Data de inicial do contrato</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($clientes as $cliente)
                        <tr>
                            <td>{{ $cliente->str_nome }}</td>
                            <td>{{ $cliente->dta_data_inicio_contrato }}</td>

                            @if ($cliente->bol_ativo == true) <td>Ativo</td>@else <td>Inativo</td> @endif
                            <td>
                                <a href="{{ url('/admin/clientes/edit/'. $cliente->int_cliente_id) }}" class="btn-sm btn-w-m btn-primary" role="button"><i class="fa fa-pencil"></i> </a>
                                {{--<th>
                                        <a href="{{ url('/admin/usuarios/atribuirperfis/'. $user->int_usuario_id) }}" class="btn-sm btn-w-m btn-info">Atribuir perfil</a>
                                        <a href="{{ url('/admin/usuarios/delete/'. $user->int_usuario_id) }}" class="btn-sm btn-w-m btn-danger deletar" role="button">Deletar</a>
                                    </th> 
                                --}}
                            </td>
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