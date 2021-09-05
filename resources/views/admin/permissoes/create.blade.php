@extends('layouts.admin')

@section('titulo')
    <h2>Criar Permissões</h2>
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
                    <a href="{{url('')}}/admin/permissoes">Permissões</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Nova Permissão</strong>
                </li>
            </ol>
        </div>
    </div>
    
    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Formulário de cadastro de Permissões</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/permissoes/create') }}" method="POST" id="form">
                {{ csrf_field() }}

                <div class="row">
                    <div class="form-group col-md-12 @if ($errors->has('int_permissao_recurso_id')) has-error @endif">
                        <label for="int_permissao_recurso_id" class="control-label">Recurso</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <select name="int_permissao_recurso_id" id="int_permissao_recurso_id" class="form-control" aria-required="true" required>
                                @foreach($recursos as $key => $recurso)
                                    <option value="{{ $key }}">{{ $recurso }}</option>
                                @endforeach
                            </select>
                            @if ($errors->has('int_permissao_recurso_id')) <p class="help-block">{{ $errors->first('int_recurso_id') }}</p> @endif
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-md-6 @if ($errors->has('str_nome')) has-error @endif">
                        <label for="str_nome" class="control-label">Permissão</label><span class="required">*</span>
                        <div class="input-group col-lg-12" style="padding-bottom: 5px;">
                            <input type="text" name="str_nome" id="str_nome" required value="{{ old('str_nome') }}" class="form-control" placeholder="Caracteres minúsculos com/sem hífen">
                            @if ($errors->has('str_nome')) <p class="help-block">{{ $errors->first('str_nome') }}</p> @endif
                        </div>
                        <span>modulo / recurso / <b>permissao</b></span>
                    </div>
                    <div class="form-group col-md-6 @if ($errors->has('str_descricao')) has-error @endif">
                        <label for="str_descricao" class="control-label">Descrição</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_descricao" id="str_descricao" required value="{{ old('str_descricao') }}" class="form-control" placeholder="Descreva a utilidade desta permissão">
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