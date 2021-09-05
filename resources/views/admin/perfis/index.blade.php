@extends('layouts.admin')

@section('titulo')
    <h2>Perfis</h2>
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
                    <strong>Perfis</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
            <a href="{{ url('/') }}/admin/perfis/create" class="pull-right btn btn-w-m btn-info" title="Criar novo perfil"><i class="fa fa-plus"></i> Criar novo perfil</a>
        </div>
    </div>

    @if(!empty($perfis))
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Modulo</th>
                        <th>Perfil</th>
                        <th>Descrição</th>
                        <th style="width: 60px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($perfis as $perfil)
                        <tr>
                            <td>{{ $perfil->int_perfil_id }}</td>
                            <td>{{ $perfil->mod_nome }}</td>
                            <td>{{ $perfil->str_nome }}</td>
                            <td>{{ $perfil->str_descricao }}</td>
                            <td class="text-center">
                                <form action="{{ url('/') }}/admin/perfis/delete" method="POST">
                                    <input type="hidden" name="_token" value="{{csrf_token()}}" />
                                    <input type="hidden" name="int_perfil_id" value="{{$perfil->int_perfil_id}}" />
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