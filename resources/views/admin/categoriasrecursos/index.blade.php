@extends('layouts.admin')

@section('titulo')
    <h2>Categorias de Recursos</h2>
@stop

@section('content')
    <div class="row">
        <div class="col-lg-10">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('/')}}">App</a>
                </li>
                <li>
                    <a href="{{url('/')}}/admin/index">Admin</a>
                </li>
                <li class="active">
                    <strong>Categorias de Recursos</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
            <a href="{{ url('/') }}/admin/categoriasrecursos/create" class="pull-right btn btn-w-m btn-info" title="Criar nova categoria"><i class="fa fa-plus"></i> Criar Nova Categoria</a>
        </div>
    </div>

    @if($categoriasrecursos->count())
        <div class="ibox float-e-margins wrapper wrapper-content">
            <div class="ibox-content">
                <table class="table table-bordered table-hover data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome da categoria</th>
                        <th>Ordem da categoria</th>
                        <th style="width: 60px;">Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($categoriasrecursos as $categoria)
                        <tr>
                            <td>{{ $categoria->int_categoria_recurso_id }}</td>
                            <td>{{ $categoria->str_nome }}</td>
                            <td>{{ $categoria->int_ordem }}</td>
                            <td class="text-center">
                                <form action="{{ url('/') }}/admin/categoriasrecursos/delete" method="POST">
                                    <input type="hidden" name="_token" value="{{csrf_token()}}" />
                                    <input type="hidden" name="int_categoria_recurso_id" value="{{$categoria->int_categoria_recurso_id}}" />
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