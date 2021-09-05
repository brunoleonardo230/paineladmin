@extends('layouts.admin')

@section('titulo')
    <h2>Cadastrar Novo Recurso</h2>
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
                    <a href="{{url('')}}/admin/recursos">Recursos</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Novo Recurso</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Formulário de Cadastro de Recursos</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/recursos/create') }}" method="POST" id="form">
                {{ csrf_field() }}

                <div class="row">
                    <div class="form-group col-md-6 @if ($errors->has('int_modulo_id')) has-error @endif">
                        <label for="int_modulo_id" class="control-label">Módulo</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <select name="int_modulo_id" id="int_modulo_id" class="form-control coletanea" aria-required="true" required>
                                @foreach($modulos as $key => $modulo)
                                    <option value="{{ $key }}">{{ $modulo }}</option>
                                @endforeach
                            </select>
                            @if ($errors->has('int_modulo_id')) <p class="help-block">{{ $errors->first('int_modulo_id') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-6 @if ($errors->has('int_categoria_recurso_id')) has-error @endif">
                        <label for="int_categoria_recurso_id" class="control-label">Categoria do recurso</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <select name="int_categoria_recurso_id" id="int_categoria_recurso_id" class="form-control coletanea" aria-required="true" required>
                                @foreach($categorias as $key => $categoria)
                                    <option value="{{ $key }}">{{ $categoria }}</option>
                                @endforeach
                            </select>
                            @if ($errors->has('int_categoria_recurso_id')) <p class="help-block">{{ $errors->first('int_categoria_recurso_id') }}</p> @endif
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4 @if ($errors->has('str_nome')) has-error @endif">
                        <label for="str_nome" class="control-label">URL do recurso</label><span class="required">*</span>
                        <div class="input-group col-lg-12" style="padding-bottom: 5px;">
                            <input type="text" name="str_nome" id="str_nome" value="{{ old('str_nome') }}" class="form-control" required placeholder="Caracteres minúsculos com/sem hífen">
                            @if ($errors->has('str_nome')) <p class="help-block">{{ $errors->first('str_nome') }}</p> @endif
                        </div>
                        <span>modulo / <b>recurso</b> / permissao</span>
                    </div>
                    <div class="form-group col-md-8 @if ($errors->has('str_descricao')) has-error @endif">
                        <label for="str_descricao" class="control-label">Nome do recurso</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_descricao" id="str_descricao" value="{{ old('str_descricao') }}" class="form-control" required placeholder="Nome em camel case">
                            @if ($errors->has('str_descricao')) <p class="help-block">{{ $errors->first('str_descricao') }}</p> @endif
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-4 @if ($errors->has('str_icone')) has-error @endif">
                        <label for="str_icone" class="control-label">Ícone do recurso</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_icone" id="str_icone" value="{{ old('str_icone') }}" class="form-control" required placeholder="Ícones Bootstrap ou Font Awesome">
                            @if ($errors->has('str_icone')) <p class="help-block">{{ $errors->first('str_icone') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-4 @if ($errors->has('int_ordem')) has-error @endif">
                        <label for="int_ordem" class="control-label">Ordem do recurso</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="int_ordem" id="int_ordem" value="{{ old('int_ordem') }}" class="form-control" required placeholder="Ordem do recurso no menu lateral">
                            @if ($errors->has('int_ordem')) <p class="help-block">{{ $errors->first('int_ordem') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-4 @if ($errors->has('bol_ativo')) has-error @endif">
                        <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <select name="bol_ativo" id="bol_ativo" class="form-control" aria-required="true" required>
                                <option value="true">Ativo</option>
                                <option value="false">Inativo</option>
                            </select>
                            @if ($errors->has('bol_ativo')) <p class="help-block">{{ $errors->first('bol_ativo') }}</p> @endif
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