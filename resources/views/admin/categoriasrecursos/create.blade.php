@extends('layouts.admin')

@section('titulo')
    <h2>Cadastrar Nova Categoria</h2>
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
                    <a href="{{url('/')}}/admin/categoriasrecursos">Categorias de Recursos</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Nova Categoria</strong>
                </li>
            </ol>
        </div>
    </div>
    
    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Formulário de Cadastro de Categorias de Recursos</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/categoriasrecursos/create') }}" method="POST" id="form">
                {{ @csrf_field() }}
                
                <div class="row">
                    <div class="form-group col-md-8 @if ($errors->has('str_nome')) has-error @endif">
                        <label for="str_nome" class="control-label">Nome da categoria</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_nome" id="str_nome" class="form-control" placeholder="Nome da categoria em camel case" required value="{{ old('str_nome') }}">
                            @if ($errors->has('str_nome')) <p class="help-block">{{ $errors->first('str_nome') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-4 @if ($errors->has('str_icone')) has-error @endif">
                        <label for="str_icone" class="control-label">Ícone da categoria</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_icone" id="str_icone" value="{{ old('str_icone') }}" class="form-control" placeholder="Ícones Bootstrap ou Font Awesome" required>
                            @if ($errors->has('str_icone')) <p class="help-block">{{ $errors->first('str_icone') }}</p> @endif
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6 @if ($errors->has('int_ordem')) has-error @endif">
                        <label for="int_ordem" class="control-label">Ordem da categoria</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <input type="text" name="int_ordem" id="int_ordem" value="{{ old('int_ordem') }}" class="form-control" placeholder="Número da posição da categoria no menu lateral" required>
                            @if ($errors->has('int_ordem')) <p class="help-block">{{ $errors->first('int_ordem') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-6 @if ($errors->has('bol_ativo')) has-error @endif">
                        <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                        <div class="input-group col-lg-12">
                            <select name="bol_ativo" id="bol_ativo" class="form-control" required>
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