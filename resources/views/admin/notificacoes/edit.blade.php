@extends('layouts.admin')

@section('titulo')
    <h2>Criar Módulo</h2>
    <link href="{{url('/css/plugins/wysi-editor/style.css')}}" rel="stylesheet"></link>

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
                    <a href="{{url('')}}/admin/notificacoes">Notificações</a>
                </li>
                <li class="active">
                    <strong>Cadastrar Nova Mensagem de Notificação</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Formulário de Nova Mensagem de Notificação</h5>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/notificacoes/edit') }}" method="POST" id="form">
                {{ csrf_field() }}

                <div class="row">
                    <div class="form-group col-md-6 @if ($errors->has('str_titulo')) has-error @endif">
                        <label for="str_titulo" class="control-label">Titulo da Notificação</label>
                        <div class="input-group col-lg-12">
                            <input type="text" name="str_titulo" id="str_titulo" class="form-control" value="{{ old('str_titulo') ? old('str_titulo') : $notificacao->str_titulo }}">
                            @if ($errors->has('str_titulo')) <p class="help-block">{{ $errors->first('str_titulo') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-3 @if ($errors->has('dta_ini')) has-error @endif">
                        <label for="dta_ini" class="control-label">Data Inicio de Exibição</label>
                        <div class="input-group col-lg-12">
                            <input type="text" name="dta_ini" id="dta_ini" class="form-control date" value="{{ old('dta_ini') ? old('dta_ini') : $notificacao->dta_ini }}">
                            @if ($errors->has('dta_ini')) <p class="help-block">{{ $errors->first('dta_ini') }}</p> @endif
                        </div>
                    </div>
                    <div class="form-group col-md-3 @if ($errors->has('dta_fim')) has-error @endif">
                        <label for="dta_fim" class="control-label">Data Fim De Exibição</label>
                        <div class="input-group col-lg-12">
                            <input type="text" name="dta_fim" id="dta_fim" class="form-control date" value="{{ old('dta_fim') ? old('dta_fim') : $notificacao->dta_fim }}">
                            @if ($errors->has('dta_fim')) <p class="help-block">{{ $errors->first('dta_fim') }}</p> @endif
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-12 @if ($errors->has('str_nome')) has-error @endif">
                        <label for="int_sistema_id" class="control-label">Mensagem Para O Módulo</label>
                        <div class="input-group col-lg-12">
                            <select name="int_sistema_id" id="int_sistema_id" class="form-control coletanea" aria-required="true" required>
                                @foreach($modulos as $key => $modulo)
                                    <option value="{{ $key }}" @if($notificacao->int_sistema_id == $key) selected @endif>{{ $modulo }}</option>
                                @endforeach
                            </select>
                            @if ($errors->has('int_sistema_id')) <p class="help-block">{{ $errors->first('int_sistema_id') }}</p> @endif
                        </div>
                    </div>
                </div>
                <div class="form-group @if ($errors->has('str_mensagem')) has-error @endif">
                    <label for="str_mensagem" class="control-label">Descrição Detalhada da Notificação</label>
                    <div class="input-group col-lg-12">
                        <textarea name="str_mensagem" id="str_mensagem" class="form-control">{{ old('str_mensagem')? old('str_mensagem') : $notificacao->str_mensagem }}</textarea>
                        @if ($errors->has('str_mensagem')) <p class="help-block">{{ $errors->first('str_mensagem') }}</p> @endif
                    </div>
                </div>
                
                <div class="form-group @if ($errors->has('bol_ativo')) has-error @endif">
                    <label for="bol_ativo" class="control-label">Tipo Da Notificação</label>
                    <div class="input-group col-lg-12">
                        <select name="ind_tipo" id="ind_tipo" class="form-control" aria-required="true" required>
                            <option value="M" @if($notificacao->ind_tipo == "M") selected @endif>Nova Funcionalidade</option>
                            <option value="C" @if($notificacao->ind_tipo == "C") selected @endif>Alteração/Correção de Bug</option>
                        </select>
                        @if ($errors->has('ind_tipo')) <p class="help-block">{{ $errors->first('ind_tipo') }}</p> @endif
                    </div>
                </div>            
                <div class="form-group @if ($errors->has('ind_tipo')) has-error @endif">
                    <label for="bol_ativo" class="control-label">Status</label>
                    <div class="input-group col-lg-12">
                        <select name="bol_ativo" id="bol_ativo" class="form-control" aria-required="true" required>
                            <option value="true" @if($notificacao->ind_tipo == "true") selected @endif>Ativo</option>
                            <option value="false" @if($notificacao->ind_tipo == "false") selected @endif>Inativo</option>
                        </select>
                        @if ($errors->has('bol_ativo')) <p class="help-block">{{ $errors->first('bol_ativo') }}</p> @endif
                    </div>
                </div>


                <div class="row">
                    <div class="form-group col-md-12">
                        <input type="hidden" name="int_mensagem_id" id="int_mensagem_id" class="form-control">
                        <button class="btn btn-primary">Salvar dados</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/bootstrap-jasny/jasny-bootstrap.js') }}"></script>
            <script src="{{ asset('/js/modernizr.js') }}"></script>
    <script src="{{ asset('/js/plugins/datepicker/datepicker.js') }}"></script>
    <script>
        $("input.date").datepicker();
    </script>
    <script src="{{ asset('/js/plugins/wysi-editor/wysi.js') }}"></script>
    <script src="{{ asset('/js/plugins/wysi-editor/wysi-func.js') }}"></script>
    <script>
        $('textarea').wysihtml5({
                    "font-styles": true,
                    "emphasis": true,
                    "lists": true,
                    "html": false,
                    "link": true,
                    "image": false,
                    "color": false
        });
    </script>
@stop