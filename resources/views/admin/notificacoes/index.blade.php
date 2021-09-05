@extends('layouts.admin')

@section('titulo')
    <h2>Notificações do Sistema</h2>
@stop

@section('content')
    <div class="row">
        <div class="col-lg-10">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('')}}">App</a>
                </li>
                <li>
                    <a href="{{url('')}}/admin/index">Admin</a>
                </li>
                <li class="active">
                    <strong>Notificações</strong>
                </li>
            </ol>
        </div>
    
        <div class="col-lg-2">
                <a href="{{ url('/') }}/admin/notificacoes/create" class="pull-right btn btn-w-m btn-info" title="Criar Nova Notificação"><i class="fa fa-plus"></i> Criar Nova Notificação</a>
        </div>
    </div>

     @if($notificacoes->count())
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Titulo</th>
                        <th>Sistema</th>
                        <th>Data Inicio</th>
                        <th>Data Fim</th>
                        <th style="width: 15%;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($notificacoes as $notificacao)
                        <tr>
                            <td>{{ $notificacao->int_mensagem_id }}</td>
                            <td>{{ $notificacao->str_titulo }}</td> 
                            <td class="text-left">
                                <span class="label label-default">
                                    <i class="fa {{$notificacao['str_icone']}}"></i>
                                    {{ucfirst($notificacao['str_nome'])}}
                                </span>
                            </td>
                            <td>{{date('d/m/Y', strtotime($notificacao->dta_ini))}}</td>
                            <td>{{date('d/m/Y', strtotime($notificacao->dta_fim))}}</td>
                            <td class="text-center">
                                <a href="{{url('admin/notificacoes/view/' . $notificacao->int_mensagem_id)}}" class="btn btn-sm btn-primary">
                                    <i class="fa fa-eye"></i>
                                </a>
                                <a href="{{url('admin/notificacoes/edit/' . $notificacao->int_mensagem_id)}}" class="btn btn-sm btn-primary">
                                    <i class="fa fa-pencil"></i>
                                </a>
 								<a href="{{url('admin/notificacoes/delete/' . $notificacao->int_mensagem_id)}}" class="btn btn-sm btn-danger btn-excluir">
 									<i class="fa fa-trash"></i>
 								</a>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    @endif
@stop
@section('scripts')
    <script src="{{ asset('/js/plugins/bootbox/bootbox.js') }}"></script>

    <script type="text/javascript">
        $(".btn-excluir").on("click" , function(e){
            $this = $(this);

            bootbox.confirm("Você tem certeza que deseja deletar esse registro?", function(result) {
                if(result) {
                    var hrefL = $this.attr("href");
                    
                    window.location.href = hrefL;
                }
            });

            e.preventDefault();
        });
    </script>
@stop