@extends('layouts.contratta')

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
                <li>
                    <a href="{{url('')}}/admin/unidades/index">Unidades</a>
                </li>
                <li class="active">
                    <strong>Editar Unidade</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h3>Formulário de edição de unidade</h3>
        </div>
        <div class="ibox-content">
            {!! Form::model($unidade, ["url" => "/admin/unidades/edit", "method" => "POST", "id" => "form", "role" => "form"]) !!}

            <input type="hidden" value="{{$unidade->int_unidade_id}}">

            <div class="row">
                <div class="form-group col-md-3 @if ($errors->has('int_unidade_id')) has-error @endif">
                    {!! Form::label('int_unidade_id', 'ID da Unidade', ['class' => 'control-label']) !!} <span class="required">*</span>
                    <div class="input-group col-lg-12">
                        {!! Form::text('int_unidade_id', old('int_unidade_id'), ['class'=>'form-control', 'aria-required'=>'true', 'required'=>'required', 'id' => 'int_unidade_id', 'placeholder' => 'Código da UG']) !!}
                        @if ($errors->has('int_unidade_id')) <p class="help-block">{{ $errors->first('int_unidade_id') }}</p> @endif
                    </div>
                </div>
                <div class="form-group col-md-6 @if ($errors->has('str_unidade')) has-error @endif">
                    {!! Form::label('str_unidade', 'Unidade', ['class' => 'control-label']) !!} <span class="required">*</span>
                    <div class="input-group col-lg-12">
                        {!! Form::text('str_unidade', old('str_unidade'), ['class'=>'form-control', 'aria-required'=>'true', 'required'=>'required', 'id' => 'str_unidade', 'placeholder' => 'Nome da UG']) !!}
                        @if ($errors->has('str_unidade')) <p class="help-block">{{ $errors->first('str_unidade') }}</p> @endif
                    </div>
                </div>
                <div class="form-group col-md-3 @if ($errors->has('str_sigla')) has-error @endif">
                    {!! Form::label('str_sigla', 'Sigla', ['class' => 'control-label']) !!}
                    <div class="input-group col-lg-12">
                        {!! Form::text('str_sigla', old('str_sigla'), ['class'=>'form-control', 'id' => 'str_sigla', 'placeholder' => 'Sigla']) !!}
                        @if ($errors->has('str_sigla')) <p class="help-block">{{ $errors->first('str_sigla') }}</p> @endif
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-md-4 @if ($errors->has('str_cnpj_unidade')) has-error @endif">
                    {!! Form::label('str_cnpj_unidade', 'CNPJ da Unidade', ['class' => 'control-label']) !!}
                    <div class="input-group col-lg-12">
                        {!! Form::text('str_cnpj_unidade', old('str_cnpj_unidade'), ['class'=>'form-control', 'id' => 'str_cnpj_unidade', 'placeholder' => 'CNPJ da Unidade']) !!}
                        @if ($errors->has('str_cnpj_unidade')) <p class="help-block">{{ $errors->first('str_cnpj_unidade') }}</p> @endif
                    </div>
                </div>
                <div class="form-group col-md-4 @if ($errors->has('str_cpf_representante')) has-error @endif">
                    {!! Form::label('str_cpf_representante', 'CPF do Representante', ['class' => 'control-label']) !!}
                    <div class="input-group col-lg-12">
                        {!! Form::text('str_cpf_representante', old('str_cpf_representante'), ['class'=>'form-control', 'id' => 'str_cpf_representante', 'placeholder' => 'CPF do Representante']) !!}
                        @if ($errors->has('str_cpf_representante')) <p class="help-block">{{ $errors->first('str_cpf_representante') }}</p> @endif
                    </div>
                </div>
                <div class="form-group col-md-4 @if ($errors->has('str_nome_representante')) has-error @endif">
                    {!! Form::label('str_nome_representante', 'Nome do Representante', ['class' => 'control-label']) !!}
                    <div class="input-group col-lg-12">
                        {!! Form::text('str_nome_representante', old('str_nome_representante'), ['class'=>'form-control', 'id' => 'str_nome_representante', 'placeholder' => 'Nome do Representante']) !!}
                        @if ($errors->has('str_nome_representante')) <p class="help-block">{{ $errors->first('str_nome_representante') }}</p> @endif
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-md-12">
                    {!! Form::submit('Salvar dados', ['class' => 'btn btn-primary']) !!}
                </div>
            </div>
            {!! Form::close() !!}
        </div>
    </div>
@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/maskedinput/maskedinput.js') }}"></script>
    <script type="text/javascript">
        $(document).ready(function(e){
            $("#int_unidade_id").attr("readonly","readonly");
            $("#str_unidade").attr("readonly","readonly");

            $("#str_cpf_representante").mask("999.999.999-99");
            $("#str_cnpj_unidade").mask("99.999.999/9999-99");
        });
    </script>
@endsection