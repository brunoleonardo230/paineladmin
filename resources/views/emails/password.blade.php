@extends('layouts.email')

@section('content')
    <tbody>
    <tr>
        <td style="font-size: 18px; color: #fff; font-weight: 500; padding: 20px; text-align: center; border-radius: 3px 3px 0 0; background: #1ab394;">
            RECUPERAÇÃO DE SENHA
        </td>
    </tr>
    <tr>
        <td style="padding: 20px;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tbody>
                <tr>
                    <td style="padding: 0 0 20px;">
                        <p>Você solicitou a recuperação de senha através do Sistema de Gestão Unificada da Secretaria de Estado de Transparência e Controle.</p>
                        <p>Para recuperar sua senha é simples, basta clicar no link abaixo e seguir as instruções.</p>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0 0 20px; text-align: center;">
                        <a href="{{ url('password/reset/'.$token) }}" style="text-decoration: none;color: #FFF;background-color: #1ab394;border: solid #1ab394;border-width: 5px 10px;line-height: 2;text-align: center;cursor: pointer;display: inline-block;border-radius: 5px;">
                            Clique aqui para alterar a sua senha
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
@stop