@extends('layouts.admin')

@section('titulo')
    <h2>Cadastrar Novo Usuário</h2>
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
                    <a href="{{url('')}}/admin/usuarios">Usuários</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Novo Usuário</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Adicionar Usuário</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/usuarios/create') }}" method="POST" id="form">
                {{ @csrf_field() }}

                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="str_nome" class="control-label">Nome</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_nome') }}" name="str_nome" id="str_nome" class="form-control" placeholder="Nome completo" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="str_usuario" class="control-label">Usuário</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_usuario') }}" name="str_usuario" id="str_usuario" class="form-control" placeholder="Nome de usuário" required>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="int_cpf" class="control-label">CPF</label>
                        <input type="text" value="{{ old('int_cpf') }}" name="int_cpf" id="int_cpf" class="form-control" placeholder="CPF do usuário">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="str_cargo" class="control-label">Cargo</label>
                        <input type="text" value="{{ old('str_cargo') }}" name="str_cargo" id="str_cargo" class="form-control" placeholder="Cargo">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="str_email" class="control-label">Email</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_email') }}" name="str_email" id="str_email" class="form-control" placeholder="E-mail do usuário (Informe um E-mail válido)" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="str_telefone" class="control-label">Telefone</label>
                        <input type="text" value="{{ old('str_telefone') }}" name="str_telefone" id="str_telefone" class="form-control" placeholder="Número de telefone">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                        <select name="bol_ativo" id="bol_ativo" class="form-control" required>
                            <option value="true">Ativo</option>
                            <option value="false">Inativo</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="cliente_id" class="control-label">Cliente</label>
                        <select name="cliente_id" id="cliente_id" class="form-control">
                            <option value="">Selecione</option>
                            @foreach($clientes as $cliente)
                                <option value="{{ $cliente->int_cliente_id }}">{{ $cliente->str_nome }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group col-md-12">
                        <button class="btn btn-primary">Adicionar</button>
                    </div>
                </div>
            </form>
        </div> <!-- /.ibox-content -->
    </div>
    
@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/maskedinput/maskedinput.js') }}"></script>


    <script type="text/javascript">

        $("#int_cpf").mask("999.999.999-99");

    </script>
@stop