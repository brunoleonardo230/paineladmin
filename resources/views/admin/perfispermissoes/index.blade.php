@extends('layouts.admin')

@section('titulo')
    <h2>Perfis Permissões</h2>
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
                    <strong>Perfis Permissões</strong>
                </li>
            </ol>
        </div>
    </div>

    @if(count($perfis))
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Módulo</th>
                        <th>Perfil</th>
                        <th>Descrição do perfil</th>
                        <th style="width: 120px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($perfis as $perfil)
                        <tr>
                            <td>{{ $perfil->int_perfil_id }}</td>
                            <td>{{ $perfil->mod_nome }}</td>
                            <td>{{ $perfil->str_nome }}</td>
                            <td>{{ $perfil->str_descricao }}</td>
                            <td><a class="btn btn-info btn-xs" href="{{ url('') }}/admin/perfispermissoes/atribuirpermissoes/{{$perfil->int_perfil_id}}"><i class="fa fa-check-circle"></i> Atribuir permissões</a></a></td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    @endif
@stop