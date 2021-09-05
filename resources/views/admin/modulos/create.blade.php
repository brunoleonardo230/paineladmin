@extends('layouts.admin')

@section('titulo')
    <h2>Criar Módulo</h2>
@stop

@section('content')
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('/')}}">App</a>
                </li>
                <li>
                    <a href="{{url('/')}}/admin/index">Admin</a>
                </li>
                <li>
                    <a href="{{url('/')}}/admin/modulos">Módulos</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Novo Módulo</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Formulário de Cadastro de Módulos</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/modulos/create') }}" method="POST" id="form">
                {{ @csrf_field() }}
                <div class="row">
                    <div class="form-group col-md-4 @if ($errors->has('str_nome')) has-error @endif">
                        <label for="str_nome" class="control-label">Nome do módulo</label><span class="required">*</span>
                        <div class="input-group col-lg-12" style="padding-bottom: 5px;">
                            <input type="text" name="str_nome" id="str_nome" value="{{ old('str_nome') }}" class="form-control" placeholder="Nome para a url" required>
                            @if ($errors->has('str_nome')) <p class="help-block">{{ $errors->first('str_nome') }}</p> @endif
                        </div>
                        <span><b>modulo</b> / recurso / permissao</span>
                    </div>

                    <div class="form-group col-md-4 @if ($errors->has('str_nome_fantasia')) has-error @endif">
                        <label for="str_nome_fantasia" class="control-label">Nome fantasia do módulo</label><span class="required">*</span>
                        <div class="input-group col-lg-12" style="padding-bottom: 5px;">
                            <input type="text" name="str_nome_fantasia" id="str_nome_fantasia" value="{{ old('str_nome_fantasia') }}" class="form-control" placeholder="Nome que será exibido no painel do app" required>
                            @if ($errors->has('str_nome_fantasia')) <p class="help-block">{{ $errors->first('str_nome_fantasia') }}</p> @endif
                        </div>
                    </div>

                    <div class="form-group col-md-4 @if ($errors->has('str_icone')) has-error @endif">
                        <label for="str_icone" class="control-label">Ícone do módulo</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_icone" id="str_icone" value="{{ old('str_icone') }}" class="form-control" placeholder="Ícones Bootstrap ou Font Awesome" required>
                            @if ($errors->has('str_icone')) <p class="help-block">{{ $errors->first('str_icone') }}</p> @endif
                        </div>
                    </div>
                </div>
                <div class="form-group @if ($errors->has('str_descricao')) has-error @endif">
                    <label for="str_descricao" class="control-label">Descrição do Módulo</label><span class="required">*</span>
                    <div class="input-group col-lg-12">
                        <input type="text" name="str_descricao" id="str_descricao" value="{{ old('str_descricao') }}" class="form-control" placeholder="Descreva a utilidade do módulo" required>
                        @if ($errors->has('str_descricao')) <p class="help-block">{{ $errors->first('str_descricao') }}</p> @endif
                    </div>
                </div>
                <div class="form-group @if ($errors->has('bol_ativo')) has-error @endif">
                    <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                    <div class="input-group col-lg-12">
                        <select name="bol_ativo" id="bol_ativo" class="form-control" required>
                            <option value="true">Ativo</option>
                            <option value="false">Inativo</option>
                        </select>
                        @if ($errors->has('bol_ativo')) <p class="help-block">{{ $errors->first('bol_ativo') }}</p> @endif
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