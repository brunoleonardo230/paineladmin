@extends('layouts.admin')

@section('titulo')
    <h2>Permissões</h2>
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
                    <strong>Permissões</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
            <a href="{{ url('/') }}/admin/permissoes/create" class="pull-right btn btn-w-m btn-info" title="Criar novo recurso"><i class="fa fa-plus"></i> Criar nova permissão</a>
        </div>
    </div>

    @if(count($permissoes))
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Módulo</th>
                        <th>Recurso</th>
                        <th>Permissão</th>
                        <th>Rota</th>
                        <th>Descrição</th>
                        <th style="width: 60px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($permissoes as $permissao)
                        <tr>
                            <td>{{ $permissao->int_permissao_id }}</td>
                            <td>{{ $permissao->modulo }}</td>
                            <td>{{ $permissao->recurso }}</td>
                            <td>{{ $permissao->str_nome }}</td>
                            <td>{{ $permissao->modulo }}/{{ $permissao->recurso }}/{{ $permissao->str_nome }}</td>
                            <td>{{ $permissao->str_descricao }}</td>
                            <td class="text-center">
                                <form action="{{ url('/') }}/admin/permissoes/delete" method="POST">
                                    <input type="hidden" name="_token" value="{{csrf_token()}}" />
                                    <input type="hidden" name="int_permissao_id" value="{{$permissao->int_permissao_id}}" />
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