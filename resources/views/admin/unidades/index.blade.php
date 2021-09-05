@extends('layouts.admin')

@section('titulo')
    <h2>Unidades</h2>
@stop

@section('content')
    <div class="row">
        <div class="col-md-12">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('')}}">App</a>
                </li>
                <li>
                    <a href="{{url('')}}/admin/index">Admin</a>
                </li>
                <li class="active">
                    <strong>Unidades</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content" style="margin-bottom: 0; padding-bottom: 0;">
        <div class="ibox-title">
            <h5>Filtrar resultados</h5>
        </div>

        <div class="ibox-content">
            <form role="form" method="GET" class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <label>Código</label>
                        <input type="text" name="int_unidade_id" value="{{Request::input('int_unidade_id')}}" class="form-control" placeholder="Buscar no código da unidade">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label>Unidade</label>
                        <input type="text" name="str_unidade" value="{{Request::input('str_unidade')}}" class="form-control" placeholder="Buscar no nome da unidade">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>Representante</label>
                        <input type="text" name="str_nome_representante" value="{{Request::input('str_nome_representante')}}" class="form-control" placeholder="buscar no nome do representante">
                    </div>
                </div>
                <div class="col-md-2" style="margin-top: 20px;">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-filter"></i> Filtrar resultados</button>
                </div>
            </form>
        </div>
    </div>

    @if(sizeof($unidades))
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <h5>{{$totalItems}} itens encontrados</h5>
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th><a href="{{$baseUrl}}codigo">Código @if($orderBy['field'] == 'codigo' && $orderBy['nextSort'] == 'dsort')<i class="fa fa-sort-up"></i> @else <i class="fa fa-sort-down"></i>@endif</a></th>
                        <th><a href="{{$baseUrl}}unidade">Unidade @if($orderBy['field'] == 'unidade' && $orderBy['nextSort'] == 'dsort')<i class="fa fa-sort-up"></i> @else <i class="fa fa-sort-down"></i>@endif</a></th>
                        <th><a href="{{$baseUrl}}sigla">Sigla @if($orderBy['field'] == 'sigla' && $orderBy['nextSort'] == 'dsort')<i class="fa fa-sort-up"></i> @else <i class="fa fa-sort-down"></i>@endif</a></th>
                        <th><a href="{{$baseUrl}}representante">Representante @if($orderBy['field'] == 'representante' && $orderBy['nextSort'] == 'dsort')<i class="fa fa-sort-up"></i> @else <i class="fa fa-sort-down"></i>@endif</a></th>
                        <th style="width: 40px;"></th>
                        <th style="width: 40px;"></th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($unidades as $unidade)
                        <tr>
                            <td>{{ $unidade->int_unidade_id }}</td>
                            <td>{{ $unidade->str_unidade }}</td>
                            <td>{{ $unidade->str_sigla }}</td>
                            <td>{{ $unidade->str_nome_representante }}</td>
                            <td><a class="btn btn-warning btn-xs" href="{{url('')}}/admin/unidades/edit/{{$unidade->int_unidade_id}}"><i class="fa fa-pencil"></i> Editar Unidade</a></td>
                            <td><a class="btn btn-success btn-xs" href="{{url('')}}/admin/unidades/atribuirusuarios/{{$unidade->int_unidade_id}}"><i class="fa fa-exchange"></i> Vincular usuários</a></td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>

            {!! $unidades->render() !!}

        </div>
    @endif
@stop