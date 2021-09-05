@extends('layouts.admin')

@section('titulo')
    <h2>Notificações do Sistema</h2>
@stop

@section('content')
    <div class="row">
        <div class="col-md-12">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('/')}}">App</a>
                </li>
                <li>
                    <a href="{{url('')}}/admin/notificacoes/index">Notificações</a>
                </li>
                <li class="active">
                    <strong>Detalhe de Notificação</strong>
                </li>
            </ol>
        </div>
    </div>

	<div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
        	<div class="pull-right">
	            @if($notificacao->ind_tipo == 'M')
                    <span class="label label-warning">
                        <i class="fa fa-plus-square"></i>
                        Nova Funcionalidade
                    </span>
                @elseif($notificacao->ind_tipo == 'C')
                    <span class="label label-danger">
                        <i class="fa fa-bug"></i>
                        Correção/Alteração
                    </span>
                @endif
        	</div>
            <h3>Detalhe de Notificação</h3>
        </div>
        <div class="ibox-content">
		    <div class="row">
	        	<div class="form-group col-md-12">
		        	<h1>{{$notificacao->str_titulo}}</h1>
		        	<span style="margin: 10px 0px; display: table;">
		        		Cadastrada em {{date("d/m/Y H:i:s", strtotime($notificacao->created_at))}}
		        	</span>
		        	<p>
		        		{!! html_entity_decode($notificacao->str_mensagem) !!}
		        	</p>
		        </div>
		    </div>
        </div>
    </div>
@stop

@section('scripts')

@stop