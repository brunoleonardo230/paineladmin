@extends('layouts.admin')

@section('stylesheets')
    <style href="{{ asset('/public_calendario/vendor/bootstrap-duallistbox/bootstrap-duallistbox.css') }}"></style>
    <style>
        div.box1 > div.btn-group.buttons{
            margin-top: 10px;
        }
        div.box2 > div.btn-group.buttons{
            margin-top: 10px;
        }
    </style>
@stop
@section('titulo')
    <h2>Editar Usuário</h2>
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
                    <a href="{{url('')}}/admin/usuarios">Usuários</a>
                </li>
                <li class="active">
                    <strong>Editar Usuário</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="ibox float-e-margins wrapper wrapper-content">
        <div class="ibox-title">
            <div class="pull-right">
                <a href="#" class="btn btn-primary bt-sm btn-new-password-temp" data-id="{{$usuario->int_usuario_id}}">
                    <i class="fa fa-key"></i>
                    Gerar Senha Temporária
                </a>
            </div>
            <h5>Alterar Cadastro</h5>
            <div class="clearfix"></div>
        </div>

        <div class="ibox-content">
            <form action="{{ url('/admin/usuarios/edit') }}" method="POST" id="form">
                {{ @csrf_field() }}

                <input type="hidden" value="{{ $usuario->int_usuario_id }}" name="int_usuario_id" id="int_usuario_id">

                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="str_nome" class="control-label">Nome</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_nome') ?? $usuario->str_nome }}" name="str_nome" id="str_nome" class="form-control" placeholder="Nome completo" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="str_usuario" class="control-label">Usuário</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_usuario') ?? $usuario->str_usuario }}" name="str_usuario" id="str_usuario" class="form-control" placeholder="Nome de usuário" required>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="int_cpf" class="control-label">CPF</label>
                        <input type="text" value="{{ old('int_cpf') ?? $usuario->int_cpf }}" name="int_cpf" id="int_cpf" class="form-control" placeholder="CPF do usuário">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="str_cargo" class="control-label">Cargo</label>
                        <input type="text" value="{{ old('str_cargo') ?? $usuario->str_cargo }}" name="str_cargo" id="str_cargo" class="form-control" placeholder="Cargo">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="str_email" class="control-label">Email</label><span class="required">*</span>
                        <input type="text" value="{{ old('str_email') ?? $usuario->str_email }}" name="str_email" id="str_email" class="form-control" placeholder="E-mail do usuário (Informe um E-mail válido)" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="str_telefone" class="control-label">Telefone</label>
                        <input type="text" value="{{ old('str_telefone') ?? $usuario->str_telefone }}" name="str_telefone" id="str_telefone" class="form-control" placeholder="Número de telefone">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="bol_ativo" class="control-label">Status</label><span class="required">*</span>
                        <select name="bol_ativo" id="bol_ativo" class="form-control" required>
                            <option @if($usuario->bol_ativo == true) selected @endif value="true">Ativo</option>
                            <option @if($usuario->bol_ativo == false) selected @endif value="false">Inativo</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="cliente_id" class="control-label">Cliente</label>
                        <select name="cliente_id" id="cliente_id" class="form-control">
                            <option value="">Selecione</option>
                            @foreach($clientes as $cliente)
                                <option @if($usuario->cliente_id == $cliente->int_cliente_id) selected @endif value="{{ $cliente->int_cliente_id }}">{{ $cliente->str_nome }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group col-md-12">
                        <button class="btn btn-primary">Salvar</button>
                    </div>
                </div>
            </form>
        </div> <!-- /.ibox-content -->
    </div>
@stop

@section('scripts')
    <script src="{{ asset('/public_calendario/vendor/bootstrap-duallistbox/jquery.bootstrap-duallistbox.js') }}"></script>
    <script src="{{ asset('/js/plugins/maskedinput/maskedinput.js') }}"></script>
    <script type="text/javascript">
        //Lista de Unidades
        $('.duallistbox').bootstrapDualListbox({
            filterTextClear:"Exibir tudo",
            infoText:"Exibindo {0}",
            infoTextEmpty:"Lista limpa",
            filterPlaceHolder:"Pesquisar Unidade",
            moveSelectedLabel:"Adicionar",
            moveAllLabel:"Adicionar todos",
            removeSelectedLabel:"Remover",
            removeAllLabel:"Remover todos"
        });
        // mascara de CPF
        $("#int_cpf").mask("999.999.999-99");
        // Documentos em anexo
        $('#str_documento').change(function (e) {
            var fileName = '';
            var extensao = '';

            if ( e.target.value ) {
                fileName = e.target.value.split( '\\' ).pop();
                extensao = fileName.match(/\.(.+?)\w+/g);
            }

            if (extensao[0] !== ".pdf") {
                alert("Documento inválido. Isso pode ocorre quando o Documento não é do tipo (.PDF) ou o nome do arquivo possuí ponto(.) entre as palavras.");
                document.getElementById("str_documento").value = "";
            }

        });
    </script>
    <script src="{{ asset('/js/plugins/bootbox/bootbox.js') }}"></script>
    <script>
        $("a.btn-new-password-temp").click(function(){
            var $this = $(this);
            $this.addClass('disabled');
            $this.html('<i class="fa fa-spin fa-spinner"></i> Gerando nova senha...');

            $.post("{{url('/admin/usuarios/generatenewpassword')}}", {'_token': "{{csrf_token()}}", 'usuario_id': $this.data('id')},function(d){
                if(!d.status) {
                    bootbox.alert("Erro ao gerar nova senha!", function(){
                        $this.html('<i class="fa fa-key"></i> Gerar Senha Temporária');
                        $this.removeClass('disabled');
                        return false;
                    });
                }

                bootbox.alert("Senha gerada e enviada para " + d.status,function(){
                    $this.html('<i class="fa fa-key"></i> Gerar Senha Temporária');
                    $this.removeClass('disabled');
                    console.log(d);
                });
            }, 'json');

            return false;
        });
    </script>
@stop