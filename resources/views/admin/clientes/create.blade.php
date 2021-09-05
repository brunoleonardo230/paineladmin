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
                    <a href="{{url('')}}/admin/usuarios">Clientes</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Novo Cliente</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Adicionar Cliente</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/clientes/cliente') }}" method="POST" id="form">
                {{ @csrf_field() }}
                <input type="hidden" value="" name="int_cliente_id" id="int_cliente_id">

                <div class="row">
                    <div class="form-group col-md-12">
                        <label for="str_nome" class="control-label">Nome</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_nome') }}" name="str_nome" id="str_nome" class="form-control" placeholder="Nome completo" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="dta_data_inicio_contrato" class="control-label">Data de início do contrato</label><span class="required">*</span>
                        <input type="date" value="{{ old('dta_data_inicio_contrato') }}" name="dta_data_inicio_contrato" id="dta_data_inicio_contrato" class="form-control" placeholder="Data do início do contrato" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                        <select name="bol_ativo" id="bol_ativo" class="form-control" required>
                            <option value="true">Ativo</option>
                            <option value="false">Inativo</option>
                        </select>
                    </div>
                </div>
                <div class="row">
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