@extends('layouts.admin')

@section('titulo')
    <h2>Módulos</h2>
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
                    <strong>Migração</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <h5>MIGRAÇÃO DE MÓDULOS DO APP</h5>            
        </div>
        <div class="ibox-content" style="overflow: auto">
            
            <form action="{{ url('/') }}/admin/migracao/migrar-modulo" method="get">
                <div class="col-md-12" style="margin-bottom: 15px">
                    <p class="font-bold">
                        Selecione o Módulo
                    </p>
                    <div class="input-group col-md-12 bootstrap-touchspin">
                        <select required name="modulo_id" class="form-control js-example-basic-single" tabindex="-1"   aria-hidden="true">
                            <option value=""> ----</option>
                            @foreach($modulos as $modulo)
                                <option value="{{ $modulo->int_modulo_id }}">{{ $modulo->str_nome }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>

                <div class="col-md-12">
                    <button class="pull-right btn btn-w-m btn-info" title="Trazer Módulo para este ambiente"><i class="fa fa-exchange"></i> Migrar</button>
                </div>
            </form>

            <div class="col-md-12">
                <h3>Como migrar</h3>

                <p style="text-align: justify; font-size: 11pt">
                    Os módulos listados acima são os do ambiente de HOMOLOGAÇÃO. Selecione o módulo e clique em "migrar" para atualizar ou trazer todas as suas permissões para o ambiente de PRODUÇÃO.
                </p>
                <h3>Serão migrados (criados caso não existam)</h3>
                <p style="text-align: justify; font-size: 11pt">
                    Módulo<br>
                    Categorias<br>
                    Recursos<br>
                    Permissões<br>
                    Perfis<br>
                    Perfis_Permissões
                </p>
                <p style="text-align: justify; font-size: 11pt">
                    OBS.:
                    <br>
                    1 - Esta funcionalidade não migra o SCHEMA do módulo selecionado. Faça a migração do SCHEMA MANUALMENTE.<br>
                    2 - Esta funcionalidade não deleta ou altera qualquer tipo de registro do banco. Caso um módulo, categoria, recurso ou permissão existam, estes não sofrerão alteração e serão reutilizados.
                </p>
            </div>
        </div>
    </div>
@stop
