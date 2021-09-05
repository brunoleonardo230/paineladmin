@extends('layouts.admin')

@section('titulo')
    <h2>Perfis Usuários</h2>
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
                <li class="active">
                    <strong>Perfis Usuários</strong>
                </li>
            </ol>
        </div>
    </div>

    @if(count($usuarios))
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuário</th>
                        <th style="width: 120px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($usuarios as $usuario)
                        <tr>
                            <td>{{ $usuario->int_usuario_id }}</td>
                            <td>{{ $usuario->str_nome }}</td>
                            <td><a class="btn btn-info btn-xs" href="{{ url('') }}/admin/perfisusuarios/atribuirperfis/{{$usuario->int_usuario_id}}"><i class="fa fa-check-circle"></i> Atribuir perfil</a></a></td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    @endif
@stop