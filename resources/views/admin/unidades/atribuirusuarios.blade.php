@extends('layouts.admin')

@section('titulo')
    <h2>Contratos</h2>
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

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h3>Vincular usuários à unidade: {{ $unidade->str_unidade}}</h3>
        </div>
        <div class="ibox-content">
            {!! Form::open(["url" => "/admin/unidades/atribuirusuarios", "method" => "POST", "role" => "form"]) !!}
            {!! Form::hidden('int_unidade_id', $unidade->int_unidade_id) !!}

            @if(count($usuarios))
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th style="width: 40px;">#</th>
                        <th>Nome do usuário</th>
                        <th>Email</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($usuarios as $usuario)
                        <tr>
                            <td><input type="checkbox" name="usuarios[]" @if($usuario->vinculado) checked="checked" @endif value="{{ $usuario->int_usuario_id }}"></td>
                            <td>{{ $usuario->str_nome }}</td>
                            <td>{{ $usuario->str_email }}</td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            @endif
            <div class="row">
                <div class="form-group col-md-12">
                    {!! Form::submit('Vincular usuários à unidade', ['class' => 'btn btn-primary', 'id' => 'btn-enviar']) !!}
                </div>
            </div>
            {!! Form::close() !!}
        </div>
    </div>
@stop