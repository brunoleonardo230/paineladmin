@extends('layouts.email')

@section('content')
    <tbody>
    <tr>
        <td style="font-size: 18px; color: #fff; font-weight: 500; padding: 20px; text-align: center; border-radius: 3px 3px 0 0; background: #1ab394;">
            AVISO DE DANO
        </td>
    </tr>
    <tr>
        <td style="padding: 20px;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tbody>
                <tr>
                    <td style="padding: 0 0 20px;">
                        <p>
                            Tipo de Documento: <strong>{{ $str_tipo_documento }}</strong>
                        </p>
                        <p>
                            Valor Estimado do Dano: <strong>{{ $int_valor_estimado }}</strong>
                        </p>
                        <p> Setor que identificou: <b> {{ $str_setor }} </b></p>
                        <p> Unidade: <b> {{ $str_unidade }} </b></p>
                        @if( !empty($str_cnpj_unidade) )<p> CNPJ Unidade: <b> {{ $str_cnpj_unidade }} </b></p>
                        @endif
                        @if( !empty($str_cpf_representante) )<p> CPF Representante:<b> {{ $str_cpf_representante }} </b></p>
                        @endif
                        @if( !empty($str_nome_representante) )<p> Nome Representante: <b> {{ $str_nome_representante }} </b></p>
                        @endif
                        @if( !empty($str_descricao) )<p> Descrição: <b> {{ $str_descricao }} </b></p>
                        @endif
                    </td>
                </tr>
<!--                 <tr>
                    <td style="padding: 0 0 20px; text-align: center;">
                        <a href="{{ url('auth/login') }}" style="text-decoration: none;color: #FFF;background-color: #1ab394;border: solid #1ab394;border-width: 5px 10px;line-height: 2;text-align: center;cursor: pointer;display: inline-block;border-radius: 5px;">
                            Clique aqui para acessar o painel.
                        </a>
                    </td>
                </tr> -->
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
@stop