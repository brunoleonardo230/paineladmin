@extends('layouts.admin')

@section('titulo')
    <h2>Cadastrar Novo Perfil</h2>
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
                    <a href="{{url('')}}/admin/perfis">Perfis</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Novo Perfil</strong>
                </li>
            </ol>
        </div>
    </div>
    
    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title ">
            <h5>Formulário de cadastro de Perfis</h5>
        </div>

        <div class="ibox-content">
            <form action="/admin/perfis/create" method="POST" id="form">
                {{ csrf_field() }}

                <div class="row">
                    <div class="form-group col-md-12 @if ($errors->has('int_perfil_modulo_id')) has-error @endif">
                        <label for="int_perfil_modulo_id" class="control-label">Modulo</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <select name="int_perfil_modulo_id" id="int_perfil_modulo_id" class="form-control coletanea" aria-required="true" required>
                                @foreach($modulos as $key => $modulo)
                                    <option value="{{ $key }}">{{ $modulo }}</option>
                                @endforeach
                            </select>
                            @if ($errors->has('int_perfil_modulo_id')) <p class="help-block">{{ $errors->first('int_perfil_modulo_id') }}</p> @endif
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-md-6 @if ($errors->has('str_nome')) has-error @endif">
                        <label for="str_nome" class="control-label">Perfil</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_nome" id="str_nome" class="form-control" value="{{ old('str_nome') }}" required placeholder="Nome do perfil">
                            @if ($errors->has('str_nome')) <p class="help-block">{{ $errors->first('str_nome') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-6 @if ($errors->has('str_descricao')) has-error @endif">
                        <label for="str_descricao" class="control-label">Descrição</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_descricao" id="str_descricao" class="form-control" value="{{ old('str_descricao') }}" required placeholder="Descreva a utilidade do perfil">
                            @if ($errors->has('str_descricao')) <p class="help-block">{{ $errors->first('str_descricao') }}</p> @endif
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-md-12">
                        <button class="btn btn-primary">Salvar dados</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/bootstrap-jasny/jasny-bootstrap.js') }}"></script>
@stop