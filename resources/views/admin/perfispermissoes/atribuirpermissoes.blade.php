@extends('layouts.admin')

@section('stylesheets')
    <link href="{{ asset('/css/plugins/jstree/jstree.css') }}" rel="stylesheet"/>
@stop

@section('titulo')
    <h2>Atribuir Permissões</h2>
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
                    <a href="{{url('')}}/admin/perfispermissoes">Perfis Permissões</a>
                </li>
                <li class="active">
                        <strong>Atribuir Permissões</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>Módulo: {{ $perfil->mod_nome }} .:. Perfil: {{ $perfil->str_nome }} .:. <small>{{ $perfil->str_descricao }}</small> </h5>
        </div>
        <div class="ibox-content">
            <div id="jstree">
                <ul>
                    @if(count($permissoes))
                        @foreach($permissoes as $permissao)
                            <li>{{ ucfirst($permissao['str_nome']) }}
                                @if(count($permissao['permissoes']))
                                    <ul>
                                        @foreach($permissao['permissoes'] as $perm)
                                            <li
                                                @if($perm['habilitado'])
                                                    data-jstree='{"selected":"true", "type":"sub"}'
                                                @else
                                                    data-jstree='{"type":"sub"}'
                                                @endif
                                                id="prm_{{$perm['int_permissao_id']}}">
                                                    {{ $perm['prm_nome'] }}
                                            </li>
                                        @endforeach
                                    </ul>
                                @endif
                            </li>
                        @endforeach
                    @endif
                </ul>
            </div>

            <form action="{{ url('/admin/perfispermissoes/atribuirpermissoes') }}" method="POST">
                {{ @csrf_field() }}

                <input type="hidden" name="permissoes" id="permissoes">
                <input type="hidden" name="int_perfil_id" id="int_perfil_id" value="{{ $perfil->int_perfil_id }}">

                <button class="btn btn-primary" id="btn-enviar">Atribuir permissões ao perfil</button>
            </form>

        </div>
    </div>

@stop

@section('scripts')
    <script src="{{ asset('/js/plugins/jstree/jstree.js') }}"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $('#jstree').jstree({
                'core' : {
                    'check_callback' : true
                },
                'plugins' : [ 'types', 'checkbox' ],
                'types' : {
                    'default' : {
                        'icon' : 'fa fa-folder'
                    },
                    'sub' : {
                        'icon' : 'fa fa-cog'
                    }
                }
            });
        });

        $('#btn-enviar').on('click', function(e){

            e.preventDefault();

            $this = $(this);

            var checked_ids = [];

            var selectedItems = $("#jstree").jstree('get_selected');
            $(selectedItems).each(function(id, element){
                if(element.search(/prm_/) != -1) {
                    checked_ids.push(element.replace(/prm_/, ''));
                }
            });

            $("#permissoes").val(checked_ids.toString());

            $this.closest('form').submit();
        });
    </script>
@stop