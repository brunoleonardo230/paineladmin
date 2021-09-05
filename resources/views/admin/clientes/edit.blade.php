@extends('layouts.admin')

@section('stylesheets')
    <style href="{{ asset('/public_calendario/vendor/bootstrap-duallistbox/bootstrap-duallistbox.css') }}"></style>
    <style>
        div.box1 > div.btn-group.buttons{
            margin-top: 10px;
        }
        div.box2 > div.btn-group.buttons{
            margin-top: 10px;
        }
    </style>
@stop
@section('titulo')
    <h2>Editar Cliente</h2>
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
                    <strong>Editar Cliente</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-content">
            <form action="{{ url('/admin/clientes/cliente') }}" method="POST" id="form">
                {{ @csrf_field() }}
                
                <input type="hidden" value="{{ $cliente->int_cliente_id }}" name="int_cliente_id" id="int_cliente_id">

                <div class="row">
                    <div class="form-group col-md-12">
                        <label for="str_nome" class="control-label">Nome</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_nome') ?? $cliente->str_nome }}" name="str_nome" id="str_nome" class="form-control" placeholder="Nome completo" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="dta_data_inicio_contrato" class="control-label">Data de início do contrato</label><span class="required">*</span>
                        <input type="date" value="{{ old('dta_data_inicio_contrato') ?? date_create_from_format('d/m/Y', $cliente->dta_data_inicio_contrato)->format('Y-m-d') }}" name="dta_data_inicio_contrato" id="dta_data_inicio_contrato" class="form-control" placeholder="Data do início do contrato" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                        <select name="bol_ativo" id="bol_ativo" class="form-control" required>
                            <option selected="{{ $cliente->bol_ativo?? false }}" value="true">Ativo</option>
                            <option selected="{{ !$cliente->bol_ativo?? false }}" value="false">Inativo</option>
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
    <script src="{{ asset('/public_calendario/vendor/bootstrap-duallistbox/jquery.bootstrap-duallistbox.js') }}"></script>
    <script src="{{ asset('/js/plugins/maskedinput/maskedinput.js') }}"></script>
    <script src="{{ asset('/js/plugins/bootbox/bootbox.js') }}"></script>
@stop