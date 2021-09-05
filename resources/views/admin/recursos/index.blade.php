@extends('layouts.admin')

@section('titulo')
    <h2>Recursos</h2>
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
                    <strong>Recursos</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
            <a href="{{ url('/') }}/admin/recursos/create" class="pull-right btn btn-w-m btn-info" title="Criar novo recurso"><i class="fa fa-plus"></i> Criar Novo Recurso</a>
        </div>
    </div>

    @if(count($recursos))
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Módulo do recurso</th>
                        <th>Categoria do recurso</th>
                        <th>Nome do recurso</th>
                        <th>Ordem do recurso</th>
                        <th style="width: 60px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($recursos as $recurso)
                        <tr>
                            <td>{{ $recurso->int_recurso_id }}</td>
                            <td>{{ $recurso->modulo }}</td>
                            <td>{{ $recurso->categoria_recurso }}</td>
                            <td>{{ $recurso->str_nome }}</td>
                            <td>{{ $recurso->int_ordem }}</td>
                            <td class="text-center">
                                <form action="{{ url('/') }}/admin/recursos/delete" method="POST">
                                    <input type="hidden" name="_token" value="{{csrf_token()}}" />
                                    <input type="hidden" name="int_recurso_id" value="{{$recurso->int_recurso_id}}" />
                                    <button type="submit" aria-label="Excluir registro?" class="btn btn-danger btn-xs btn-excluir"><i class="fa fa-remove"></i></button>
                                </form>
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
                    $this.closest('form').submit();
                }
            });

            e.preventDefault();
        });
    </script>
@stop